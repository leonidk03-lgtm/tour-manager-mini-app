import { useState, useEffect, useRef, useMemo } from "react";
import { View, StyleSheet, TextInput, Pressable, Platform, Modal, FlatList, Alert, Keyboard, TouchableWithoutFeedback } from "react-native";
import { WebView, WebViewMessageEvent } from "react-native-webview";
import type WebViewType from "react-native-webview";
import { Icon } from "@/components/Icon";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation } from "@react-navigation/native";
import type { NativeStackNavigationProp } from "@react-navigation/native-stack";
import AsyncStorage from "@react-native-async-storage/async-storage";
import * as Clipboard from "expo-clipboard";
import { BlurView } from "expo-blur";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { useTheme } from "@/hooks/useTheme";
import { useData, DispatchingNote, Excursion } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { Spacing, BorderRadius, Typography } from "@/constants/theme";
import { hapticFeedback } from "@/utils/haptics";
import { DispatchingStackParamList } from "@/navigation/DispatchingStackNavigator";

const DEFAULT_DATABASE_URL = "http://turburo-kazan.ru/managers/zapis-na-ekskursiyu.php?arrFilter_ff%5BNAME%5D=&arrFilter_DATE_ACTIVE_FROM_1=&arrFilter_DATE_ACTIVE_FROM_2=&arrFilter_pf%5BTYPE%5D=&arrFilter_pf%5BGOSTINICI%5D=&arrFilter_CREATED_BY=&sort=date_ex&USER_REMEMBER=Y&set_filter=Показать&set_filter=Y";
export const DISPATCH_URL_KEY = "@dispatch_webview_url";
const DISPATCH_TABS_KEY = "@dispatch_browser_tabs";

interface BrowserTab {
  id: string;
  url: string;
  title: string;
}

type NavigationProp = NativeStackNavigationProp<DispatchingStackParamList, 'Dispatching'>;

