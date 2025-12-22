import { useState, useRef, useEffect } from 'react';
import { View, StyleSheet, Alert, Pressable, ScrollView, ActivityIndicator, Platform } from 'react-native';
import { WebView } from 'react-native-webview';
import { useNavigation, useRoute, RouteProp } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Feather } from '@expo/vector-icons';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import { useDocumentTemplates, DocumentTemplate, TEMPLATE_TYPE_LABELS, TEMPLATE_VARIABLES } from '@/contexts/DocumentTemplatesContext';
import { Colors, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/useTheme';

type RootStackParamList = {
  TemplateEditor: { templateId?: string; type?: DocumentTemplate['type'] };
};

type TemplateEditorRouteProp = RouteProp<RootStackParamList, 'TemplateEditor'>;

const getQuillHtml = (initialContent: string, isDark: boolean) => `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link href="https://cdn.quilljs.com/1.3.7/quill.snow.css" rel="stylesheet">
  <script src="https://cdn.quilljs.com/1.3.7/quill.min.js"></script>
  <style>
    * { box-sizing: border-box; }
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      background: ${isDark ? '#1a1a1a' : '#ffffff'};
      overflow: hidden;
    }
    #toolbar-container {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 100;
      background: ${isDark ? '#2a2a2a' : '#f5f5f5'};
      border-bottom: 1px solid ${isDark ? '#444' : '#ddd'};
    }
    .ql-toolbar.ql-snow {
      border: none;
      padding: 8px;
    }
    .ql-toolbar.ql-snow .ql-picker-label,
    .ql-toolbar.ql-snow button {
      color: ${isDark ? '#fff' : '#444'};
    }
    .ql-toolbar.ql-snow .ql-stroke {
      stroke: ${isDark ? '#fff' : '#444'};
    }
    .ql-toolbar.ql-snow .ql-fill {
      fill: ${isDark ? '#fff' : '#444'};
    }
    #editor-container {
      position: absolute;
      top: 50px;
      bottom: 0;
      left: 0;
      right: 0;
      overflow-y: auto;
      -webkit-overflow-scrolling: touch;
    }
    .ql-container.ql-snow {
      border: none;
      font-family: 'Times New Roman', Times, serif;
      font-size: 12pt;
    }
    .ql-editor {
      min-height: 100%;
      padding: 16px;
      background: ${isDark ? '#1a1a1a' : '#ffffff'};
      color: ${isDark ? '#ffffff' : '#000000'};
    }
    .ql-editor table {
      border-collapse: collapse;
      width: 100%;
    }
    .ql-editor table td, .ql-editor table th {
      border: 1px solid ${isDark ? '#555' : '#000'};
      padding: 5px 8px;
    }
    .ql-editor .template-var {
      background: ${isDark ? '#3d5a80' : '#e1f0ff'};
      color: ${isDark ? '#fff' : '#0066cc'};
      padding: 2px 6px;
      border-radius: 4px;
      font-family: monospace;
      font-size: 11px;
    }
  </style>
</head>
<body>
  <div id="toolbar-container">
    <div id="toolbar">
      <span class="ql-formats">
        <button class="ql-bold"></button>
        <button class="ql-italic"></button>
        <button class="ql-underline"></button>
      </span>
      <span class="ql-formats">
        <select class="ql-header">
          <option value="1">H1</option>
          <option value="2">H2</option>
          <option value="3">H3</option>
          <option selected></option>
        </select>
      </span>
      <span class="ql-formats">
        <select class="ql-align"></select>
      </span>
      <span class="ql-formats">
        <button class="ql-list" value="ordered"></button>
        <button class="ql-list" value="bullet"></button>
      </span>
      <span class="ql-formats">
        <button class="ql-clean"></button>
      </span>
    </div>
  </div>
  <div id="editor-container">
    <div id="editor"></div>
  </div>
  <script>
    var quill = new Quill('#editor', {
      theme: 'snow',
      modules: {
        toolbar: '#toolbar'
      },
      placeholder: 'Введите содержимое шаблона...'
    });

    var initialContent = ${JSON.stringify(initialContent)};
    if (initialContent) {
      quill.root.innerHTML = initialContent;
    }

    quill.on('text-change', function() {
      var html = quill.root.innerHTML;
      window.ReactNativeWebView.postMessage(JSON.stringify({
        type: 'content-change',
        html: html
      }));
    });

    window.insertVariable = function(varKey) {
      var range = quill.getSelection(true);
      quill.insertText(range.index, varKey, { 'background': '#e1f0ff', 'color': '#0066cc' });
      quill.setSelection(range.index + varKey.length);
    };

    window.getContent = function() {
      return quill.root.innerHTML;
    };

    window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'ready' }));
  </script>
</body>
</html>
`;

export default function TemplateEditorScreen() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const route = useRoute<TemplateEditorRouteProp>();
  const insets = useSafeAreaInsets();
  const { isDark } = useTheme();
  const { templates, createTemplate, updateTemplate } = useDocumentTemplates();

  const { templateId, type: initialType } = route.params || {};
  const existingTemplate = templateId ? templates.find(t => t.id === templateId) : undefined;

  const [name, setName] = useState(existingTemplate?.name || '');
  const [type, setType] = useState<DocumentTemplate['type']>(existingTemplate?.type || initialType || 'invoice');
  const [htmlContent, setHtmlContent] = useState(existingTemplate?.htmlContent || '');
  const [isSaving, setIsSaving] = useState(false);
  const [showVariables, setShowVariables] = useState(false);
  const [isReady, setIsReady] = useState(false);
  
  const webViewRef = useRef<WebView>(null);

  useEffect(() => {
    navigation.setOptions({
      headerTitle: existingTemplate ? 'Редактирование шаблона' : 'Новый шаблон',
    });
  }, [navigation, existingTemplate]);

  const handleMessage = (event: { nativeEvent: { data: string } }) => {
    try {
      const data = JSON.parse(event.nativeEvent.data);
      if (data.type === 'content-change') {
        setHtmlContent(data.html);
      } else if (data.type === 'ready') {
        setIsReady(true);
      }
    } catch (e) {
      console.error('WebView message error:', e);
    }
  };

  const insertVariable = (varKey: string) => {
    if (webViewRef.current && isReady) {
      webViewRef.current.injectJavaScript(`window.insertVariable('${varKey}'); true;`);
    }
    setShowVariables(false);
  };

  const handleSave = async () => {
    if (!name.trim()) {
      Alert.alert('Ошибка', 'Введите название шаблона');
      return;
    }

    if (!htmlContent.trim() || htmlContent === '<p><br></p>') {
      Alert.alert('Ошибка', 'Шаблон не может быть пустым');
      return;
    }

    setIsSaving(true);

    try {
      if (existingTemplate) {
        const { error } = await updateTemplate(existingTemplate.id, {
          name: name.trim(),
          type,
          htmlContent,
        });
        if (error) {
          Alert.alert('Ошибка', error);
        } else {
          navigation.goBack();
        }
      } else {
        const { error } = await createTemplate({
          name: name.trim(),
          type,
          htmlContent,
          isDefault: false,
        });
        if (error) {
          Alert.alert('Ошибка', error);
        } else {
          navigation.goBack();
        }
      }
    } finally {
      setIsSaving(false);
    }
  };

  const colors = isDark ? Colors.dark : Colors.light;

  return (
    <ThemedView style={[styles.container, { paddingTop: insets.top }]}>
      <View style={styles.header}>
        <View style={styles.headerRow}>
          <Pressable onPress={() => navigation.goBack()} style={styles.backButton}>
            <Feather name="arrow-left" size={24} color={colors.text} />
          </Pressable>
          <View style={styles.headerCenter}>
            <ThemedText style={styles.headerTitle}>
              {existingTemplate ? 'Редактирование' : 'Новый шаблон'}
            </ThemedText>
          </View>
          <Pressable onPress={handleSave} disabled={isSaving} style={styles.saveButton}>
            {isSaving ? (
              <ActivityIndicator size="small" color={colors.primary} />
            ) : (
              <ThemedText style={[styles.saveText, { color: colors.primary }]}>
                Сохранить
              </ThemedText>
            )}
          </Pressable>
        </View>

        <View style={[styles.inputRow, { backgroundColor: colors.backgroundSecondary }]}>
          <ThemedText style={styles.inputLabel}>Название:</ThemedText>
          <View style={[styles.textInput, { backgroundColor: colors.backgroundDefault }]}>
            <Pressable
              onPress={() => {
                Alert.prompt(
                  'Название шаблона',
                  'Введите название шаблона',
                  (text) => setName(text || ''),
                  'plain-text',
                  name
                );
              }}
            >
              <ThemedText style={name ? undefined : styles.placeholder}>
                {name || 'Введите название...'}
              </ThemedText>
            </Pressable>
          </View>
        </View>

        <View style={[styles.inputRow, { backgroundColor: colors.backgroundSecondary }]}>
          <ThemedText style={styles.inputLabel}>Тип:</ThemedText>
          <View style={styles.typeButtons}>
            {(['invoice', 'act', 'contract', 'waybill'] as const).map((t) => (
              <Pressable
                key={t}
                style={[
                  styles.typeButton,
                  { backgroundColor: type === t ? colors.primary : colors.backgroundDefault },
                ]}
                onPress={() => setType(t)}
              >
                <ThemedText
                  style={[
                    styles.typeButtonText,
                    { color: type === t ? '#fff' : colors.textSecondary },
                  ]}
                >
                  {TEMPLATE_TYPE_LABELS[t]}
                </ThemedText>
              </Pressable>
            ))}
          </View>
        </View>

        <View style={styles.toolbarRow}>
          <Pressable
            style={[styles.variablesButton, { backgroundColor: colors.primary }]}
            onPress={() => setShowVariables(!showVariables)}
          >
            <Feather name="code" size={16} color="#fff" />
            <ThemedText style={styles.variablesButtonText}>
              Вставить переменную
            </ThemedText>
          </Pressable>
        </View>
      </View>

      {showVariables ? (
        <ScrollView style={[styles.variablesPanel, { backgroundColor: colors.backgroundSecondary }]}>
          {TEMPLATE_VARIABLES.map((category) => (
            <View key={category.category} style={styles.variableCategory}>
              <ThemedText style={styles.categoryTitle}>{category.category}</ThemedText>
              <View style={styles.variablesList}>
                {category.variables.map((v) => (
                  <Pressable
                    key={v.key}
                    style={[styles.variableItem, { backgroundColor: colors.backgroundDefault }]}
                    onPress={() => insertVariable(v.key)}
                  >
                    <ThemedText style={[styles.variableKey, { color: colors.primary }]}>
                      {v.key}
                    </ThemedText>
                    <ThemedText style={styles.variableLabel}>{v.label}</ThemedText>
                  </Pressable>
                ))}
              </View>
            </View>
          ))}
        </ScrollView>
      ) : (
        <View style={styles.editorContainer}>
          {Platform.OS === 'web' ? (
            <View style={styles.webFallback}>
              <ThemedText style={styles.webFallbackText}>
                Редактор доступен только в мобильном приложении.
              </ThemedText>
              <ThemedText style={styles.webFallbackHint}>
                Откройте приложение в Expo Go для редактирования шаблонов.
              </ThemedText>
            </View>
          ) : (
            <WebView
              ref={webViewRef}
              originWhitelist={['*']}
              source={{ html: getQuillHtml(htmlContent, isDark) }}
              onMessage={handleMessage}
              javaScriptEnabled
              domStorageEnabled
              style={styles.webView}
              scrollEnabled={false}
              showsVerticalScrollIndicator={false}
              keyboardDisplayRequiresUserAction={false}
            />
          )}
        </View>
      )}
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(128, 128, 128, 0.2)',
  },
  headerRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  backButton: {
    padding: Spacing.xs,
  },
  headerCenter: {
    flex: 1,
    marginHorizontal: Spacing.md,
  },
  headerTitle: {
    fontSize: 18,
    fontWeight: '600',
  },
  saveButton: {
    padding: Spacing.xs,
  },
  saveText: {
    fontSize: 16,
    fontWeight: '600',
  },
  inputRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    marginHorizontal: Spacing.md,
    marginBottom: Spacing.xs,
    borderRadius: 8,
  },
  inputLabel: {
    fontSize: 14,
    fontWeight: '500',
    width: 80,
  },
  textInput: {
    flex: 1,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: 6,
  },
  placeholder: {
    opacity: 0.5,
  },
  typeButtons: {
    flex: 1,
    flexDirection: 'row',
    gap: Spacing.xs,
  },
  typeButton: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: 6,
  },
  typeButtonText: {
    fontSize: 13,
    fontWeight: '500',
  },
  toolbarRow: {
    flexDirection: 'row',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  variablesButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xs,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: 8,
  },
  variablesButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '500',
  },
  editorContainer: {
    flex: 1,
  },
  webView: {
    flex: 1,
    backgroundColor: 'transparent',
  },
  variablesPanel: {
    flex: 1,
    padding: Spacing.md,
  },
  variableCategory: {
    marginBottom: Spacing.lg,
  },
  categoryTitle: {
    fontSize: 14,
    fontWeight: '600',
    marginBottom: Spacing.sm,
    opacity: 0.7,
  },
  variablesList: {
    gap: Spacing.xs,
  },
  variableItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: Spacing.sm,
    borderRadius: 8,
    gap: Spacing.sm,
  },
  variableKey: {
    fontSize: 12,
    fontFamily: Platform.select({ ios: 'Menlo', android: 'monospace', default: 'monospace' }),
    fontWeight: '500',
  },
  variableLabel: {
    fontSize: 13,
    flex: 1,
  },
  webFallback: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: Spacing.xl,
  },
  webFallbackText: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: Spacing.md,
  },
  webFallbackHint: {
    fontSize: 14,
    opacity: 0.7,
    textAlign: 'center',
  },
});
