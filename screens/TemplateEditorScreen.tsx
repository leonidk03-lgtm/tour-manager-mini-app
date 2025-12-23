import { useState, useRef, useEffect, useMemo } from 'react';
import { View, StyleSheet, Alert, Pressable, ScrollView, ActivityIndicator, Platform, TextInput } from 'react-native';
import { WebView } from 'react-native-webview';
import { useNavigation, useRoute, RouteProp } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Feather } from '@expo/vector-icons';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import * as ImagePicker from 'expo-image-picker';
import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import { useDocumentTemplates, DocumentTemplate, TEMPLATE_TYPE_LABELS, TEMPLATE_VARIABLES } from '@/contexts/DocumentTemplatesContext';
import { Colors, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/useTheme';

type RootStackParamList = {
  TemplateEditor: { templateId?: string; type?: DocumentTemplate['type'] };
};

type TemplateEditorRouteProp = RouteProp<RootStackParamList, 'TemplateEditor'>;

const getEditorHtml = (initialContent: string, isDark: boolean) => `
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <script src="https://cdn.jsdelivr.net/npm/tinymce@6.8.2/tinymce.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tinymce@6.8.2/skins/ui/oxide-dark/skin.min.css">
  <style>
    * { box-sizing: border-box; }
    html, body {
      margin: 0;
      padding: 0;
      height: 100%;
      background: #ffffff;
      overflow: hidden;
    }
    #editor-wrapper {
      height: 100%;
      display: flex;
      flex-direction: column;
    }
    .tox-tinymce {
      border: none !important;
      flex: 1;
    }
    .tox .tox-edit-area__iframe {
      background: #ffffff !important;
    }
    .tox .tox-toolbar__primary {
      background: #333 !important;
      border-bottom: 1px solid #444 !important;
    }
    .tox .tox-tbtn {
      color: #fff !important;
    }
    .tox .tox-tbtn svg {
      fill: #fff !important;
    }
    .tox .tox-tbtn:hover {
      background: #555 !important;
    }
    .tox .tox-tbtn--enabled {
      background: #555 !important;
    }
    .tox .tox-toolbar__group {
      border-color: #555 !important;
    }
    .tox .tox-editor-header {
      background: #333 !important;
    }
    .tox .tox-menubar {
      background: #333 !important;
    }
    .template-var {
      background: #e1f0ff;
      color: #0066cc;
      padding: 2px 6px;
      border-radius: 4px;
      font-family: monospace;
      font-size: 11px;
    }
  </style>
</head>
<body>
  <div id="editor-wrapper">
    <textarea id="editor"></textarea>
  </div>
  <script>
    var editor;
    var initialContent = ${JSON.stringify(initialContent)};
    
    function sendMessage(data) {
      if (window.ReactNativeWebView) {
        window.ReactNativeWebView.postMessage(JSON.stringify(data));
      } else if (window.parent && window.parent !== window) {
        window.parent.postMessage(JSON.stringify(data), '*');
      }
    }
    
    tinymce.init({
      selector: '#editor',
      height: '100%',
      menubar: false,
      statusbar: false,
      branding: false,
      promotion: false,
      base_url: 'https://cdn.jsdelivr.net/npm/tinymce@6.8.2',
      suffix: '.min',
      skin_url: 'https://cdn.jsdelivr.net/npm/tinymce@6.8.2/skins/ui/oxide-dark',
      content_css: false,
      plugins: 'table lists code image',
      toolbar: 'bold italic underline | blocks | alignleft aligncenter alignright | bullist numlist | table | signatureBtn stampBtn | code',
      content_style: \`
        body { 
          font-family: 'Times New Roman', Times, serif; 
          font-size: 12pt; 
          background: #ffffff; 
          color: #000000;
          padding: 16px;
        }
        table { 
          border-collapse: collapse; 
          width: 100%; 
          margin: 10px 0; 
        }
        table td, table th { 
          border: 1px solid #000; 
          padding: 5px 8px; 
          min-width: 40px; 
        }
        table th { 
          background: #f0f0f0; 
          font-weight: bold; 
        }
        img { 
          max-width: 300px; 
          height: auto; 
        }
        .template-var {
          background: #e1f0ff;
          color: #0066cc;
          padding: 2px 6px;
          border-radius: 4px;
          font-family: monospace;
          font-size: 11px;
        }
      \`,
      paste_data_images: true,
      paste_retain_style_properties: 'all',
      paste_word_valid_elements: 'table,tr,td,th,tbody,thead,tfoot,colgroup,col,p,br,b,strong,i,em,u,span,div,h1,h2,h3,h4,h5,h6,ul,ol,li,img,a',
      table_default_styles: {
        'border-collapse': 'collapse',
        'width': '100%'
      },
      table_cell_class_list: [],
      table_row_class_list: [],
      table_class_list: [],
      setup: function(ed) {
        editor = ed;
        
        ed.ui.registry.addButton('signatureBtn', {
          text: 'Подпись',
          onAction: function() {
            sendMessage({ type: 'pick-image', imageType: 'signature' });
          }
        });
        
        ed.ui.registry.addButton('stampBtn', {
          text: 'Печать',
          onAction: function() {
            sendMessage({ type: 'pick-image', imageType: 'stamp' });
          }
        });
        
        ed.on('init', function() {
          if (initialContent) {
            ed.setContent(initialContent);
          }
          sendMessage({ type: 'ready' });
        });
        
        ed.on('change keyup paste', function() {
          sendMessage({
            type: 'content-change',
            html: ed.getContent()
          });
        });
      }
    });
    
    window.insertImage = function(base64Data, alt) {
      if (editor) {
        editor.insertContent('<img src="' + base64Data + '" alt="' + alt + '" style="max-width: 150px; height: auto;" />');
      }
    };
    
    window.insertVariable = function(varKey) {
      if (editor) {
        editor.insertContent('<span class="template-var">{{' + varKey + '}}</span>&nbsp;');
      }
    };
    
    window.getContent = function() {
      return editor ? editor.getContent() : '';
    };
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
  const htmlContentRef = useRef(htmlContent);
  
  const initialHtml = useMemo(() => {
    return getEditorHtml(existingTemplate?.htmlContent || '', isDark);
  }, [existingTemplate?.htmlContent, isDark]);

  useEffect(() => {
    navigation.setOptions({
      headerTitle: existingTemplate ? 'Редактирование шаблона' : 'Новый шаблон',
    });
  }, [navigation, existingTemplate]);

  const pickImage = async (imageType: 'signature' | 'stamp') => {
    try {
      const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
      if (status !== 'granted') {
        Alert.alert('Ошибка', 'Необходим доступ к галерее для загрузки изображений');
        return;
      }

      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: 'images',
        allowsEditing: true,
        aspect: imageType === 'stamp' ? [1, 1] : [3, 1],
        quality: 0.8,
        base64: true,
      });

      if (!result.canceled && result.assets[0].base64) {
        const base64Data = `data:image/png;base64,${result.assets[0].base64}`;
        const altText = imageType === 'signature' ? 'Подпись' : 'Печать';
        
        if (Platform.OS === 'web') {
          const iframe = document.querySelector('iframe');
          if (iframe && iframe.contentWindow) {
            (iframe.contentWindow as any).insertImage(base64Data, altText);
          }
        } else if (webViewRef.current && isReady) {
          const escapedBase64 = base64Data.replace(/'/g, "\\'");
          webViewRef.current.injectJavaScript(`window.insertImage('${escapedBase64}', '${altText}'); true;`);
        }
      }
    } catch (error) {
      console.error('Image picker error:', error);
      Alert.alert('Ошибка', 'Не удалось загрузить изображение');
    }
  };

  const handleMessage = (event: { nativeEvent: { data: string } }) => {
    try {
      const data = JSON.parse(event.nativeEvent.data);
      if (data.type === 'content-change') {
        htmlContentRef.current = data.html;
        setHtmlContent(data.html);
      } else if (data.type === 'ready') {
        setIsReady(true);
      } else if (data.type === 'pick-image') {
        pickImage(data.imageType);
      }
    } catch (e) {
      console.error('WebView message error:', e);
    }
  };

  const insertVariable = (varKey: string) => {
    if (Platform.OS === 'web') {
      const iframe = document.querySelector('iframe');
      if (iframe && iframe.contentWindow) {
        (iframe.contentWindow as any).insertVariable(varKey);
      }
    } else if (webViewRef.current && isReady) {
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
            <TextInput
              value={name}
              onChangeText={setName}
              placeholder="Введите название..."
              placeholderTextColor={colors.textSecondary}
              style={[styles.nameInput, { color: colors.text }]}
            />
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
            <iframe
              ref={(ref) => {
                if (ref && !ref.dataset.initialized) {
                  ref.dataset.initialized = 'true';
                  ref.srcdoc = initialHtml;
                  
                  const messageHandler = (e: MessageEvent) => {
                    try {
                      const data = typeof e.data === 'string' ? JSON.parse(e.data) : e.data;
                      if (data.type === 'content-change') {
                        htmlContentRef.current = data.html;
                        setHtmlContent(data.html);
                      } else if (data.type === 'ready') {
                        setIsReady(true);
                      } else if (data.type === 'pick-image') {
                        pickImage(data.imageType);
                      }
                    } catch (err) {}
                  };
                  
                  window.addEventListener('message', messageHandler);
                  
                  ref.onload = () => {
                    const win = ref.contentWindow as any;
                    if (win) {
                      win.ReactNativeWebView = {
                        postMessage: (msg: string) => {
                          window.postMessage(msg, '*');
                        }
                      };
                    }
                  };
                }
              }}
              style={{ flex: 1, border: 'none', width: '100%', height: '100%' } as any}
              tabIndex={0}
            />
          ) : (
            <WebView
              ref={webViewRef}
              originWhitelist={['*']}
              source={{ html: initialHtml }}
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
    zIndex: 10,
    position: 'relative',
  },
  headerRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  backButton: {
    padding: Spacing.xs,
    cursor: 'pointer',
  } as any,
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
    cursor: 'pointer',
  } as any,
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
  nameInput: {
    fontSize: 14,
    padding: 0,
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
    fontSize: 12,
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
  variablesPanel: {
    flex: 1,
    padding: Spacing.md,
  },
  variableCategory: {
    marginBottom: Spacing.lg,
  },
  categoryTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: Spacing.sm,
  },
  variablesList: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.xs,
  },
  variableItem: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: 6,
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xs,
  },
  variableKey: {
    fontSize: 12,
    fontWeight: '600',
    fontFamily: 'monospace',
  },
  variableLabel: {
    fontSize: 12,
    opacity: 0.7,
  },
  editorContainer: {
    flex: 1,
  },
  webView: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
});
