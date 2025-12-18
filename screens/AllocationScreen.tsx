import { useState, useMemo, useEffect, useCallback } from "react";
import { View, StyleSheet, TextInput, Pressable, Modal, FlatList, Alert, ScrollView, Platform, KeyboardAvoidingView } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { PermissionGate } from "@/components/PermissionGate";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, TourType } from "@/contexts/DataContext";
import { hapticFeedback } from "@/utils/haptics";
import * as Clipboard from "expo-clipboard";

const STORAGE_KEY_BUSES = "@allocation_buses";
const STORAGE_KEY_GUIDES = "@allocation_guides";
const STORAGE_KEY_DATE = "@allocation_date";

interface ParsedBus {
  id: string;
  busNumber: string;
  seats: number;
  assignedTourTypeId: string | null;
  assignedGuideName: string | null;
  isAdditional: boolean;
  withBoat: boolean; // С теплоходом
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
  const [showGuidePicker, setShowGuidePicker] = useState(false);
  const [pickingGuideForBus, setPickingGuideForBus] = useState<string | null>(null);
  const [expandedBusDropdown, setExpandedBusDropdown] = useState<string | null>(null); // For inline tour picker
  const [showBusModal, setShowBusModal] = useState(false);
  const [selectedBusId, setSelectedBusId] = useState<string | null>(null);
  const [showGuideModal, setShowGuideModal] = useState(false);
  const [selectedGuideId, setSelectedGuideId] = useState<string | null>(null);

  // Helper: get allocation group key for a tour (allocationGroup or tourId as fallback)
  const getAllocationKey = (tourTypeId: string | null): string | null => {
    if (!tourTypeId) return null;
    const tour = tourTypes.find(t => t.id === tourTypeId);
    if (!tour) return tourTypeId;
    return tour.allocationGroup || tourTypeId;
  };

  // Helper: check if two tourTypeIds belong to same allocation group
  const isSameAllocationGroup = (tourId1: string | null, tourId2: string | null): boolean => {
    if (!tourId1 || !tourId2) return false;
    const tour1 = tourTypes.find(t => t.id === tourId1);
    const tour2 = tourTypes.find(t => t.id === tourId2);
    if (!tour1 || !tour2) return false;
    
    // Both must have allocationGroup to be in same group
    if (tour1.allocationGroup && tour2.allocationGroup) {
      return tour1.allocationGroup === tour2.allocationGroup;
    }
    
    // If neither has group, only same if same tour
    return tourId1 === tourId2;
  };

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

  // Load saved data on mount
  useEffect(() => {
    const loadSavedData = async () => {
      try {
        const today = new Date().toISOString().split('T')[0];
        const savedDate = await AsyncStorage.getItem(STORAGE_KEY_DATE);
        
        // Only load if data is from today
        if (savedDate === today) {
          const savedBuses = await AsyncStorage.getItem(STORAGE_KEY_BUSES);
          const savedGuides = await AsyncStorage.getItem(STORAGE_KEY_GUIDES);
          
          if (savedBuses) {
            setBuses(JSON.parse(savedBuses));
          }
          if (savedGuides) {
            setGuides(JSON.parse(savedGuides));
          }
        } else {
          // Clear old data
          await AsyncStorage.multiRemove([STORAGE_KEY_BUSES, STORAGE_KEY_GUIDES, STORAGE_KEY_DATE]);
        }
      } catch (error) {
        console.error('Error loading allocation data:', error);
      }
    };
    
    loadSavedData();
  }, []);

  // Save data when buses or guides change
  useEffect(() => {
    const saveData = async () => {
      try {
        const today = new Date().toISOString().split('T')[0];
        await AsyncStorage.setItem(STORAGE_KEY_DATE, today);
        await AsyncStorage.setItem(STORAGE_KEY_BUSES, JSON.stringify(buses));
        await AsyncStorage.setItem(STORAGE_KEY_GUIDES, JSON.stringify(guides));
      } catch (error) {
        console.error('Error saving allocation data:', error);
      }
    };
    
    if (buses.length > 0 || guides.length > 0) {
      saveData();
    }
  }, [buses, guides]);