export default function DispatchingScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const navigation = useNavigation<NavigationProp>();
  const { dispatchingNotes, addDispatchingNote, updateDispatchingNote, deleteDispatchingNote, excursions, tourTypes, addExcursionNote, linkDispatchingNoteToExcursion } = useData();
  const { profile, isAdmin } = useAuth();
  const [currentNote, setCurrentNote] = useState("");
  const [showNotesList, setShowNotesList] = useState(false);
  const [showFullscreenNote, setShowFullscreenNote] = useState(false);
  const [editingNote, setEditingNote] = useState<DispatchingNote | null>(null);
  const [showCalculator, setShowCalculator] = useState(false);
  const [calcDisplay, setCalcDisplay] = useState("0");
  const [calcPrevValue, setCalcPrevValue] = useState<number | null>(null);
  const [calcOperation, setCalcOperation] = useState<string | null>(null);
  const [calcWaitingForOperand, setCalcWaitingForOperand] = useState(false);
  const [webViewUrl, setWebViewUrl] = useState(DEFAULT_DATABASE_URL);
  const [isSaving, setIsSaving] = useState(false);
  const [showExcursionPicker, setShowExcursionPicker] = useState(false);
  const [selectedNoteForLink, setSelectedNoteForLink] = useState<DispatchingNote | null>(null);
  const [searchQuery, setSearchQuery] = useState("");
  const [searchResult, setSearchResult] = useState<string | null>(null);
  const [tabs, setTabs] = useState<BrowserTab[]>([
    { id: '1', url: DEFAULT_DATABASE_URL, title: 'Вкладка 1' }
  ]);
  const [activeTabId, setActiveTabId] = useState('1');
  const webViewRef = useRef<WebViewType>(null);
  const webViewRefs = useRef<{ [key: string]: WebViewType | null }>({});
  const prevNoteRef = useRef("");
  const processedCodesRef = useRef<Set<string>>(new Set());

  const activeTab = tabs.find(t => t.id === activeTabId) || tabs[0];

  // Filter out notes linked to past excursions (hide after excursion day)
  const visibleNotes = useMemo(() => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    return dispatchingNotes.filter(note => {
      // Show all notes without linkedExcursionId
      if (!note.linkedExcursionId) return true;
      
      // Find linked excursion
      const linkedExcursion = excursions.find(e => e.id === note.linkedExcursionId);
      if (!linkedExcursion) return true; // Show if excursion not found
      
      // Parse excursion date
      const [year, month, day] = linkedExcursion.date.split('-').map(Number);
      const excursionDate = new Date(year, month - 1, day);
      excursionDate.setHours(0, 0, 0, 0);
      
      // Hide if excursion day has passed
      return excursionDate >= today;
    });
  }, [dispatchingNotes, excursions]);

  useEffect(() => {
    loadTabs();
  }, []);

  useEffect(() => {
    saveTabs();
  }, [tabs, activeTabId]);

  const loadTabs = async () => {
    try {
      const savedTabs = await AsyncStorage.getItem(DISPATCH_TABS_KEY);
      if (savedTabs) {
        const parsed = JSON.parse(savedTabs);
        if (parsed.tabs && parsed.tabs.length > 0) {
          setTabs(parsed.tabs);
          setActiveTabId(parsed.activeTabId || parsed.tabs[0].id);
        }
      }
    } catch (error) {
      console.error("Failed to load tabs:", error);
    }
  };

  const saveTabs = async () => {
    try {
      await AsyncStorage.setItem(DISPATCH_TABS_KEY, JSON.stringify({
        tabs,
        activeTabId
      }));
    } catch (error) {
      console.error("Failed to save tabs:", error);
    }
  };

  const addNewTab = () => {
    hapticFeedback.medium();
    const newId = String(Date.now());
    const newTab: BrowserTab = {
      id: newId,
      url: DEFAULT_DATABASE_URL,
      title: `Вкладка ${tabs.length + 1}`
    };
    setTabs([...tabs, newTab]);
    setActiveTabId(newId);
  };

  const closeTab = (tabId: string) => {
    if (tabs.length === 1) {
      Alert.alert("Внимание", "Нельзя закрыть последнюю вкладку");
      return;
    }
    hapticFeedback.light();
    const newTabs = tabs.filter(t => t.id !== tabId);
    setTabs(newTabs);
    if (activeTabId === tabId) {
      setActiveTabId(newTabs[0].id);
    }
  };

  const switchTab = (tabId: string) => {
    if (tabId !== activeTabId) {
      hapticFeedback.selection();
      setActiveTabId(tabId);
    }
  };

  const updateTabUrl = (tabId: string, url: string) => {
    setTabs(tabs.map(t => t.id === tabId ? { ...t, url } : t));
  };

  const renameTab = (tabId: string) => {
    const tab = tabs.find(t => t.id === tabId);
    if (!tab) return;
    
    Alert.prompt(
      "Переименовать вкладку",
      "Введите новое название",
      [
        { text: "Отмена", style: "cancel" },
        { 
          text: "OK", 
          onPress: (name?: string) => {
            if (name && name.trim()) {
              setTabs(tabs.map(t => t.id === tabId ? { ...t, title: name.trim() } : t));
            }
          }
        }
      ],
      "plain-text",
      tab.title
    );
  };

  const handleNoteChange = (text: string) => {
    const prevText = prevNoteRef.current;
    setCurrentNote(text);
    prevNoteRef.current = text;
    
    // Check for trigger patterns:
    // 1. Period after 4 digits (1234.)
    // 2. Double space after 4 digits (1234  ) - for manual trigger
    // 3. Period + space (iOS converts double space to ". ") - 1234. 
    
    const triggers = [
      { pattern: /(\d{4})\.$/, extract: 1 },           // 1234.
      { pattern: /(\d{4})  $/, extract: 1 },           // 1234  (double space)
      { pattern: /(\d{4})\. $/, extract: 1 },          // 1234. (period + space, iOS style)
    ];
    
    for (const trigger of triggers) {
      const match = text.match(trigger.pattern);
      if (match) {
        const code = match[trigger.extract];
        // Only search if we haven't processed this code recently
        if (!processedCodesRef.current.has(code)) {
          processedCodesRef.current.add(code);
          searchInWebView(code);
          
          // Clear from processed after 3 seconds to allow re-search
          setTimeout(() => {
            processedCodesRef.current.delete(code);
          }, 3000);
        }
        break;
      }
    }
  };

  const loadWebViewUrl = async () => {
    try {
      const savedUrl = await AsyncStorage.getItem(DISPATCH_URL_KEY);
      if (savedUrl !== null) {
        setWebViewUrl(savedUrl);
      }
    } catch (error) {
      console.error("Failed to load webview URL:", error);
    }
  };

  const searchInWebView = (query: string) => {
    const activeWebView = webViewRefs.current[activeTabId];
    if (!activeWebView || !query.trim()) return;
    
    const jsCode = `
      (function() {
        // Remove previous highlights
        document.querySelectorAll('.search-highlight').forEach(el => {
          el.outerHTML = el.textContent;
        });
        
        var searchText = '${query.replace(/'/g, "\\'")}';
        var found = false;
        var firstMatch = null;
        
        // Search in all text nodes
        var walker = document.createTreeWalker(
          document.body,
          NodeFilter.SHOW_TEXT,
          null,
          false
        );
        
        var nodesToHighlight = [];
        while (walker.nextNode()) {
          var node = walker.currentNode;
          if (node.textContent.includes(searchText)) {
            nodesToHighlight.push(node);
          }
        }
        
        nodesToHighlight.forEach(function(node, index) {
          var text = node.textContent;
          var idx = text.indexOf(searchText);
          if (idx >= 0) {
            var span = document.createElement('span');
            span.className = 'search-highlight';
            span.style.backgroundColor = '#FFEB3B';
            span.style.color = '#000';
            span.style.padding = '2px';
            span.style.borderRadius = '3px';
            span.textContent = text.substring(idx, idx + searchText.length);
            
            var before = document.createTextNode(text.substring(0, idx));
            var after = document.createTextNode(text.substring(idx + searchText.length));
            
            var parent = node.parentNode;
            parent.insertBefore(before, node);
            parent.insertBefore(span, node);
            parent.insertBefore(after, node);
            parent.removeChild(node);
            
            if (index === 0) {
              firstMatch = span;
              found = true;
            }
          }
        });
        
        if (firstMatch) {
          firstMatch.scrollIntoView({ behavior: 'smooth', block: 'center' });
          window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'searchResult', found: true, count: nodesToHighlight.length }));
        } else {
          window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'searchResult', found: false, count: 0 }));
        }
      })();
      true;
    `;
    
    activeWebView.injectJavaScript(jsCode);
  };

  const handleWebViewMessage = async (event: WebViewMessageEvent) => {
    try {
      const data = JSON.parse(event.nativeEvent.data);
      if (data.type === 'searchResult') {
        if (data.found) {
          setSearchResult(`Найдено: ${data.count}`);
          hapticFeedback.success();
        } else {
          setSearchResult("Не найдено");
          hapticFeedback.error();
        }
        // Clear result after 3 seconds
        setTimeout(() => setSearchResult(null), 3000);
      } else if (data.type === 'callList') {
        const phones: string[] = data.phones || [];
        if (phones.length === 0) {
          hapticFeedback.error();
          Alert.alert("Обзвон", "Нет номеров для обзвона.\n\nВсе клиенты либо отмечены (зелёные), либо количество = 0.");
        } else {
          const text = phones.join('\n');
          await Clipboard.setStringAsync(text);
          hapticFeedback.success();
          Alert.alert(
            "Скопировано",
            `${phones.length} номер(ов) для обзвона:\n\n${phones.slice(0, 5).join('\n')}${phones.length > 5 ? `\n... и ещё ${phones.length - 5}` : ''}`
          );
        }
      }
    } catch (e) {
      // Ignore non-JSON messages
    }
  };

  const formatNoteDate = (dateStr: string) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const handleSaveNote = async () => {
    if (!currentNote.trim()) {
      Alert.alert("Внимание", "Введите текст заметки");
      return;
    }

    if (isSaving) return;
    setIsSaving(true);

    try {
      if (editingNote) {
        await updateDispatchingNote(editingNote.id, currentNote.trim());
        setEditingNote(null);
      } else {
        await addDispatchingNote(currentNote.trim());
      }
      hapticFeedback.success();
      setCurrentNote("");
      setShowFullscreenNote(false);
    } catch (err) {
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось сохранить заметку");
    } finally {
      setIsSaving(false);
    }
  };

  const handleDeleteNote = (noteId: string) => {
    Alert.alert("Удалить заметку?", "Это действие нельзя отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          try {
            await deleteDispatchingNote(noteId);
            hapticFeedback.success();
          } catch (err) {
            hapticFeedback.error();
            Alert.alert("Ошибка", "Не удалось удалить заметку");
          }
        },
      },
    ]);
  };

  const handleEditNote = (note: DispatchingNote) => {
    setEditingNote(note);
    setCurrentNote(note.text);
    setShowNotesList(false);
  };

  const handleCancelEdit = () => {
    setEditingNote(null);
    setCurrentNote("");
    setShowFullscreenNote(false);
  };

  const dismissKeyboard = () => {
    Keyboard.dismiss();
  };

  const getTourTypeName = (tourTypeId: string) => {
    const tourType = tourTypes.find((t) => t.id === tourTypeId);
    return tourType?.name || "Неизвестная экскурсия";
  };

  const getAvailableExcursions = (): Excursion[] => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    return excursions
      .filter((exc) => {
        const excDate = new Date(exc.date);
        excDate.setHours(0, 0, 0, 0);
        return excDate.getTime() === today.getTime();
      })
      .sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
  };

  const handleOpenExcursionPicker = (note: DispatchingNote) => {
    setShowNotesList(false);
    setSelectedNoteForLink(note);
    setTimeout(() => {
      setShowExcursionPicker(true);
    }, 300);
  };

  const handleLinkToExcursion = async (excursion: Excursion) => {
    if (!selectedNoteForLink || !profile?.id) return;

    try {
      await addExcursionNote(excursion.id, selectedNoteForLink.text);
      await linkDispatchingNoteToExcursion(selectedNoteForLink.id, excursion.id);
      hapticFeedback.success();
      Alert.alert("Готово", "Заметка привязана к экскурсии");
      setShowExcursionPicker(false);
      setSelectedNoteForLink(null);
    } catch (err) {
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось привязать заметку");
    }
  };

  const getLinkedExcursionName = (excursionId: string | null | undefined): string | null => {
    if (!excursionId) return null;
    const excursion = excursions.find(e => e.id === excursionId);
    if (!excursion) return null;
    return getTourTypeName(excursion.tourTypeId);
  };

  const formatCalcDisplay = (value: string): string => {
    const num = parseFloat(value);
    if (isNaN(num)) return value;
    if (Number.isInteger(num) && value.length > 12) {
      return num.toExponential(6);
    }
    if (value.length > 15) {
      return num.toPrecision(10);
    }
    return value;
  };

  const handleCalcDigit = (digit: string) => {
    hapticFeedback.light();
    if (calcWaitingForOperand) {
      setCalcDisplay(digit);
      setCalcWaitingForOperand(false);
    } else {
      setCalcDisplay(calcDisplay === "0" ? digit : calcDisplay + digit);
    }
  };

  const handleCalcDecimal = () => {
    hapticFeedback.light();
    if (calcWaitingForOperand) {
      setCalcDisplay("0.");
      setCalcWaitingForOperand(false);
    } else if (!calcDisplay.includes(".")) {
      setCalcDisplay(calcDisplay + ".");
    }
  };

  const handleCalcOperation = (op: string) => {
    hapticFeedback.light();
    const current = parseFloat(calcDisplay);
    
    if (calcPrevValue !== null && !calcWaitingForOperand) {
      const result = calculate(calcPrevValue, current, calcOperation!);
      setCalcDisplay(String(result));
      setCalcPrevValue(result);
    } else {
      setCalcPrevValue(current);
    }
    
    setCalcOperation(op);
    setCalcWaitingForOperand(true);
  };

  const calculate = (a: number, b: number, op: string): number => {
    switch (op) {
      case "+": return a + b;
      case "-": return a - b;
      case "×": return a * b;
      case "÷": return b !== 0 ? a / b : 0;
      default: return b;
    }
  };

  const handleCalcEquals = () => {
    hapticFeedback.medium();
    if (calcPrevValue === null || calcOperation === null) return;
    
    const current = parseFloat(calcDisplay);
    const result = calculate(calcPrevValue, current, calcOperation);
    setCalcDisplay(String(result));
    setCalcPrevValue(null);
    setCalcOperation(null);
    setCalcWaitingForOperand(true);
  };

  const handleCalcClear = () => {
    hapticFeedback.light();
    setCalcDisplay("0");
    setCalcPrevValue(null);
    setCalcOperation(null);
    setCalcWaitingForOperand(false);
  };

  const CalcButton = ({ label, onPress, style, textStyle }: { label: string; onPress: () => void; style?: object; textStyle?: object }) => (
    <Pressable
      style={({ pressed }) => [
        styles.calcButton,
        { backgroundColor: theme.backgroundSecondary },
        style,
        pressed && { opacity: 0.7 },
      ]}
      onPress={onPress}
    >
      <ThemedText style={[styles.calcButtonText, textStyle]}>{label}</ThemedText>
    </Pressable>
  );

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <TouchableWithoutFeedback onPress={dismissKeyboard} accessible={false}>
        <View style={[styles.notesContainer, { paddingTop: Spacing.md }]}>
        <View style={styles.notesHeader}>
          <ThemedText style={styles.notesTitle}>Заметки</ThemedText>
          <View style={styles.notesActions}>
            <Pressable
              style={({ pressed }) => [
                styles.notesHeaderButton,
                { backgroundColor: theme.success, opacity: pressed ? 0.7 : 1 },
              ]}
              onPress={() => {
                hapticFeedback.medium();
                navigation.navigate('Allocation');
              }}
            >
              <Icon name="git-branch" size={16} color={theme.buttonText} />
              <ThemedText style={[styles.notesHeaderButtonText, { color: theme.buttonText }]}>
                Распред.
              </ThemedText>
            </Pressable>
            {visibleNotes.length > 0 ? (
              <Pressable
                style={({ pressed }) => [
                  styles.notesHeaderButton,
                  { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
                ]}
                onPress={() => {
                  hapticFeedback.selection();
                  setShowNotesList(true);
                }}
              >
                <Icon name="list" size={16} color={theme.text} />
                <ThemedText style={styles.notesHeaderButtonText}>
                  {visibleNotes.length}
                </ThemedText>
              </Pressable>
            ) : null}
            <Pressable
              style={({ pressed }) => [
                styles.notesHeaderButton,
                { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
              ]}
              onPress={() => {
                hapticFeedback.medium();
                setShowFullscreenNote(true);
              }}
            >
              <Icon name="plus" size={16} color={theme.buttonText} />
            </Pressable>
          </View>
        </View>

        {editingNote ? (
          <View style={styles.editingIndicator}>
            <ThemedText style={[styles.editingText, { color: theme.primary }]}>
              Редактирование заметки
            </ThemedText>
            <Pressable onPress={handleCancelEdit}>
              <Icon name="x" size={18} color={theme.error} />
            </Pressable>
          </View>
        ) : null}

        <View style={[styles.noteInputContainer, { backgroundColor: theme.backgroundSecondary, flex: 1 }]}>
          <TextInput
            style={[styles.noteInput, { color: theme.text, flex: 1 }]}
            placeholder="Быстрая заметка... (1234. для поиска)"
            placeholderTextColor={theme.textSecondary}
            value={currentNote}
            onChangeText={handleNoteChange}
            multiline
          />
          <Pressable
            style={[styles.expandButton, { backgroundColor: theme.backgroundTertiary }]}
            onPress={() => {
              hapticFeedback.light();
              setShowFullscreenNote(true);
            }}
          >
            <Icon name="edit-3" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.expandButtonText, { color: theme.textSecondary }]}>Развернуть</ThemedText>
          </Pressable>
          {currentNote.trim() ? (
            <Pressable
              style={[styles.sendButton, { backgroundColor: theme.primary, position: "absolute", right: Spacing.sm, bottom: Spacing.sm }]}
              onPress={handleSaveNote}
              disabled={isSaving}
            >
              <Icon name={editingNote ? "check" : "send"} size={16} color={theme.buttonText} />
            </Pressable>
          ) : null}
        </View>
        </View>
      </TouchableWithoutFeedback>

      <View style={styles.webViewContainer}>
        {/* Browser Tabs */}
        <View style={[styles.tabsContainer, { backgroundColor: theme.backgroundSecondary }]}>
          <FlatList
            horizontal
            data={tabs}
            keyExtractor={(item) => item.id}
            showsHorizontalScrollIndicator={false}
            contentContainerStyle={styles.tabsList}
            renderItem={({ item }) => (
              <Pressable
                style={[
                  styles.tab,
                  { 
                    backgroundColor: item.id === activeTabId ? theme.backgroundTertiary : 'transparent',
                    borderColor: item.id === activeTabId ? theme.primary : 'transparent',
                  }
                ]}
                onPress={() => switchTab(item.id)}
                onLongPress={() => renameTab(item.id)}
              >
                <ThemedText 
                  style={[
                    styles.tabTitle, 
                    { color: item.id === activeTabId ? theme.text : theme.textSecondary }
                  ]}
                  numberOfLines={1}
                >
                  {item.title}
                </ThemedText>
                {tabs.length > 1 ? (
                  <Pressable
                    style={styles.tabCloseButton}
                    onPress={() => closeTab(item.id)}
                    hitSlop={{ top: 10, bottom: 10, left: 5, right: 10 }}
                  >
                    <Icon name="x" size={12} color={theme.textSecondary} />
                  </Pressable>
                ) : null}
              </Pressable>
            )}
          />
          <Pressable
            style={[styles.tabActionButton, { backgroundColor: theme.backgroundTertiary, marginRight: Spacing.xs }]}
            onPress={() => {
              hapticFeedback.medium();
              const activeWebView = webViewRefs.current[activeTabId];
              if (activeWebView) {
                activeWebView.reload();
              }
            }}
          >
            <Icon name="refresh-cw" size={16} color={theme.text} />
          </Pressable>
          <Pressable
            style={[styles.tabActionButton, { backgroundColor: theme.success, marginRight: Spacing.xs }]}
            onPress={() => {
              hapticFeedback.medium();
              const activeWebView = webViewRefs.current[activeTabId];
              if (activeWebView) {
                const callListScript = `
                  (function(){
                    var rows = document.querySelectorAll('table tr');
                    var phones = [];
                    rows.forEach(function(row) {
                      var bg = getComputedStyle(row).backgroundColor;
                      var cells = row.querySelectorAll('td');
                      if (!cells.length) return;
                      var firstCell = cells[0];
                      var cellBg = getComputedStyle(firstCell).backgroundColor;
                      var combinedBg = bg + cellBg;
                      if (combinedBg.toLowerCase().includes('green') ||
                          /rgb\\(\\s*\\d{1,2}\\s*,\\s*(1[2-9]\\d|2\\d\\d)\\s*,\\s*\\d{1,3}\\s*\\)/.test(combinedBg) ||
                          combinedBg.includes('144, 238') ||
                          combinedBg.includes('152, 251') ||
                          combinedBg.includes('0, 128, 0') ||
                          combinedBg.includes('34, 139') ||
                          combinedBg.includes('50, 205')) return;
                      var phoneCell = cells[0];
                      var countCell = cells[3];
                      var phone = phoneCell ? phoneCell.innerText.trim() : '';
                      var count = parseInt(countCell ? countCell.innerText.trim() : '0') || 0;
                      if (phone && phone.startsWith('+') && count > 0) {
                        phones.push(phone + ' (' + count + ')');
                      }
                    });
                    window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'callList', phones: phones }));
                  })();
                  true;
                `;
                activeWebView.injectJavaScript(callListScript);
              }
            }}
          >
            <Icon name="phone" size={16} color={theme.buttonText} />
          </Pressable>
          <Pressable
            style={[styles.tabActionButton, { backgroundColor: theme.primary }]}
            onPress={addNewTab}
          >
            <Icon name="plus" size={16} color={theme.buttonText} />
          </Pressable>
        </View>

        <View style={[styles.searchBar, { backgroundColor: theme.backgroundSecondary }]}>
          <Icon name="search" size={18} color={theme.textSecondary} />
          <TextInput
            style={[styles.searchInput, { color: theme.text }]}
            placeholder="Поиск по номеру (4 цифры)..."
            placeholderTextColor={theme.textSecondary}
            value={searchQuery}
            onChangeText={setSearchQuery}
            keyboardType="number-pad"
            maxLength={10}
            returnKeyType="search"
            onSubmitEditing={() => {
              if (searchQuery.trim()) {
                searchInWebView(searchQuery);
                Keyboard.dismiss();
              }
            }}
          />
          {searchQuery.trim() ? (
            <Pressable
              style={[styles.searchButton, { backgroundColor: theme.primary }]}
              onPress={() => {
                searchInWebView(searchQuery);
                Keyboard.dismiss();
              }}
            >
              <ThemedText style={[styles.searchButtonText, { color: theme.buttonText }]}>Найти</ThemedText>
            </Pressable>
          ) : null}
          {searchResult ? (
            <ThemedText style={[styles.searchResultText, { color: searchResult === "Не найдено" ? theme.error : theme.success }]}>
              {searchResult}
            </ThemedText>
          ) : null}
        </View>
        {Platform.OS === "web" ? (
          <View style={[styles.webFallback, { backgroundColor: theme.backgroundDefault }]}>
            <Icon name="globe" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.webFallbackText, { color: theme.textSecondary }]}>
              Откройте приложение в Expo Go для доступа к браузеру
            </ThemedText>
          </View>
        ) : (
          <View style={styles.webViewsWrapper}>
            {tabs.map((tab) => (
              <View 
                key={tab.id}
                style={[
                  styles.webViewWrapper,
                  { display: tab.id === activeTabId ? 'flex' : 'none' }
                ]}
              >
                <WebView
                  ref={(ref) => { webViewRefs.current[tab.id] = ref; }}
                  source={{ uri: tab.url }}
                  style={styles.webView}
                  startInLoadingState={true}
                  javaScriptEnabled={true}
                  domStorageEnabled={true}
                  onMessage={handleWebViewMessage}
                  onNavigationStateChange={(navState) => {
                    if (navState.url && navState.url !== tab.url) {
                      updateTabUrl(tab.id, navState.url);
                    }
                  }}
                />
              </View>
            ))}
          </View>
        )}
      </View>

      <Pressable
        style={[styles.fab, { bottom: insets.bottom + 90 }]}
        onPress={() => {
          hapticFeedback.light();
          setShowCalculator(true);
        }}
      >
        <BlurView intensity={100} tint="dark" style={styles.fabBlur}>
          <Icon name="percent" size={24} color="#FFFFFF" />
        </BlurView>
      </Pressable>

      <Modal
        visible={showNotesList}
        transparent
        animationType="slide"
        onRequestClose={() => setShowNotesList(false)}
      >
        <Pressable style={styles.modalBackdrop} onPress={() => setShowNotesList(false)}>
          <TouchableWithoutFeedback>
            <ThemedView style={[styles.notesListModal, { backgroundColor: theme.backgroundDefault }]}>
              <View style={styles.notesListHeader}>
                <ThemedText style={styles.notesListTitle}>Все заметки</ThemedText>
                <Pressable onPress={() => setShowNotesList(false)}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>

              <FlatList
                data={visibleNotes}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => {
                  const linkedName = getLinkedExcursionName(item.linkedExcursionId);
                  return (
                    <View style={[styles.noteItem, { borderBottomColor: theme.border }]}>
                      <View style={styles.noteContent}>
                        <ThemedText style={styles.noteText} numberOfLines={3}>
                          {item.text}
                        </ThemedText>
                        <View style={styles.noteMetaRow}>
                          <ThemedText style={[styles.noteDate, { color: theme.textSecondary }]}>
                            {formatNoteDate(item.createdAt)}
                          </ThemedText>
                          {linkedName ? (
                            <View style={[styles.linkedBadge, { backgroundColor: theme.success + '20' }]}>
                              <Icon name="link" size={10} color={theme.success} />
                              <ThemedText style={[styles.linkedBadgeText, { color: theme.success }]} numberOfLines={1}>
                                {linkedName}
                              </ThemedText>
                            </View>
                          ) : null}
                        </View>
                      </View>
                      <View style={styles.noteActions}>
                        <Pressable
                          style={styles.noteActionButton}
                          onPress={() => {
                            hapticFeedback.selection();
                            handleOpenExcursionPicker(item);
                          }}
                        >
                          <Icon name={linkedName ? "link-2" : "link"} size={18} color={theme.success} />
                        </Pressable>
                        <Pressable
                          style={styles.noteActionButton}
                          onPress={() => {
                            hapticFeedback.selection();
                            handleEditNote(item);
                          }}
                        >
                          <Icon name="edit-2" size={18} color={theme.primary} />
                        </Pressable>
                        <Pressable
                          style={styles.noteActionButton}
                          onPress={() => {
                            hapticFeedback.light();
                            handleDeleteNote(item.id);
                          }}
                        >
                          <Icon name="trash-2" size={18} color={theme.error} />
                        </Pressable>
                      </View>
                    </View>
                  );
                }}
                ListEmptyComponent={
                  <View style={styles.emptyNotes}>
                    <Icon name="file-text" size={48} color={theme.textSecondary} />
                    <ThemedText style={[styles.emptyNotesText, { color: theme.textSecondary }]}>
                      Нет заметок
                    </ThemedText>
                  </View>
                }
              />
            </ThemedView>
          </TouchableWithoutFeedback>
        </Pressable>
      </Modal>

      <Modal
        visible={showFullscreenNote}
        animationType="slide"
        presentationStyle="pageSheet"
        onRequestClose={handleCancelEdit}
      >
        <ThemedView style={[styles.fullscreenNoteContainer, { backgroundColor: theme.backgroundRoot }]}>
          <View style={[styles.fullscreenNoteHeader, { borderBottomColor: theme.border }]}>
            <Pressable onPress={handleCancelEdit}>
              <ThemedText style={{ color: theme.primary }}>Отмена</ThemedText>
            </Pressable>
            <ThemedText style={styles.fullscreenNoteTitle}>
              {editingNote ? "Редактировать" : "Новая заметка"}
            </ThemedText>
            <Pressable onPress={handleSaveNote} disabled={isSaving}>
              <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>
                {isSaving ? "..." : "Сохранить"}
              </ThemedText>
            </Pressable>
          </View>
          <TextInput
            style={[styles.fullscreenNoteInput, { color: theme.text }]}
            placeholder="Введите заметку... (1234. для поиска)"
            placeholderTextColor={theme.textSecondary}
            value={currentNote}
            onChangeText={handleNoteChange}
            multiline
            autoFocus
          />
        </ThemedView>
      </Modal>

      <Modal
        visible={showCalculator}
        transparent
        animationType="fade"
        onRequestClose={() => setShowCalculator(false)}
      >
        <Pressable style={styles.calcModalBackdrop} onPress={() => setShowCalculator(false)}>
          <Pressable style={[styles.calculatorContainer, { backgroundColor: theme.backgroundDefault }]} onPress={(e) => e.stopPropagation()}>
            <View style={styles.calcHeader}>
              <ThemedText style={styles.calcTitle}>Калькулятор</ThemedText>
              <Pressable onPress={() => setShowCalculator(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={[styles.calcDisplay, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.calcDisplayText} numberOfLines={1} adjustsFontSizeToFit minimumFontScale={0.5}>
                {formatCalcDisplay(calcDisplay)}
              </ThemedText>
            </View>

            <View style={styles.calcGrid}>
              <View style={styles.calcRow}>
                <CalcButton label="C" onPress={handleCalcClear} style={{ backgroundColor: theme.error }} textStyle={{ color: "#FFFFFF" }} />
                <CalcButton label="÷" onPress={() => handleCalcOperation("÷")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
                <CalcButton label="×" onPress={() => handleCalcOperation("×")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
                <CalcButton label="-" onPress={() => handleCalcOperation("-")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="7" onPress={() => handleCalcDigit("7")} />
                <CalcButton label="8" onPress={() => handleCalcDigit("8")} />
                <CalcButton label="9" onPress={() => handleCalcDigit("9")} />
                <CalcButton label="+" onPress={() => handleCalcOperation("+")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="4" onPress={() => handleCalcDigit("4")} />
                <CalcButton label="5" onPress={() => handleCalcDigit("5")} />
                <CalcButton label="6" onPress={() => handleCalcDigit("6")} />
                <CalcButton label="=" onPress={handleCalcEquals} style={{ backgroundColor: theme.success }} textStyle={{ color: "#FFFFFF" }} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="1" onPress={() => handleCalcDigit("1")} />
                <CalcButton label="2" onPress={() => handleCalcDigit("2")} />
                <CalcButton label="3" onPress={() => handleCalcDigit("3")} />
                <CalcButton label="." onPress={handleCalcDecimal} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="0" onPress={() => handleCalcDigit("0")} style={{ flex: 2 }} />
                <View style={{ flex: 2 }} />
              </View>
            </View>
          </Pressable>
        </Pressable>
      </Modal>

      <Modal
        visible={showExcursionPicker}
        transparent
        animationType="slide"
        onRequestClose={() => {
          setShowExcursionPicker(false);
          setSelectedNoteForLink(null);
        }}
      >
        <View style={styles.modalBackdrop}>
          <Pressable 
            style={StyleSheet.absoluteFill} 
            onPress={() => {
              setShowExcursionPicker(false);
              setSelectedNoteForLink(null);
            }}
          />
          <ThemedView style={[styles.excursionPickerModal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.excursionPickerHeader}>
              <ThemedText style={styles.excursionPickerTitle}>Привязать к экскурсии</ThemedText>
              <Pressable onPress={() => {
                setShowExcursionPicker(false);
                setSelectedNoteForLink(null);
              }}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            
            {selectedNoteForLink ? (
              <View style={[styles.selectedNotePreview, { backgroundColor: theme.backgroundSecondary }]}>
                <ThemedText numberOfLines={2} style={styles.selectedNoteText}>
                  {selectedNoteForLink.text}
                </ThemedText>
              </View>
            ) : null}

            {getAvailableExcursions().length === 0 ? (
              <View style={styles.emptyExcursions}>
                <Icon name="calendar" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                  Нет доступных экскурсий
                </ThemedText>
                <ThemedText style={{ color: theme.textSecondary, fontSize: 12, marginTop: Spacing.xs }}>
                  Добавьте экскурсию на сегодня или будущие даты
                </ThemedText>
              </View>
            ) : (
              <FlatList
                data={getAvailableExcursions()}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => {
                  const excDate = new Date(item.date);
                  const isToday = excDate.toDateString() === new Date().toDateString();
                  return (
                    <Pressable
                      style={({ pressed }) => [
                        styles.excursionItem,
                        { backgroundColor: pressed ? theme.backgroundTertiary : theme.backgroundSecondary },
                      ]}
                      onPress={() => handleLinkToExcursion(item)}
                    >
                      <View style={styles.excursionItemContent}>
                        <ThemedText style={styles.excursionItemName} numberOfLines={1}>
                          {getTourTypeName(item.tourTypeId)}
                        </ThemedText>
                      </View>
                      <Icon name="chevron-right" size={20} color={theme.textSecondary} />
                    </Pressable>
                  );
                }}
                ItemSeparatorComponent={() => <View style={{ height: Spacing.sm }} />}
                contentContainerStyle={{ paddingBottom: Spacing.xl }}
              />
            )}
          </ThemedView>
        </View>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  notesContainer: {
    flex: 0.4,
    paddingHorizontal: Spacing.md,
    paddingBottom: Spacing.md,
    gap: Spacing.sm,
  },
  notesHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  notesTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  notesActions: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  notesHeaderButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  notesHeaderButtonText: {
    fontSize: 14,
    fontWeight: "500",
  },
  editingIndicator: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.sm,
  },
  editingText: {
    fontSize: 13,
    fontWeight: "500",
  },
  noteInputContainer: {
    borderRadius: BorderRadius.md,
    padding: Spacing.sm,
  },
  noteInput: {
    flex: 1,
    fontSize: 15,
    textAlignVertical: "top",
    paddingVertical: Spacing.xs,
    paddingRight: 90,
  },
  expandButton: {
    position: "absolute",
    right: Spacing.sm,
    top: Spacing.sm,
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.sm,
  },
  expandButtonText: {
    fontSize: 12,
    fontWeight: "500",
  },
  sendButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: "center",
    alignItems: "center",
  },
  webViewContainer: {
    flex: 0.6,
  },
  searchBar: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    gap: Spacing.sm,
  },
  searchInput: {
    flex: 1,
    fontSize: 15,
    paddingVertical: Spacing.xs,
  },
  searchButton: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  searchButtonText: {
    fontSize: 14,
    fontWeight: "600",
  },
  searchResultText: {
    fontSize: 13,
    fontWeight: "500",
  },
  tabsContainer: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  tabsList: {
    flexDirection: "row",
    gap: Spacing.xs,
    paddingRight: Spacing.sm,
  },
  tab: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.xs,
    paddingLeft: Spacing.sm,
    paddingRight: Spacing.xs,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    minWidth: 120,
    maxWidth: 200,
  },
  tabTitle: {
    fontSize: 13,
    fontWeight: "500",
    flex: 1,
  },
  tabCloseButton: {
    padding: 4,
    marginLeft: 4,
  },
  tabActionButton: {
    width: 32,
    height: 32,
    borderRadius: BorderRadius.sm,
    justifyContent: "center",
    alignItems: "center",
  },
  webViewsWrapper: {
    flex: 1,
  },
  webViewWrapper: {
    flex: 1,
  },
  webView: {
    flex: 1,
  },
  webFallback: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    gap: Spacing.md,
    padding: Spacing.xl,
  },
  webFallbackText: {
    textAlign: "center",
    fontSize: 15,
  },
  fab: {
    position: "absolute",
    right: Spacing.lg,
    width: 56,
    height: 56,
    borderRadius: 28,
    overflow: "hidden",
  },
  fabBlur: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "flex-end",
  },
  notesListModal: {
    maxHeight: "70%",
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    paddingBottom: Spacing.xl,
  },
  notesListHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  notesListTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  noteItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.lg,
    borderBottomWidth: 1,
  },
  noteContent: {
    flex: 1,
    gap: Spacing.xs,
  },
  noteText: {
    fontSize: 15,
  },
  noteDate: {
    fontSize: 12,
  },
  noteMetaRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    flexWrap: "wrap",
  },
  linkedBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.xs,
    maxWidth: 150,
  },
  linkedBadgeText: {
    fontSize: 11,
    fontWeight: "500",
  },
  noteActions: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  noteActionButton: {
    padding: Spacing.sm,
  },
  emptyNotes: {
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing["2xl"],
    gap: Spacing.md,
  },
  emptyNotesText: {
    fontSize: 15,
  },
  fullscreenNoteContainer: {
    flex: 1,
  },
  fullscreenNoteHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    borderBottomWidth: 1,
  },
  fullscreenNoteTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  fullscreenNoteInput: {
    flex: 1,
    fontSize: 16,
    padding: Spacing.lg,
    textAlignVertical: "top",
  },
  calcModalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    alignItems: "center",
  },
  calculatorContainer: {
    width: "85%",
    maxWidth: 320,
    borderRadius: BorderRadius.lg,
    padding: Spacing.lg,
  },
  calcHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  calcTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  calcDisplay: {
    minHeight: 64,
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    alignItems: "flex-end",
    justifyContent: "center",
  },
  calcDisplayText: {
    fontSize: 32,
    fontWeight: "500",
    lineHeight: 40,
  },
  calcGrid: {
    gap: Spacing.sm,
  },
  calcRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  calcButton: {
    flex: 1,
    aspectRatio: 1,
    justifyContent: "center",
    alignItems: "center",
    borderRadius: BorderRadius.md,
  },
  calcButtonText: {
    fontSize: 22,
    fontWeight: "500",
  },
  excursionPickerModal: {
    maxHeight: "70%",
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    padding: Spacing.lg,
  },
  excursionPickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.lg,
  },
  excursionPickerTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  selectedNotePreview: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.lg,
  },
  selectedNoteText: {
    fontSize: 14,
    lineHeight: 20,
  },
  emptyExcursions: {
    alignItems: "center",
    paddingVertical: Spacing["2xl"],
  },
  excursionItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  excursionItemContent: {
    flex: 1,
    gap: Spacing.xs,
  },
  excursionItemName: {
    fontSize: 15,
    fontWeight: "500",
  },
  excursionItemMeta: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  excursionItemDate: {
    fontSize: 13,
    fontWeight: "500",
  },
  excursionItemTime: {
    fontSize: 13,
  },
});
