import { useState, useMemo } from "react";
import { View, StyleSheet, TextInput, Pressable, Modal, FlatList, Alert, ScrollView, Platform, KeyboardAvoidingView } from "react-native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, TourType } from "@/contexts/DataContext";
import { hapticFeedback } from "@/utils/haptics";
import * as Clipboard from "expo-clipboard";

interface ParsedBus {
  id: string;
  busNumber: string;
  seats: number;
  assignedTourTypeId: string | null;
  assignedGuideName: string | null;
  isAdditional: boolean;
}

interface ParsedGuide {
  id: string;
  name: string;
  assignedTourTypeId: string | null;
  assignedBusId: string | null;
  isAdditional: boolean;
}

interface TourGroup {
  groupName: string;
  tourTypes: TourType[];
}

export default function AllocationScreen() {
  const { theme } = useTheme();
  const { tourTypes } = useData();

  const [inputText, setInputText] = useState("");
  const [showInputModal, setShowInputModal] = useState(false);
  const [buses, setBuses] = useState<ParsedBus[]>([]);
  const [guides, setGuides] = useState<ParsedGuide[]>([]);
  const [showCopyModal, setShowCopyModal] = useState(false);
  const [selectedTourTypeId, setSelectedTourTypeId] = useState<string | null>(null);
  const [showTourPicker, setShowTourPicker] = useState(false);
  const [pickingFor, setPickingFor] = useState<{ type: 'bus' | 'guide'; id: string } | null>(null);

  // Group tour types by allocation group
  const tourGroups = useMemo(() => {
    const groups: Map<string, TourType[]> = new Map();
    const ungrouped: TourType[] = [];

    tourTypes.filter(t => t.isEnabled).forEach(tour => {
      if (tour.allocationGroup) {
        const existing = groups.get(tour.allocationGroup) || [];
        groups.set(tour.allocationGroup, [...existing, tour]);
      } else {
        ungrouped.push(tour);
      }
    });

    const result: TourGroup[] = [];
    groups.forEach((tours, groupName) => {
      result.push({ groupName, tourTypes: tours });
    });
    ungrouped.forEach(tour => {
      result.push({ groupName: tour.name, tourTypes: [tour] });
    });

    return result;
  }, [tourTypes]);

  // Parse bus format: XXX-YY (number-seats)
  const parseBuses = (text: string): ParsedBus[] => {
    const busPattern = /(\d{3})-(\d{2})/g;
    const matches = [...text.matchAll(busPattern)];
    return matches.map((match, index) => ({
      id: `bus-${index}-${Date.now()}`,
      busNumber: match[1],
      seats: parseInt(match[2], 10),
      assignedTourTypeId: null,
      assignedGuideName: null,
      isAdditional: false,
    }));
  };

  // Words that indicate excursion/location names, not guide names
  const excludeWords = [
    'свияжск', 'город', 'казань', 'раифа', 'болгар', 'елабуга', 'чистополь',
    'йошкар', 'ола', 'кремль', 'ночь', 'день', 'вечер', 'утро',
    'экскурсия', 'автобус', 'авт', 'ито', 'итого', 'всего', 'на', 'и',
    'тур', 'маршрут', 'обзорная', 'пешеходная', 'речная', 'ночная'
  ];

  // Parse guide names - must look like "Имя Фамилия" (two capitalized words)
  const parseGuides = (text: string): ParsedGuide[] => {
    const guides: ParsedGuide[] = [];
    let idCounter = 0;
    
    // Pattern for Russian names: Имя Фамилия (two words starting with capital)
    const namePattern = /([А-ЯЁ][а-яё]+)\s+([А-ЯЁ][а-яё]+)/g;
    const matches = [...text.matchAll(namePattern)];
    
    matches.forEach(match => {
      const fullName = match[0];
      const firstName = match[1].toLowerCase();
      const lastName = match[2].toLowerCase();
      
      // Skip if any part is an excluded word
      if (excludeWords.includes(firstName) || excludeWords.includes(lastName)) {
        return;
      }
      
      // Skip if too short (likely abbreviation)
      if (firstName.length < 3 || lastName.length < 3) {
        return;
      }
      
      // Avoid duplicates
      if (!guides.find(g => g.name === fullName)) {
        guides.push({
          id: `guide-${idCounter++}-${Date.now()}`,
          name: fullName,
          assignedTourTypeId: null,
          assignedBusId: null,
          isAdditional: false,
        });
      }
    });

    return guides;
  };

  // Match tour type by finding keyword in text and matching to tour
  const matchTourType = (text: string): TourType | null => {
    const lowerText = text.toLowerCase().trim();
    
    // Extract potential tour keywords from text
    const foundKeywords: { keyword: string; position: number }[] = [];
    
    // Key destination words to look for
    const destinationWords = [
      'свияжск', 'раифа', 'болгар', 'елабуга', 'чистополь', 
      'йошкар', 'кремль', 'город', 'ночь', 'вечер', 'обзорная'
    ];
    
    // Find which keywords are in the text and their positions
    destinationWords.forEach(kw => {
      const pos = lowerText.indexOf(kw);
      if (pos !== -1) {
        foundKeywords.push({ keyword: kw, position: pos });
      }
    });
    
    // Sort by position - use the FIRST mentioned keyword
    foundKeywords.sort((a, b) => a.position - b.position);
    
    if (foundKeywords.length === 0) {
      return null;
    }
    
    const primaryKeyword = foundKeywords[0].keyword;
    
    // First try logistShortName (most accurate)
    for (const tour of tourTypes.filter(t => t.isEnabled)) {
      if (tour.logistShortName) {
        const shortNames = tour.logistShortName.split(',').map(s => s.trim().toLowerCase());
        if (shortNames.some(name => name && name.includes(primaryKeyword))) {
          return tour;
        }
      }
    }
    
    // Then try allocationGroup
    for (const tour of tourTypes.filter(t => t.isEnabled)) {
      if (tour.allocationGroup) {
        const groupLower = tour.allocationGroup.toLowerCase();
        if (groupLower.includes(primaryKeyword)) {
          return tour;
        }
      }
    }
    
    // Then try tour name
    for (const tour of tourTypes.filter(t => t.isEnabled)) {
      const tourNameLower = tour.name.toLowerCase();
      if (tourNameLower.includes(primaryKeyword)) {
        return tour;
      }
    }
    
    return null;
  };

  const handleParse = () => {
    if (!inputText.trim()) {
      Alert.alert("Внимание", "Вставьте данные от логиста");
      return;
    }

    const parsedBuses = parseBuses(inputText);
    const parsedGuides = parseGuides(inputText);

    if (parsedBuses.length === 0 && parsedGuides.length === 0) {
      Alert.alert("Внимание", "Не удалось распознать автобусы или гидов");
      return;
    }

    // Try to auto-detect excursion from text
    const detectedTour = matchTourType(inputText);
    
    // If excursion detected, pre-assign all buses to it
    if (detectedTour) {
      parsedBuses.forEach(bus => {
        bus.assignedTourTypeId = detectedTour.id;
      });
    }

    // Merge with existing data (for additional entries)
    setBuses(prev => {
      const newBuses = parsedBuses.map(b => ({ ...b, isAdditional: prev.length > 0 }));
      return [...prev, ...newBuses];
    });
    setGuides(prev => {
      const newGuides = parsedGuides.map(g => ({ ...g, isAdditional: prev.length > 0 }));
      return [...prev, ...newGuides];
    });

    hapticFeedback.success();
    setInputText("");
    setShowInputModal(false);

    const tourInfo = detectedTour ? `\nЭкскурсия: ${detectedTour.name}` : '';
    Alert.alert(
      "Распознано",
      `Автобусов: ${parsedBuses.length}\nГидов: ${parsedGuides.length}${tourInfo}`
    );
  };

  const handleAssignBusToTour = (busId: string, tourTypeId: string) => {
    setBuses(prev => prev.map(b => 
      b.id === busId ? { ...b, assignedTourTypeId: tourTypeId } : b
    ));
    hapticFeedback.light();
  };

  const handleAssignGuideToTour = (guideId: string, tourTypeId: string) => {
    setGuides(prev => prev.map(g => 
      g.id === guideId ? { ...g, assignedTourTypeId: tourTypeId } : g
    ));
    hapticFeedback.light();
  };

  const handleAssignGuideToBus = (guideId: string, busId: string) => {
    const bus = buses.find(b => b.id === busId);
    if (!bus) return;

    setBuses(prev => prev.map(b => 
      b.id === busId ? { ...b, assignedGuideName: guides.find(g => g.id === guideId)?.name || null } : b
    ));
    setGuides(prev => prev.map(g => 
      g.id === guideId ? { ...g, assignedBusId: busId, assignedTourTypeId: bus.assignedTourTypeId } : g
    ));
    hapticFeedback.light();
  };

  const handleClearAll = () => {
    Alert.alert("Очистить всё?", "Все данные распределения будут удалены", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Очистить",
        style: "destructive",
        onPress: () => {
          setBuses([]);
          setGuides([]);
          hapticFeedback.medium();
        },
      },
    ]);
  };

  // Get unassigned buses and guides
  const unassignedBuses = buses.filter(b => !b.assignedTourTypeId);
  const unassignedGuides = guides.filter(g => !g.assignedTourTypeId);

  // Get buses and guides for a specific tour type
  const getBusesForTour = (tourTypeId: string) => 
    buses.filter(b => b.assignedTourTypeId === tourTypeId);
  const getGuidesForTour = (tourTypeId: string) => 
    guides.filter(g => g.assignedTourTypeId === tourTypeId);

  // Auto-assign 1:1 matches
  const handleAutoAssign = () => {
    let assigned = 0;

    tourGroups.forEach(group => {
      if (group.tourTypes.length === 1) {
        const tour = group.tourTypes[0];
        const tourBuses = getBusesForTour(tour.id);
        const tourGuides = getGuidesForTour(tour.id);

        // If exactly 1 bus and 1 guide for this tour, assign them
        if (tourBuses.length === 1 && tourGuides.length === 1) {
          handleAssignGuideToBus(tourGuides[0].id, tourBuses[0].id);
          assigned++;
        }
      }
    });

    if (assigned > 0) {
      hapticFeedback.success();
      Alert.alert("Авто-распределение", `Назначено ${assigned} связок гид-автобус`);
    } else {
      Alert.alert("Авто-распределение", "Нет подходящих пар для автоматического назначения");
    }
  };

  // Copy formats
  const copyFullList = async () => {
    const lines: string[] = [];
    const today = new Date().toLocaleDateString('ru-RU');
    lines.push(`РАСПРЕДЕЛЕНИЕ НА ${today}\n`);

    tourGroups.forEach(group => {
      group.tourTypes.forEach(tour => {
        const tourBuses = getBusesForTour(tour.id);
        if (tourBuses.length === 0) return;

        lines.push(tour.name.toUpperCase());
        tourBuses.forEach(bus => {
          const guideName = bus.assignedGuideName || '—';
          lines.push(`Авт. ${bus.busNumber} (${bus.seats} м.) → ${guideName}`);
        });
        lines.push('');
      });
    });

    await Clipboard.setStringAsync(lines.join('\n'));
    hapticFeedback.success();
    Alert.alert("Скопировано", "Полный список скопирован в буфер обмена");
  };

  const copyByGuides = async () => {
    const lines: string[] = [];

    guides.filter(g => g.assignedBusId).forEach(guide => {
      const bus = buses.find(b => b.id === guide.assignedBusId);
      const tour = tourTypes.find(t => t.id === guide.assignedTourTypeId);
      
      if (bus && tour) {
        lines.push(`${guide.name}:`);
        lines.push(`Экскурсия: ${tour.name}`);
        lines.push(`Автобус: ${bus.busNumber}`);
        lines.push('');
      }
    });

    if (lines.length === 0) {
      Alert.alert("Внимание", "Нет назначенных гидов");
      return;
    }

    await Clipboard.setStringAsync(lines.join('\n'));
    hapticFeedback.success();
    Alert.alert("Скопировано", "Список по гидам скопирован в буфер обмена");
  };

  const copyAdditional = async () => {
    const additionalBuses = buses.filter(b => b.isAdditional);
    const additionalGuides = guides.filter(g => g.isAdditional);

    if (additionalBuses.length === 0 && additionalGuides.length === 0) {
      Alert.alert("Внимание", "Нет дополнительных данных");
      return;
    }

    const lines: string[] = ['ДОПОЛНИТЕЛЬНО:\n'];

    additionalBuses.forEach(bus => {
      const tour = tourTypes.find(t => t.id === bus.assignedTourTypeId);
      const tourName = tour?.name || 'Не назначено';
      const guideName = bus.assignedGuideName || '—';
      lines.push(`Авт. ${bus.busNumber} (${bus.seats} м.) → ${guideName}`);
      lines.push(`Экскурсия: ${tourName}`);
      lines.push('');
    });

    await Clipboard.setStringAsync(lines.join('\n'));
    hapticFeedback.success();
    Alert.alert("Скопировано", "Дополнения скопированы в буфер обмена");
  };

  const getTourName = (tourTypeId: string | null) => {
    if (!tourTypeId) return null;
    return tourTypes.find(t => t.id === tourTypeId)?.name;
  };

  return (
    <ScreenKeyboardAwareScrollView>
      {/* Header Actions */}
      <View style={styles.headerActions}>
        <Pressable
          style={[styles.actionButton, { backgroundColor: theme.primary }]}
          onPress={() => setShowInputModal(true)}
        >
          <Icon name="plus" size={18} color={theme.buttonText} />
          <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
            Добавить данные
          </ThemedText>
        </Pressable>

        {(buses.length > 0 || guides.length > 0) ? (
          <>
            <Pressable
              style={[styles.actionButton, { backgroundColor: theme.success }]}
              onPress={() => setShowCopyModal(true)}
            >
              <Icon name="copy" size={18} color={theme.buttonText} />
              <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
                Копировать
              </ThemedText>
            </Pressable>

            <Pressable
              style={[styles.actionButton, { backgroundColor: theme.error }]}
              onPress={handleClearAll}
            >
              <Icon name="trash-2" size={18} color={theme.buttonText} />
            </Pressable>
          </>
        ) : null}
      </View>

      {/* Stats */}
      {(buses.length > 0 || guides.length > 0) ? (
        <View style={[styles.statsRow, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.stat}>
            <ThemedText style={[styles.statValue, { color: theme.primary }]}>{buses.length}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>автобусов</ThemedText>
          </View>
          <View style={styles.stat}>
            <ThemedText style={[styles.statValue, { color: theme.primary }]}>{guides.length}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>гидов</ThemedText>
          </View>
          <View style={styles.stat}>
            <ThemedText style={[styles.statValue, { color: theme.success }]}>
              {buses.filter(b => b.assignedGuideName).length}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>назначено</ThemedText>
          </View>
        </View>
      ) : null}

      {/* Empty state */}
      {buses.length === 0 && guides.length === 0 ? (
        <View style={styles.emptyState}>
          <Icon name="clipboard" size={48} color={theme.textSecondary} />
          <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
            Нажмите "Добавить данные" и вставьте информацию от логиста
          </ThemedText>
        </View>
      ) : null}

      {/* Unassigned section */}
      {(unassignedBuses.length > 0 || unassignedGuides.length > 0) ? (
        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Не распределено</ThemedText>
          
          {unassignedBuses.length > 0 ? (
            <View style={styles.itemsRow}>
              <ThemedText style={[styles.itemsLabel, { color: theme.textSecondary }]}>Автобусы:</ThemedText>
              <ScrollView horizontal showsHorizontalScrollIndicator={false}>
                {unassignedBuses.map(bus => (
                  <Pressable
                    key={bus.id}
                    style={[styles.chip, { backgroundColor: theme.backgroundTertiary }]}
                    onPress={() => {
                      setPickingFor({ type: 'bus', id: bus.id });
                      setShowTourPicker(true);
                    }}
                  >
                    <ThemedText style={styles.chipText}>{bus.busNumber}</ThemedText>
                    <ThemedText style={[styles.chipSeats, { color: theme.textSecondary }]}>
                      ({bus.seats})
                    </ThemedText>
                  </Pressable>
                ))}
              </ScrollView>
            </View>
          ) : null}

          {unassignedGuides.length > 0 ? (
            <View style={styles.itemsRow}>
              <ThemedText style={[styles.itemsLabel, { color: theme.textSecondary }]}>Гиды:</ThemedText>
              <ScrollView horizontal showsHorizontalScrollIndicator={false}>
                {unassignedGuides.map(guide => (
                  <Pressable
                    key={guide.id}
                    style={[styles.chip, { backgroundColor: theme.backgroundTertiary }]}
                    onPress={() => {
                      setPickingFor({ type: 'guide', id: guide.id });
                      setShowTourPicker(true);
                    }}
                  >
                    <ThemedText style={styles.chipText}>{guide.name}</ThemedText>
                  </Pressable>
                ))}
              </ScrollView>
            </View>
          ) : null}
        </View>
      ) : null}

      {/* Tour groups */}
      {tourGroups.map(group => {
        const groupBuses = group.tourTypes.flatMap(t => getBusesForTour(t.id));
        const groupGuides = group.tourTypes.flatMap(t => getGuidesForTour(t.id));

        if (groupBuses.length === 0 && groupGuides.length === 0) return null;

        return (
          <View key={group.groupName} style={[styles.tourCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={styles.tourCardTitle}>{group.groupName}</ThemedText>
            
            {group.tourTypes.length > 1 ? (
              <View style={styles.subTours}>
                {group.tourTypes.map(tour => {
                  const tourBuses = getBusesForTour(tour.id);
                  const tourGuides = getGuidesForTour(tour.id);
                  
                  return (
                    <View key={tour.id} style={styles.subTour}>
                      <ThemedText style={[styles.subTourName, { color: theme.primary }]}>
                        {tour.name}
                      </ThemedText>
                      
                      {tourBuses.map(bus => (
                        <View key={bus.id} style={[styles.assignmentRow, { backgroundColor: theme.backgroundTertiary }]}>
                          <ThemedText style={styles.busInfo}>
                            Авт. {bus.busNumber} ({bus.seats})
                          </ThemedText>
                          <Icon name="arrow-right" size={14} color={theme.textSecondary} />
                          <ThemedText style={[styles.guideName, { color: bus.assignedGuideName ? theme.text : theme.textSecondary }]}>
                            {bus.assignedGuideName || 'Выбрать гида'}
                          </ThemedText>
                        </View>
                      ))}

                      {tourGuides.filter(g => !g.assignedBusId).map(guide => (
                        <View key={guide.id} style={[styles.unassignedGuide, { borderColor: theme.warning }]}>
                          <Icon name="user" size={14} color={theme.warning} />
                          <ThemedText style={[styles.unassignedGuideName, { color: theme.warning }]}>
                            {guide.name} (без автобуса)
                          </ThemedText>
                        </View>
                      ))}
                    </View>
                  );
                })}
              </View>
            ) : (
              <View style={styles.singleTour}>
                {groupBuses.map(bus => (
                  <View key={bus.id} style={[styles.assignmentRow, { backgroundColor: theme.backgroundTertiary }]}>
                    <ThemedText style={styles.busInfo}>
                      Авт. {bus.busNumber} ({bus.seats})
                    </ThemedText>
                    <Icon name="arrow-right" size={14} color={theme.textSecondary} />
                    <ThemedText style={[styles.guideName, { color: bus.assignedGuideName ? theme.text : theme.textSecondary }]}>
                      {bus.assignedGuideName || 'Выбрать гида'}
                    </ThemedText>
                  </View>
                ))}
              </View>
            )}
          </View>
        );
      })}

      {/* Input Modal */}
      <Modal visible={showInputModal} animationType="slide" transparent>
        <KeyboardAvoidingView 
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
          style={styles.modalOverlay}
        >
          <Pressable style={styles.modalBackdrop} onPress={() => setShowInputModal(false)} />
          <ThemedView style={[styles.modal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Вставить данные</ThemedText>
              <Pressable onPress={() => setShowInputModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <ThemedText style={[styles.modalHint, { color: theme.textSecondary }]}>
              Вставьте данные от логиста (автобусы и/или гидов)
            </ThemedText>

            <TextInput
              style={[styles.textArea, { backgroundColor: theme.backgroundSecondary, color: theme.text, borderColor: theme.border }]}
              placeholder="051-53, 921-53, 981-53...&#10;&#10;Нина Максимова&#10;Наталья Никифорова..."
              placeholderTextColor={theme.textSecondary}
              value={inputText}
              onChangeText={setInputText}
              multiline
              textAlignVertical="top"
            />

            <Pressable
              style={[styles.parseButton, { backgroundColor: theme.primary }]}
              onPress={handleParse}
            >
              <Icon name="check" size={20} color={theme.buttonText} />
              <ThemedText style={[styles.parseButtonText, { color: theme.buttonText }]}>
                Распознать
              </ThemedText>
            </Pressable>
          </ThemedView>
        </KeyboardAvoidingView>
      </Modal>

      {/* Tour Picker Modal */}
      <Modal visible={showTourPicker} animationType="fade" transparent>
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowTourPicker(false)} />
          <ThemedView style={[styles.pickerModal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Выберите экскурсию</ThemedText>
              <Pressable onPress={() => setShowTourPicker(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <FlatList
              data={tourTypes.filter(t => t.isEnabled)}
              keyExtractor={item => item.id}
              renderItem={({ item }) => (
                <Pressable
                  style={[styles.tourOption, { borderBottomColor: theme.border }]}
                  onPress={() => {
                    if (pickingFor?.type === 'bus') {
                      handleAssignBusToTour(pickingFor.id, item.id);
                    } else if (pickingFor?.type === 'guide') {
                      handleAssignGuideToTour(pickingFor.id, item.id);
                    }
                    setShowTourPicker(false);
                    setPickingFor(null);
                  }}
                >
                  <ThemedText style={styles.tourOptionText}>{item.name}</ThemedText>
                  {item.allocationGroup ? (
                    <ThemedText style={[styles.tourOptionGroup, { color: theme.textSecondary }]}>
                      Группа: {item.allocationGroup}
                    </ThemedText>
                  ) : null}
                </Pressable>
              )}
            />
          </ThemedView>
        </View>
      </Modal>

      {/* Copy Modal */}
      <Modal visible={showCopyModal} animationType="fade" transparent>
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowCopyModal(false)} />
          <ThemedView style={[styles.copyModal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Копировать</ThemedText>
              <Pressable onPress={() => setShowCopyModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <Pressable
              style={[styles.copyOption, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => { copyFullList(); setShowCopyModal(false); }}
            >
              <Icon name="list" size={20} color={theme.primary} />
              <View style={styles.copyOptionText}>
                <ThemedText style={styles.copyOptionTitle}>Полный список</ThemedText>
                <ThemedText style={[styles.copyOptionDesc, { color: theme.textSecondary }]}>
                  Все автобусы и гиды по экскурсиям
                </ThemedText>
              </View>
            </Pressable>

            <Pressable
              style={[styles.copyOption, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => { copyByGuides(); setShowCopyModal(false); }}
            >
              <Icon name="users" size={20} color={theme.primary} />
              <View style={styles.copyOptionText}>
                <ThemedText style={styles.copyOptionTitle}>По гидам</ThemedText>
                <ThemedText style={[styles.copyOptionDesc, { color: theme.textSecondary }]}>
                  Для отправки каждому гиду
                </ThemedText>
              </View>
            </Pressable>

            <Pressable
              style={[styles.copyOption, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => { copyAdditional(); setShowCopyModal(false); }}
            >
              <Icon name="plus-circle" size={20} color={theme.primary} />
              <View style={styles.copyOptionText}>
                <ThemedText style={styles.copyOptionTitle}>Только изменения</ThemedText>
                <ThemedText style={[styles.copyOptionDesc, { color: theme.textSecondary }]}>
                  Дополнительные автобусы и гиды
                </ThemedText>
              </View>
            </Pressable>
          </ThemedView>
        </View>
      </Modal>
    </ScreenKeyboardAwareScrollView>
  );
}

const styles = StyleSheet.create({
  headerActions: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.lg,
  },
  actionButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  actionButtonText: {
    fontSize: 14,
    fontWeight: "600",
  },
  statsRow: {
    flexDirection: "row",
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.lg,
  },
  stat: {
    flex: 1,
    alignItems: "center",
  },
  statValue: {
    fontSize: 24,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
  },
  emptyState: {
    alignItems: "center",
    paddingVertical: Spacing["2xl"],
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 14,
    textAlign: "center",
    paddingHorizontal: Spacing.xl,
  },
  section: {
    marginBottom: Spacing.lg,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: Spacing.sm,
  },
  itemsRow: {
    marginBottom: Spacing.sm,
  },
  itemsLabel: {
    fontSize: 12,
    marginBottom: Spacing.xs,
  },
  chip: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginRight: Spacing.xs,
  },
  chipText: {
    fontSize: 14,
  },
  chipSeats: {
    fontSize: 12,
    marginLeft: 4,
  },
  tourCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.md,
  },
  tourCardTitle: {
    fontSize: 16,
    fontWeight: "700",
    marginBottom: Spacing.sm,
  },
  subTours: {
    gap: Spacing.md,
  },
  subTour: {
    gap: Spacing.xs,
  },
  subTourName: {
    fontSize: 14,
    fontWeight: "600",
  },
  singleTour: {
    gap: Spacing.xs,
  },
  assignmentRow: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  busInfo: {
    fontSize: 14,
    fontWeight: "500",
  },
  guideName: {
    fontSize: 14,
    flex: 1,
  },
  unassignedGuide: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    borderStyle: "dashed",
    gap: Spacing.xs,
  },
  unassignedGuideName: {
    fontSize: 14,
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "flex-end",
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
  },
  modal: {
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    padding: Spacing.lg,
    maxHeight: "80%",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "700",
  },
  modalHint: {
    fontSize: 13,
    marginBottom: Spacing.md,
  },
  textArea: {
    height: 200,
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    fontSize: 14,
  },
  parseButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
    gap: Spacing.sm,
  },
  parseButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  pickerModal: {
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    padding: Spacing.lg,
    maxHeight: "70%",
  },
  tourOption: {
    paddingVertical: Spacing.md,
    borderBottomWidth: 1,
  },
  tourOptionText: {
    fontSize: 16,
  },
  tourOptionGroup: {
    fontSize: 12,
    marginTop: 2,
  },
  copyModal: {
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    padding: Spacing.lg,
  },
  copyOption: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
    gap: Spacing.md,
  },
  copyOptionText: {
    flex: 1,
  },
  copyOptionTitle: {
    fontSize: 16,
    fontWeight: "500",
  },
  copyOptionDesc: {
    fontSize: 12,
  },
});