  // Auto-pair 1:1 when data changes (guides added after buses or vice versa)
  useEffect(() => {
    if (buses.length === 0 || guides.length === 0) return;
    
    // Group by allocation group
    const groupBuses = new Map<string, ParsedBus[]>();
    const groupGuides = new Map<string, ParsedGuide[]>();
    
    buses.forEach(bus => {
      if (bus.assignedTourTypeId && !bus.assignedGuideName) {
        const tour = tourTypes.find(t => t.id === bus.assignedTourTypeId);
        const groupKey = tour?.allocationGroup || bus.assignedTourTypeId;
        const existing = groupBuses.get(groupKey) || [];
        groupBuses.set(groupKey, [...existing, bus]);
      }
    });
    
    guides.forEach(guide => {
      if (guide.assignedTourTypeId && !guide.assignedBusId) {
        const tour = tourTypes.find(t => t.id === guide.assignedTourTypeId);
        const groupKey = tour?.allocationGroup || guide.assignedTourTypeId;
        const existing = groupGuides.get(groupKey) || [];
        groupGuides.set(groupKey, [...existing, guide]);
      }
    });
    
    // Auto-pair where counts match
    let updated = false;
    const newBuses = [...buses];
    const newGuides = [...guides];
    
    groupBuses.forEach((grpBuses, groupKey) => {
      const grpGuides = groupGuides.get(groupKey) || [];
      if (grpBuses.length === grpGuides.length && grpBuses.length > 0) {
        grpBuses.forEach((bus, idx) => {
          if (grpGuides[idx] && !bus.assignedGuideName) {
            const busIdx = newBuses.findIndex(b => b.id === bus.id);
            const guideIdx = newGuides.findIndex(g => g.id === grpGuides[idx].id);
            if (busIdx !== -1 && guideIdx !== -1) {
              newBuses[busIdx] = { ...newBuses[busIdx], assignedGuideName: grpGuides[idx].name };
              newGuides[guideIdx] = { ...newGuides[guideIdx], assignedBusId: bus.id };
              updated = true;
            }
          }
        });
      }
    });
    
    if (updated) {
      setBuses(newBuses);
      setGuides(newGuides);
    }
  }, [buses.length, guides.length, tourTypes]);

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
      withBoat: false,
    }));
  };

  // Words that indicate excursion/location names, not guide names
  const excludeWords = [
    'свияжск', 'город', 'казань', 'раифа', 'болгар', 'булгар', 'булгары', 'елабуга', 'чистополь',
    'йошкар', 'ола', 'кремль', 'ночь', 'день', 'вечер', 'утро', 'озера', 'озеро',
    'экскурсия', 'автобус', 'авт', 'ито', 'итого', 'всего', 'на', 'и', 'йошка',
    'тур', 'маршрут', 'обзорная', 'пешеходная', 'речная', 'ночная', 'интерактив',
    'трансфер', 'трансферы', 'резерв', 'каждый', 'час'
  ];

  // Keyword aliases with PRIORITY ORDER (higher priority first)
  // IMPORTANT: 'трансфер' before 'город' to avoid mismatches
  const keywordPriority: { mainKey: string; aliases: string[] }[] = [
    { mainKey: 'трансфер', aliases: ['трансфер', 'трансферы'] }, // HIGH PRIORITY
    { mainKey: 'болгар', aliases: ['булгар', 'булгары', 'болгар', 'болгары'] },
    { mainKey: 'йошкар', aliases: ['йошкар', 'йошка', 'йошкар-ола', 'йошкар ола'] },
    { mainKey: 'свияжск', aliases: ['свияжск'] },
    { mainKey: 'озера', aliases: ['озера', 'озеро', 'голубые'] },
    { mainKey: 'интерактив', aliases: ['интерактив'] },
    { mainKey: 'раифа', aliases: ['раифа', 'раифский'] },
    { mainKey: 'кремль', aliases: ['кремль'] },
    { mainKey: 'ночь', aliases: ['ночь', 'ночная', 'вечер'] },
    { mainKey: 'город', aliases: ['город', 'обзорная'] }, // LOW PRIORITY - after трансфер
  ];

  // Find tour by keyword ANYWHERE in the line (not just at start)
  const findTourInLine = (line: string): TourType | null => {
    const lowerLine = line.toLowerCase();
    
    // First try logistShortName (most accurate) - anywhere in line
    for (const tour of tourTypes.filter(t => t.isEnabled)) {
      if (tour.logistShortName) {
        const shortNames = tour.logistShortName.split(',').map(s => s.trim().toLowerCase());
        if (shortNames.some(name => name && lowerLine.includes(name))) {
          return tour;
        }
      }
    }
    
    // Then try keyword aliases in priority order
    for (const { mainKey, aliases } of keywordPriority) {
      for (const alias of aliases) {
        // Check if alias appears as a word (word boundary check)
        const regex = new RegExp(`(^|[\\s\\(\\-:])${alias}`, 'i');
        if (regex.test(lowerLine)) {
          // Found keyword, now find matching tour
          // Collect all matching tours and pick the best one
          const matchingTours = tourTypes
            .filter(t => t.isEnabled)
            .filter(t => {
              const tourNameLower = t.name.toLowerCase();
              return tourNameLower.includes(mainKey) || aliases.some(a => tourNameLower.includes(a));
            });
          
          if (matchingTours.length > 0) {
            // Check if line contains additional keywords that narrow down the match
            // e.g., if line has "раифа", prefer "Свияжск + Раифа" over "Свияжск"
            const lineHasRaifa = /раиф/i.test(lowerLine);
            const lineHasOzera = /озер|голуб/i.test(lowerLine);
            const lineHasInteraktiv = /интерактив/i.test(lowerLine);
            
            // Score tours based on how well they match the line
            const scoredTours = matchingTours.map(tour => {
              const nameLower = tour.name.toLowerCase();
              let score = 0;
              
              // Penalize tours with extra keywords not in line
              if (nameLower.includes('раиф') && !lineHasRaifa) score -= 10;
              if (nameLower.includes('озер') && !lineHasOzera) score -= 10;
              if (nameLower.includes('интерактив') && !lineHasInteraktiv) score -= 10;
              
              // Bonus for tours with extra keywords that ARE in line
              if (nameLower.includes('раиф') && lineHasRaifa) score += 10;
              if (nameLower.includes('озер') && lineHasOzera) score += 10;
              if (nameLower.includes('интерактив') && lineHasInteraktiv) score += 10;
              
              // Prefer shorter names (more specific match) when scores are equal
              score -= tour.name.length * 0.01;
              
              return { tour, score };
            });
            
            scoredTours.sort((a, b) => b.score - a.score);
            return scoredTours[0].tour;
          }
        }
      }
    }
    
    return null;
  };

  // Check if line is a guide assignment format: "Экскурсия - Имя Фамилия"
  const parseGuideAssignment = (line: string): { tourId: string | null; guideName: string } | null => {
    const trimmed = line.trim();
    const match = trimmed.match(/^([А-ЯЁа-яё]+)\s*[-–—]\s*([А-ЯЁ][а-яё]+(?:\s+[А-ЯЁа-яё]+)?)/);
    if (match) {
      const tourKeyword = match[1].toLowerCase();
      const guideName = match[2];
      
      for (const { mainKey, aliases } of keywordPriority) {
        if (aliases.some(a => tourKeyword.includes(a) || a.includes(tourKeyword))) {
          // Collect all matching tours
          const matchingTours = tourTypes
            .filter(t => t.isEnabled)
            .filter(t => {
              const tourNameLower = t.name.toLowerCase();
              return tourNameLower.includes(mainKey) || aliases.some(a => tourNameLower.includes(a));
            });
          
          if (matchingTours.length > 0) {
            // Check for additional keywords in tour keyword
            const hasRaifa = /раиф/i.test(tourKeyword);
            const hasOzera = /озер|голуб/i.test(tourKeyword);
            const hasInteraktiv = /интерактив/i.test(tourKeyword);
            
            // Score tours
            const scoredTours = matchingTours.map(tour => {
              const nameLower = tour.name.toLowerCase();
              let score = 0;
              
              if (nameLower.includes('раиф') && !hasRaifa) score -= 10;
              if (nameLower.includes('озер') && !hasOzera) score -= 10;
              if (nameLower.includes('интерактив') && !hasInteraktiv) score -= 10;
              
              if (nameLower.includes('раиф') && hasRaifa) score += 10;
              if (nameLower.includes('озер') && hasOzera) score += 10;
              if (nameLower.includes('интерактив') && hasInteraktiv) score += 10;
              
              score -= tour.name.length * 0.01;
              
              return { tour, score };
            });
            
            scoredTours.sort((a, b) => b.score - a.score);
            return { tourId: scoredTours[0].tour.id, guideName };
          }
        }
      }
    }
    return null;
  };

  // Parse guides - supports "Имя Фамилия" AND single names like "Мила"
  const parseGuidesFromLines = (lines: string[]): { guides: ParsedGuide[], assignments: Map<string, string> } => {
    const guides: ParsedGuide[] = [];
    const assignments = new Map<string, string>(); // guideName -> tourId
    let idCounter = 0;
    let currentTourContext: TourType | null = null;
    
    lines.forEach(line => {
      const trimmed = line.trim();
      
      // Empty line resets context
      if (!trimmed) {
        currentTourContext = null;
        return;
      }
      
      // Skip lines with bus patterns
      if (/\d{3}-\d{2}/.test(trimmed)) {
        // But still try to update context from this line
        const lineTour = findTourInLine(trimmed);
        if (lineTour) currentTourContext = lineTour;
        return;
      }
      
      // Always try to detect tour from current line first
      const lineTour = findTourInLine(trimmed);
      if (lineTour) {
        currentTourContext = lineTour;
      }
      
      // Check for tour header (e.g., "Свияжск:") - already handled by findTourInLine above
      if (trimmed.match(/^[А-ЯЁа-яё]+\s*:$/)) {
        return; // Just a header line, skip further processing
      }
      
      // Skip time headers like "11:00"
      if (/^\d{1,2}:\d{2}$/.test(trimmed)) return;
      
      // Check for guide assignment "Экскурсия - Имя Фамилия"
      const assignment = parseGuideAssignment(trimmed);
      if (assignment) {
        if (!guides.find(g => g.name.toLowerCase() === assignment.guideName.toLowerCase())) {
          guides.push({
            id: `guide-${idCounter++}-${Date.now()}`,
            name: assignment.guideName,
            assignedTourTypeId: assignment.tourId,
            assignedBusId: null,
            isAdditional: false,
          });
          if (assignment.tourId) {
            assignments.set(assignment.guideName, assignment.tourId);
          }
        }
        return;
      }
      
      // Full name pattern: "Имя Фамилия"
      const fullNameMatch = trimmed.match(/^([А-ЯЁ][а-яё]{2,})\s+([А-ЯЁа-яё][а-яё]{2,})$/);
      if (fullNameMatch) {
        const firstName = fullNameMatch[1].toLowerCase();
        const lastName = fullNameMatch[2].toLowerCase();
        
        if (!excludeWords.includes(firstName) && !excludeWords.includes(lastName)) {
          const fullName = `${fullNameMatch[1]} ${fullNameMatch[2]}`;
          if (!guides.find(g => g.name.toLowerCase() === fullName.toLowerCase())) {
            guides.push({
              id: `guide-${idCounter++}-${Date.now()}`,
              name: fullName,
              assignedTourTypeId: currentTourContext?.id || null,
              assignedBusId: null,
              isAdditional: false,
            });
            if (currentTourContext) {
              assignments.set(fullName, currentTourContext.id);
            }
          }
        }
        return;
      }
      
      // Single name pattern: "Мила" (capitalized word, 3+ chars, on its own line)
      const singleNameMatch = trimmed.match(/^([А-ЯЁ][а-яё]{2,})$/);
      if (singleNameMatch) {
        const name = singleNameMatch[1];
        const nameLower = name.toLowerCase();
        
        if (!excludeWords.includes(nameLower)) {
          if (!guides.find(g => g.name.toLowerCase() === nameLower)) {
            guides.push({
              id: `guide-${idCounter++}-${Date.now()}`,
              name: name,
              assignedTourTypeId: currentTourContext?.id || null,
              assignedBusId: null,
              isAdditional: false,
            });
            if (currentTourContext) {
              assignments.set(name, currentTourContext.id);
            }
          }
        }
        return;
      }
    });

    return { guides, assignments };
  };

  // Parse text with improved line-by-line detection
  const parseWithBlocks = (text: string): { buses: ParsedBus[], guides: ParsedGuide[] } => {
    const allBuses: ParsedBus[] = [];
    const lines = text.split('\n');
    let busIdCounter = 0;
    
    // First pass: parse buses with LOCAL tour detection per line
    lines.forEach(line => {
      const trimmedLine = line.trim();
      if (!trimmedLine) return;
      
      const busPattern = /(\d{3})-(\d{2})/g;
      const matches = [...trimmedLine.matchAll(busPattern)];
      
      if (matches.length > 0) {
        // Find tour FROM THIS LINE ONLY (not inherited context)
        const lineTour = findTourInLine(trimmedLine);
        
        matches.forEach(match => {
          allBuses.push({
            id: `bus-${busIdCounter++}-${Date.now()}`,
            busNumber: match[1],
            seats: parseInt(match[2], 10),
            assignedTourTypeId: lineTour?.id || null,
            assignedGuideName: null,
            isAdditional: false,
            withBoat: false,
          });
        });
      }
    });
    
    // Second pass: parse guides
    const { guides: allGuides, assignments } = parseGuidesFromLines(lines);
    
    // Third pass: auto-assign guides to buses when counts match (1:1)
    // Group by allocation group, not by exact tourTypeId
    const groupBusCounts = new Map<string, ParsedBus[]>();
    const groupGuideCounts = new Map<string, ParsedGuide[]>();
    
    allBuses.forEach(bus => {
      if (bus.assignedTourTypeId) {
        const groupKey = getAllocationKey(bus.assignedTourTypeId) || bus.assignedTourTypeId;
        const existing = groupBusCounts.get(groupKey) || [];
        existing.push(bus);
        groupBusCounts.set(groupKey, existing);
      }
    });
    
    allGuides.forEach(guide => {
      if (guide.assignedTourTypeId) {
        const groupKey = getAllocationKey(guide.assignedTourTypeId) || guide.assignedTourTypeId;
        const existing = groupGuideCounts.get(groupKey) || [];
        existing.push(guide);
        groupGuideCounts.set(groupKey, existing);
      }
    });
    
    // Auto-pair when counts match within allocation group
    groupBusCounts.forEach((groupBuses, groupKey) => {
      const groupGuides = groupGuideCounts.get(groupKey) || [];
      if (groupBuses.length === groupGuides.length && groupBuses.length > 0) {
        groupBuses.forEach((bus, idx) => {
          if (groupGuides[idx]) {
            bus.assignedGuideName = groupGuides[idx].name;
            groupGuides[idx].assignedBusId = bus.id;
          }
        });
      }
    });
    
    return { buses: allBuses, guides: allGuides };
  };

  const handleParse = () => {
    if (!inputText.trim()) {
      Alert.alert("Внимание", "Вставьте данные от логиста");
      return;
    }

    const { buses: parsedBuses, guides: parsedGuides } = parseWithBlocks(inputText);

    if (parsedBuses.length === 0 && parsedGuides.length === 0) {
      Alert.alert("Внимание", "Не удалось распознать автобусы или гидов");
      return;
    }

    // Count how many buses were auto-assigned
    const assignedCount = parsedBuses.filter(b => b.assignedTourTypeId).length;
    const unassignedCount = parsedBuses.length - assignedCount;

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

    let message = `Автобусов: ${parsedBuses.length}\nГидов: ${parsedGuides.length}`;
    if (assignedCount > 0) {
      message += `\n\nАвто-назначено: ${assignedCount}`;
    }
    if (unassignedCount > 0) {
      message += `\nТребуют назначения: ${unassignedCount}`;
    }
    
    Alert.alert("Распознано", message);
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
        onPress: async () => {
          setBuses([]);
          setGuides([]);
          // Clear AsyncStorage
          await AsyncStorage.multiRemove([STORAGE_KEY_BUSES, STORAGE_KEY_GUIDES, STORAGE_KEY_DATE]);
          hapticFeedback.medium();
        },
      },
    ]);
  };

  // Get unassigned buses and guides
  const unassignedBuses = buses.filter(b => !b.assignedTourTypeId);
  const unassignedGuides = guides.filter(g => !g.assignedTourTypeId);

  // Get sorted tour types by articleNumber for display
  const sortedTourTypes = useMemo(() => {
    return [...tourTypes]
      .filter(t => t.isEnabled)
      .sort((a, b) => {
        const aNum = parseInt(a.articleNumber || '999', 10);
        const bNum = parseInt(b.articleNumber || '999', 10);
        return aNum - bNum;
      });
  }, [tourTypes]);

  // Get available guides for a tour (guides in the same allocation group)
  const getAvailableGuidesForTour = (tourTypeId: string | null) => {
    if (!tourTypeId) return [];
    return guides.filter(g => 
      !g.assignedBusId && // Not assigned to any bus
      isSameAllocationGroup(g.assignedTourTypeId, tourTypeId) // Same allocation group
    );
  };

  // Open guide picker for a bus
  const openGuidePicker = (busId: string) => {
    setPickingGuideForBus(busId);
    setShowGuidePicker(true);
  };

  // Assign guide to bus
  const assignGuideToBus = (busId: string, guideName: string) => {
    const guide = guides.find(g => g.name === guideName);
    const bus = buses.find(b => b.id === busId);
    
    if (bus) {
      // Update bus with guide name
      setBuses(prev => prev.map(b => 
        b.id === busId ? { ...b, assignedGuideName: guideName } : b
      ));
      
      // Update guide if found
      if (guide) {
        setGuides(prev => prev.map(g => 
          g.name === guideName ? { ...g, assignedBusId: busId, assignedTourTypeId: bus.assignedTourTypeId } : g
        ));
      }
    }
    
    setShowGuidePicker(false);
    setPickingGuideForBus(null);
    hapticFeedback.light();
  };

  // Remove guide from bus
  const removeGuideFromBus = (busId: string) => {
    const bus = buses.find(b => b.id === busId);
    if (!bus || !bus.assignedGuideName) return;
    
    const guideName = bus.assignedGuideName;
    
    // Update bus
    setBuses(prev => prev.map(b => 
      b.id === busId ? { ...b, assignedGuideName: null } : b
    ));
    
    // Update guide
    setGuides(prev => prev.map(g => 
      g.name === guideName ? { ...g, assignedBusId: null } : g
    ));
    
    hapticFeedback.light();
  };
  
  // Change guide's tour assignment
  const changeGuideTour = (guideId: string, newTourTypeId: string) => {
    const guide = guides.find(g => g.id === guideId);
    if (!guide) return;
    
    // If guide was assigned to a bus, remove from that bus too
    if (guide.assignedBusId) {
      setBuses(prev => prev.map(b => 
        b.id === guide.assignedBusId ? { ...b, assignedGuideName: null } : b
      ));
    }
    
    setGuides(prev => prev.map(g => 
      g.id === guideId ? { ...g, assignedTourTypeId: newTourTypeId, assignedBusId: null } : g
    ));
    
    hapticFeedback.light();
  };
  
  // Move bus up/down in order
  const moveBus = (busId: string, direction: 'up' | 'down') => {
    setBuses(prev => {
      const idx = prev.findIndex(b => b.id === busId);
      if (idx === -1) return prev;
      
      // Find buses with same tour to only reorder within tour group
      const bus = prev[idx];
      const sameTourBuses = prev.filter(b => b.assignedTourTypeId === bus.assignedTourTypeId);
      const posInTour = sameTourBuses.findIndex(b => b.id === busId);
      
      if (direction === 'up' && posInTour === 0) return prev;
      if (direction === 'down' && posInTour === sameTourBuses.length - 1) return prev;
      
      // Get the bus to swap with
      const swapBus = direction === 'up' ? sameTourBuses[posInTour - 1] : sameTourBuses[posInTour + 1];
      const swapIdx = prev.findIndex(b => b.id === swapBus.id);
      
      // Swap positions in main array
      const newBuses = [...prev];
      [newBuses[idx], newBuses[swapIdx]] = [newBuses[swapIdx], newBuses[idx]];
      
      return newBuses;
    });
    hapticFeedback.light();
  };
  
  // Toggle boat flag for bus
  const toggleBoat = (busId: string) => {
    setBuses(prev => prev.map(b => 
      b.id === busId ? { ...b, withBoat: !b.withBoat } : b
    ));
    hapticFeedback.light();
  };
  
  // Delete bus from allocation
  const deleteBus = (busId: string) => {
    const bus = buses.find(b => b.id === busId);
    if (!bus) return;
    
    // If bus has assigned guide, unassign them
    if (bus.assignedGuideName) {
      setGuides(prev => prev.map(g => 
        g.name === bus.assignedGuideName ? { ...g, assignedBusId: null } : g
      ));
    }
    
    // Remove bus
    setBuses(prev => prev.filter(b => b.id !== busId));
    hapticFeedback.medium();
  };
  
  // Delete guide from allocation
  const deleteGuide = (guideId: string) => {
    const guide = guides.find(g => g.id === guideId);
    if (!guide) return;
    
    // If guide is assigned to bus, remove from bus
    if (guide.assignedBusId) {
      setBuses(prev => prev.map(b => 
        b.id === guide.assignedBusId ? { ...b, assignedGuideName: null } : b
      ));
    }
    
    // Remove guide
    setGuides(prev => prev.filter(g => g.id !== guideId));
    hapticFeedback.medium();
  };

  // Get buses and guides for a specific tour type
  // Get buses for exact tour (not group) - for visual display
  const getBusesForTour = (tourTypeId: string) => 
    buses.filter(b => b.assignedTourTypeId === tourTypeId);
  
  // Get guides for exact tour (not group)
  const getGuidesForTour = (tourTypeId: string) => 
    guides.filter(g => g.assignedTourTypeId === tourTypeId);
  
  // Get all buses in an allocation group
  const getBusesForGroup = (groupKey: string) => 
    buses.filter(b => getAllocationKey(b.assignedTourTypeId) === groupKey);
  
  // Get all guides in an allocation group  
  const getGuidesForGroup = (groupKey: string) =>
    guides.filter(g => getAllocationKey(g.assignedTourTypeId) === groupKey);
  
  // Get tours in the same allocation group
  const getToursInGroup = (tourTypeId: string | null) => {
    if (!tourTypeId) return sortedTourTypes;
    const groupKey = getAllocationKey(tourTypeId);
    if (!groupKey) return [tourTypes.find(t => t.id === tourTypeId)].filter(Boolean) as TourType[];
    return sortedTourTypes.filter(t => t.allocationGroup === groupKey);
  };

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

        const boatBuses = tourBuses.filter(b => b.withBoat);
        const tourTitle = boatBuses.length > 0 
          ? `${tour.name.toUpperCase()} (с теплоходом: ${boatBuses.length})`
          : tour.name.toUpperCase();
        lines.push(tourTitle);
        
        tourBuses.forEach(bus => {
          const guideName = bus.assignedGuideName || '—';
          const boatMark = bus.withBoat ? ' 🚢' : '';
          lines.push(`Авт. ${bus.busNumber} (${bus.seats} м.)${boatMark} → ${guideName}`);
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
        lines.push(`Экскурсия: ${tour.name}${bus.withBoat ? ' (с теплоходом)' : ''}`);
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
    <PermissionGate permission="allocation">
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

      {/* Allocation groups - one section per group */}
      {tourGroups.map(group => {
        // Check if this is a real allocation group or just a single tour
        const isRealGroup = group.tourTypes.length > 1 || 
          (group.tourTypes.length === 1 && group.tourTypes[0].allocationGroup);
        
        // Get all buses in this allocation group
        const groupBuses = buses.filter(b => {
          if (!b.assignedTourTypeId) return false;
          const busTour = tourTypes.find(t => t.id === b.assignedTourTypeId);
          if (!busTour) return false;
          
          if (isRealGroup) {
            // For real groups, match by allocationGroup
            return busTour.allocationGroup === group.groupName;
          } else {
            // For ungrouped tours, match by exact tour ID
            return group.tourTypes.some(t => t.id === b.assignedTourTypeId);
          }
        });
        
        // Get all guides in this allocation group
        const groupGuides = guides.filter(g => {
          if (!g.assignedTourTypeId) return false;
          const guideTour = tourTypes.find(t => t.id === g.assignedTourTypeId);
          if (!guideTour) return false;
          
          if (isRealGroup) {
            return guideTour.allocationGroup === group.groupName;
          } else {
            return group.tourTypes.some(t => t.id === g.assignedTourTypeId);
          }
        });
        
        // Show section if has buses OR guides
        if (groupBuses.length === 0 && groupGuides.length === 0) return null;
        
        // Get selected bus for dropdown
        const selectedBus = expandedBusDropdown ? buses.find(b => b.id === expandedBusDropdown) : null;
        const selectedBusTour = selectedBus?.assignedTourTypeId ? tourTypes.find(t => t.id === selectedBus.assignedTourTypeId) : null;
        
        return (
          <View key={group.groupName} style={[styles.tourSection, { backgroundColor: theme.backgroundSecondary }]}>
            {/* Group header */}
            <View style={styles.tourHeader}>
              <View style={styles.tourTitleRow}>
                <Icon name="map" size={16} color={theme.primary} />
                <ThemedText style={styles.tourName}>{group.groupName}</ThemedText>
              </View>
              <View style={{ flexDirection: 'row', gap: 8 }}>
                {groupBuses.length > 0 ? (
                  <ThemedText style={[styles.busCount, { color: theme.textSecondary }]}>
                    {groupBuses.length} авт.
                  </ThemedText>
                ) : null}
                {groupGuides.length > 0 ? (
                  <ThemedText style={[styles.busCount, { color: theme.textSecondary }]}>
                    {groupGuides.length} гид.
                  </ThemedText>
                ) : null}
              </View>
            </View>
            
            {/* Bus rows */}
            {groupBuses.map(bus => {
              const busTour = tourTypes.find(t => t.id === bus.assignedTourTypeId);
              const busTourName = busTour?.name || 'Не назначено';
              
              return (
                <View key={bus.id} style={[styles.busRow, { backgroundColor: theme.backgroundTertiary }]}>
                  {/* Bus icon and number - pressable to open modal */}
                  <Pressable 
                    style={styles.busCell}
                    onPress={() => {
                      setSelectedBusId(bus.id);
                      setShowBusModal(true);
                    }}
                  >
                    <Icon name="truck" size={16} color={theme.primary} />
                    <ThemedText style={styles.busNumber}>{bus.busNumber}</ThemedText>
                    <ThemedText style={[styles.busSeats, { color: theme.textSecondary }]}>
                      ({bus.seats})
                    </ThemedText>
                  </Pressable>
                  
                  {/* Excursion display (read-only, managed via bus modal) */}
                  <Pressable 
                    style={styles.tourCell}
                    onPress={() => {
                      setSelectedBusId(bus.id);
                      setShowBusModal(true);
                    }}
                  >
                    <Icon name="map-pin" size={14} color={theme.success} />
                    <ThemedText style={[styles.tourCellText, { color: theme.success }]} numberOfLines={1}>
                      {busTourName.length > 12 ? busTourName.substring(0, 12) + '...' : busTourName}
                    </ThemedText>
                  </Pressable>
                  
                  {/* Boat toggle - letter T for Теплоход */}
                  <Pressable
                    style={[
                      styles.boatToggle,
                      { backgroundColor: bus.withBoat ? theme.primary + '30' : 'transparent' }
                    ]}
                    onPress={() => toggleBoat(bus.id)}
                  >
                    <ThemedText 
                      style={[
                        styles.boatToggleText,
                        { color: bus.withBoat ? theme.primary : theme.textSecondary }
                      ]}
                    >
                      Т
                    </ThemedText>
                  </Pressable>
                  
                  {/* Guide selector */}
                  <Pressable 
                    style={[
                      styles.guideCell, 
                      { backgroundColor: bus.assignedGuideName ? theme.backgroundSecondary : 'transparent' }
                    ]}
                    onPress={() => {
                      if (bus.assignedGuideName) {
                        const guide = guides.find(g => g.name === bus.assignedGuideName);
                        if (guide) {
                          setSelectedGuideId(guide.id);
                          setShowGuideModal(true);
                        }
                      } else {
                        openGuidePicker(bus.id);
                      }
                    }}
                  >
                    <Icon 
                      name="user" 
                      size={14} 
                      color={bus.assignedGuideName ? theme.text : theme.textSecondary} 
                    />
                    <ThemedText 
                      style={[
                        styles.guideCellText, 
                        { color: bus.assignedGuideName ? theme.text : theme.textSecondary }
                      ]} 
                      numberOfLines={1}
                    >
                      {bus.assignedGuideName || 'Выбрать'}
                    </ThemedText>
                  </Pressable>
                  
                  {/* Copy button */}
                  <Pressable
                    style={styles.copyRowButton}
                    onPress={async () => {
                      const text = `${busTourName}${bus.withBoat ? ' (с теплоходом)' : ''}, автобус ${bus.busNumber}${bus.assignedGuideName ? `, гид ${bus.assignedGuideName}` : ''}`;
                      await Clipboard.setStringAsync(text);
                      hapticFeedback.light();
                    }}
                  >
                    <Icon name="copy" size={16} color={theme.textSecondary} />
                  </Pressable>
                  
                </View>
              );
            })}
            
            {/* Unassigned guides for this group */}
            {groupGuides.filter(g => !g.assignedBusId).length > 0 ? (
              <View style={styles.unassignedGuidesRow}>
                <ThemedText style={[styles.unassignedLabel, { color: theme.warning }]}>
                  Свободные гиды:
                </ThemedText>
                {groupGuides.filter(g => !g.assignedBusId).map(guide => (
                  <Pressable 
                    key={guide.id} 
                    style={[styles.freeGuideChip, { backgroundColor: theme.backgroundTertiary }]}
                    onPress={() => {
                      setSelectedGuideId(guide.id);
                      setShowGuideModal(true);
                    }}
                  >
                    <Icon name="user" size={12} color={theme.warning} />
                    <ThemedText style={[styles.freeGuideName, { color: theme.warning }]}>
                      {guide.name}
                    </ThemedText>
                  </Pressable>
                ))}
              </View>
            ) : null}
          </View>
        );
      })}

      {/* Unassigned section */}
      {unassignedBuses.length > 0 ? (
        <View style={[styles.tourSection, { backgroundColor: theme.backgroundSecondary, borderLeftColor: theme.warning, borderLeftWidth: 3 }]}>
          <View style={styles.tourHeader}>
            <View style={styles.tourTitleRow}>
              <Icon name="alert-circle" size={16} color={theme.warning} />
              <ThemedText style={styles.tourName}>Не назначено</ThemedText>
            </View>
            <ThemedText style={[styles.busCount, { color: theme.warning }]}>
              {unassignedBuses.length} авт.
            </ThemedText>
          </View>
          
          {unassignedBuses.map(bus => (
            <View key={bus.id}>
              <View style={[styles.busRow, { backgroundColor: theme.backgroundTertiary }]}>
                {/* Bus icon and number */}
                <View style={styles.busCell}>
                  <Icon name="truck" size={16} color={theme.warning} />
                  <ThemedText style={styles.busNumber}>{bus.busNumber}</ThemedText>
                  <ThemedText style={[styles.busSeats, { color: theme.textSecondary }]}>
                    ({bus.seats})
                  </ThemedText>
                </View>
                
                {/* Excursion selector with inline dropdown */}
                <Pressable 
                  style={[styles.tourCell, styles.tourCellEmpty]}
                  onPress={() => setExpandedBusDropdown(expandedBusDropdown === bus.id ? null : bus.id)}
                >
                  <Icon name="map-pin" size={14} color={theme.textSecondary} />
                  <ThemedText style={[styles.tourCellText, { color: theme.textSecondary }]}>
                    Выбрать
                  </ThemedText>
                  <Icon name="chevron-down" size={12} color={theme.textSecondary} />
                </Pressable>
                
                {/* Guide selector (disabled until tour assigned) */}
                <View style={[styles.guideCell, { opacity: 0.5 }]}>
                  <Icon name="user" size={14} color={theme.textSecondary} />
                  <ThemedText style={[styles.guideCellText, { color: theme.textSecondary }]}>
                    —
                  </ThemedText>
                </View>
              </View>
              
              {/* Inline dropdown */}
              {expandedBusDropdown === bus.id ? (
                <View style={[styles.inlineDropdown, { backgroundColor: theme.backgroundTertiary }]}>
                  {sortedTourTypes.map(t => (
                    <Pressable
                      key={t.id}
                      style={styles.dropdownItem}
                      onPress={() => {
                        handleAssignBusToTour(bus.id, t.id);
                        setExpandedBusDropdown(null);
                      }}
                    >
                      <ThemedText style={styles.dropdownItemText}>{t.name}</ThemedText>
                    </Pressable>
                  ))}
                </View>
              ) : null}
            </View>
          ))}
        </View>
      ) : null}

      {/* Unassigned guides (not linked to any tour) */}
      {unassignedGuides.length > 0 ? (
        <View style={[styles.tourSection, { backgroundColor: theme.backgroundSecondary, borderLeftColor: theme.warning, borderLeftWidth: 3 }]}>
          <View style={styles.tourHeader}>
            <View style={styles.tourTitleRow}>
              <Icon name="users" size={16} color={theme.warning} />
              <ThemedText style={styles.tourName}>Гиды без экскурсии</ThemedText>
            </View>
            <ThemedText style={[styles.busCount, { color: theme.warning }]}>
              {unassignedGuides.length} гид.
            </ThemedText>
          </View>
          
          {unassignedGuides.map(guide => (
            <View key={guide.id}>
              <View style={[styles.busRow, { backgroundColor: theme.backgroundTertiary }]}>
                {/* Guide icon and name */}
                <View style={[styles.busCell, { flex: 1 }]}>
                  <Icon name="user" size={16} color={theme.warning} />
                  <ThemedText style={styles.busNumber}>{guide.name}</ThemedText>
                </View>
                
                {/* Tour selector with inline dropdown */}
                <Pressable 
                  style={[styles.tourCell, styles.tourCellEmpty, { flex: 1.5 }]}
                  onPress={() => setExpandedBusDropdown(expandedBusDropdown === `guide-${guide.id}` ? null : `guide-${guide.id}`)}
                >
                  <Icon name="map-pin" size={14} color={theme.textSecondary} />
                  <ThemedText style={[styles.tourCellText, { color: theme.textSecondary }]}>
                    Выбрать экскурсию
                  </ThemedText>
                  <Icon name="chevron-down" size={12} color={theme.textSecondary} />
                </Pressable>
                
                {/* Delete button */}
                <Pressable
                  style={styles.deleteRowButton}
                  onPress={() => {
                    Alert.alert(
                      "Удалить гида?",
                      `${guide.name} будет удалён из распределения`,
                      [
                        { text: "Отмена", style: "cancel" },
                        { text: "Удалить", style: "destructive", onPress: () => deleteGuide(guide.id) },
                      ]
                    );
                  }}
                >
                  <Icon name="x" size={16} color={theme.error} />
                </Pressable>
              </View>
              
              {/* Inline dropdown for guide */}
              {expandedBusDropdown === `guide-${guide.id}` ? (
                <View style={[styles.inlineDropdown, { backgroundColor: theme.backgroundTertiary }]}>
                  {sortedTourTypes.map(t => (
                    <Pressable
                      key={t.id}
                      style={styles.dropdownItem}
                      onPress={() => {
                        handleAssignGuideToTour(guide.id, t.id);
                        setExpandedBusDropdown(null);
                      }}
                    >
                      <ThemedText style={styles.dropdownItemText}>{t.name}</ThemedText>
                    </Pressable>
                  ))}
                </View>
              ) : null}
            </View>
          ))}
        </View>
      ) : null}

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

      {/* Guide Picker Modal */}
      <Modal visible={showGuidePicker} animationType="fade" transparent>
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowGuidePicker(false)} />
          <ThemedView style={[styles.pickerModal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Выберите гида</ThemedText>
              <Pressable onPress={() => setShowGuidePicker(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            {(() => {
              const bus = buses.find(b => b.id === pickingGuideForBus);
              const availableGuides = getAvailableGuidesForTour(bus?.assignedTourTypeId || null);
              
              if (availableGuides.length === 0) {
                return (
                  <View style={styles.emptyGuides}>
                    <Icon name="user-x" size={32} color={theme.textSecondary} />
                    <ThemedText style={[styles.emptyGuidesText, { color: theme.textSecondary }]}>
                      Нет доступных гидов
                    </ThemedText>
                  </View>
                );
              }
              
              return (
                <FlatList
                  data={availableGuides}
                  keyExtractor={item => item.id}
                  renderItem={({ item }) => (
                    <Pressable
                      style={[styles.guideOption, { borderBottomColor: theme.border }]}
                      onPress={() => {
                        if (pickingGuideForBus) {
                          assignGuideToBus(pickingGuideForBus, item.name);
                        }
                      }}
                    >
                      <Icon name="user" size={18} color={theme.primary} />
                      <ThemedText style={styles.guideOptionText}>{item.name}</ThemedText>
                    </Pressable>
                  )}
                />
              );
            })()}
          </ThemedView>
        </View>
      </Modal>

      {/* Bus Management Modal */}
      <Modal visible={showBusModal} animationType="fade" transparent>
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowBusModal(false)} />
          <ThemedView style={[styles.pickerModal, { backgroundColor: theme.backgroundDefault }]}>
            {(() => {
              const bus = buses.find(b => b.id === selectedBusId);
              if (!bus) return null;
              
              const currentTour = tourTypes.find(t => t.id === bus.assignedTourTypeId);
              
              return (
                <>
                  <View style={styles.modalHeader}>
                    <View>
                      <ThemedText style={styles.modalTitle}>{bus.busNumber}</ThemedText>
                      <ThemedText style={{ color: theme.textSecondary, fontSize: 12 }}>
                        {bus.seats} мест {bus.withBoat ? '(с теплоходом)' : ''}
                      </ThemedText>
                    </View>
                    <Pressable onPress={() => setShowBusModal(false)}>
                      <Icon name="x" size={24} color={theme.text} />
                    </Pressable>
                  </View>
                  
                  {/* Move buttons */}
                  <View style={styles.moveButtonsRow}>
                    <Pressable
                      style={[styles.moveButton, { backgroundColor: theme.backgroundSecondary }]}
                      onPress={() => moveBus(bus.id, 'up')}
                    >
                      <Icon name="chevron-up" size={20} color={theme.primary} />
                      <ThemedText style={{ color: theme.primary, fontSize: 13 }}>Выше</ThemedText>
                    </Pressable>
                    <Pressable
                      style={[styles.moveButton, { backgroundColor: theme.backgroundSecondary }]}
                      onPress={() => moveBus(bus.id, 'down')}
                    >
                      <Icon name="chevron-down" size={20} color={theme.primary} />
                      <ThemedText style={{ color: theme.primary, fontSize: 13 }}>Ниже</ThemedText>
                    </Pressable>
                  </View>
                  
                  <ThemedText style={{ color: theme.textSecondary, marginBottom: Spacing.sm, fontSize: 13 }}>
                    Выберите экскурсию:
                  </ThemedText>
                  
                  <ScrollView style={{ maxHeight: 300 }}>
                    {sortedTourTypes.map(tour => (
                      <Pressable
                        key={tour.id}
                        style={[
                          styles.guideOption, 
                          { borderBottomColor: theme.border },
                          currentTour?.id === tour.id && { backgroundColor: theme.primary + '20' }
                        ]}
                        onPress={() => {
                          handleAssignBusToTour(bus.id, tour.id);
                          setShowBusModal(false);
                        }}
                      >
                        <Icon name="map-pin" size={18} color={currentTour?.id === tour.id ? theme.primary : theme.textSecondary} />
                        <ThemedText style={[
                          styles.guideOptionText,
                          currentTour?.id === tour.id && { color: theme.primary, fontWeight: '600' }
                        ]}>
                          {tour.name}
                        </ThemedText>
                        {currentTour?.id === tour.id ? (
                          <Icon name="check" size={16} color={theme.primary} />
                        ) : null}
                      </Pressable>
                    ))}
                  </ScrollView>
                  
                  <Pressable
                    style={[styles.deleteButton, { backgroundColor: theme.error + '20', borderColor: theme.error }]}
                    onPress={() => {
                      Alert.alert(
                        "Удалить автобус?",
                        `${bus.busNumber} будет удалён из распределения`,
                        [
                          { text: "Отмена", style: "cancel" },
                          { 
                            text: "Удалить", 
                            style: "destructive", 
                            onPress: () => {
                              deleteBus(bus.id);
                              setShowBusModal(false);
                            }
                          },
                        ]
                      );
                    }}
                  >
                    <Icon name="trash-2" size={18} color={theme.error} />
                    <ThemedText style={{ color: theme.error, fontWeight: '600' }}>Удалить автобус</ThemedText>
                  </Pressable>
                </>
              );
            })()}
          </ThemedView>
        </View>
      </Modal>

      {/* Guide Management Modal */}
      <Modal visible={showGuideModal} animationType="fade" transparent>
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowGuideModal(false)} />
          <ThemedView style={[styles.pickerModal, { backgroundColor: theme.backgroundDefault }]}>
            {(() => {
              const guide = guides.find(g => g.id === selectedGuideId);
              if (!guide) return null;
              
              const currentTour = tourTypes.find(t => t.id === guide.assignedTourTypeId);
              const assignedBus = buses.find(b => b.id === guide.assignedBusId);
              
              return (
                <>
                  <View style={styles.modalHeader}>
                    <View>
                      <ThemedText style={styles.modalTitle}>{guide.name}</ThemedText>
                      <ThemedText style={{ color: theme.textSecondary, fontSize: 12 }}>
                        {currentTour?.name || 'Не назначен'}
                        {assignedBus ? ` (авт. ${assignedBus.busNumber})` : ''}
                      </ThemedText>
                    </View>
                    <Pressable onPress={() => setShowGuideModal(false)}>
                      <Icon name="x" size={24} color={theme.text} />
                    </Pressable>
                  </View>
                  
                  <ThemedText style={{ color: theme.textSecondary, marginBottom: Spacing.sm, fontSize: 13 }}>
                    Переместить на экскурсию:
                  </ThemedText>
                  
                  <ScrollView style={{ maxHeight: 300 }}>
                    {sortedTourTypes.map(tour => (
                      <Pressable
                        key={tour.id}
                        style={[
                          styles.guideOption, 
                          { borderBottomColor: theme.border },
                          currentTour?.id === tour.id && { backgroundColor: theme.primary + '20' }
                        ]}
                        onPress={() => {
                          changeGuideTour(guide.id, tour.id);
                          setShowGuideModal(false);
                        }}
                      >
                        <Icon name="map-pin" size={18} color={currentTour?.id === tour.id ? theme.primary : theme.textSecondary} />
                        <ThemedText style={[
                          styles.guideOptionText,
                          currentTour?.id === tour.id && { color: theme.primary, fontWeight: '600' }
                        ]}>
                          {tour.name}
                        </ThemedText>
                        {currentTour?.id === tour.id ? (
                          <Icon name="check" size={16} color={theme.primary} />
                        ) : null}
                      </Pressable>
                    ))}
                  </ScrollView>
                  
                  {guide.assignedBusId ? (
                    <Pressable
                      style={[styles.deleteButton, { backgroundColor: theme.warning + '20', borderColor: theme.warning, marginTop: Spacing.md }]}
                      onPress={() => {
                        removeGuideFromBus(guide.assignedBusId!);
                        setShowGuideModal(false);
                      }}
                    >
                      <Icon name="user-minus" size={18} color={theme.warning} />
                      <ThemedText style={{ color: theme.warning, fontWeight: '600' }}>Убрать с автобуса</ThemedText>
                    </Pressable>
                  ) : null}
                  
                  <Pressable
                    style={[styles.deleteButton, { backgroundColor: theme.error + '20', borderColor: theme.error }]}
                    onPress={() => {
                      Alert.alert(
                        "Удалить гида?",
                        `${guide.name} будет удалён из распределения`,
                        [
                          { text: "Отмена", style: "cancel" },
                          { 
                            text: "Удалить", 
                            style: "destructive", 
                            onPress: () => {
                              deleteGuide(guide.id);
                              setShowGuideModal(false);
                            }
                          },
                        ]
                      );
                    }}
                  >
                    <Icon name="trash-2" size={18} color={theme.error} />
                    <ThemedText style={{ color: theme.error, fontWeight: '600' }}>Удалить гида</ThemedText>
                  </Pressable>
                </>
              );
            })()}
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
    </PermissionGate>
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
  // New styles for updated UI
  tourSection: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.md,
  },
  tourHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  tourTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    flex: 1,
  },
  articleBadge: {
    width: 32,
    height: 24,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    justifyContent: "center",
  },
  articleNumber: {
    fontSize: 12,
    fontWeight: "700",
  },
  tourName: {
    fontSize: 15,
    fontWeight: "600",
    flex: 1,
  },
  busCount: {
    fontSize: 12,
  },
  busRow: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.xs,
    gap: 4,
  },
  busCell: {
    flexDirection: "row",
    alignItems: "center",
    gap: 2,
    minWidth: 70,
  },
  busNumber: {
    fontSize: 13,
    fontWeight: "600",
  },
  busSeats: {
    fontSize: 11,
  },
  tourCell: {
    flexDirection: "row",
    alignItems: "center",
    gap: 2,
    flex: 1,
    minWidth: 60,
  },
  tourCellEmpty: {
    borderWidth: 1,
    borderColor: "rgba(128,128,128,0.3)",
    borderStyle: "dashed",
    borderRadius: BorderRadius.sm,
    paddingHorizontal: Spacing.xs,
    paddingVertical: 2,
  },
  tourCellText: {
    fontSize: 11,
  },
  guideCell: {
    flexDirection: "row",
    alignItems: "center",
    gap: 2,
    paddingHorizontal: Spacing.xs,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
    flex: 1,
    minWidth: 70,
  },
  copyRowButton: {
    padding: 4,
  },
  deleteRowButton: {
    padding: 4,
  },
  boatToggle: {
    padding: 4,
    borderRadius: BorderRadius.sm,
    minWidth: 20,
    alignItems: 'center',
  },
  boatToggleText: {
    fontSize: 12,
    fontWeight: '700',
  },
  guideCellText: {
    fontSize: 11,
    flex: 1,
  },
  unassignedGuidesRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    alignItems: "center",
    gap: Spacing.xs,
    marginTop: Spacing.xs,
    paddingTop: Spacing.xs,
    borderTopWidth: 1,
    borderTopColor: "rgba(128,128,128,0.2)",
  },
  unassignedLabel: {
    fontSize: 11,
    marginRight: Spacing.xs,
  },
  freeGuideChip: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.xs,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  freeGuideName: {
    fontSize: 11,
  },
  unassignedGuidesSection: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.md,
  },
  guidesChipsRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
  },
  guideChip: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
  },
  guideChipText: {
    fontSize: 13,
  },
  emptyGuides: {
    alignItems: "center",
    paddingVertical: Spacing.xl,
    gap: Spacing.sm,
  },
  emptyGuidesText: {
    fontSize: 14,
  },
  guideOption: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    paddingVertical: Spacing.md,
    borderBottomWidth: 1,
  },
  guideOptionText: {
    fontSize: 16,
  },
  deleteButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    marginTop: Spacing.lg,
  },
  moveButtonsRow: {
    flexDirection: 'row',
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  moveButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  inlineDropdown: {
    marginLeft: Spacing.md,
    marginBottom: Spacing.xs,
    borderRadius: BorderRadius.md,
    overflow: "hidden",
    maxHeight: 200,
  },
  dropdownItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(128,128,128,0.1)",
  },
  dropdownItemText: {
    fontSize: 14,
  },
});
