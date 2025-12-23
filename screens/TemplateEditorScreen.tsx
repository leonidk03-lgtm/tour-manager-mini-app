import { useState, useRef, useEffect } from 'react';
import { View, StyleSheet, Alert, Pressable, ScrollView, ActivityIndicator, Platform } from 'react-native';
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
      background: #ffffff;
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
      padding: 6px;
      display: flex;
      flex-wrap: wrap;
      gap: 4px;
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
    .ql-toolbar.ql-snow button.ql-active {
      background: ${isDark ? '#555' : '#ddd'};
      border-radius: 4px;
    }
    #editor-container {
      position: absolute;
      top: 44px;
      bottom: 0;
      left: 0;
      right: 0;
      overflow-y: auto;
      -webkit-overflow-scrolling: touch;
      background: #ffffff;
    }
    .ql-container.ql-snow {
      border: none;
      font-family: 'Times New Roman', Times, serif;
      font-size: 12pt;
    }
    .ql-editor {
      min-height: 100%;
      padding: 16px;
      background: #ffffff;
      color: #000000;
    }
    .ql-editor table {
      border-collapse: collapse;
      width: 100%;
      margin: 10px 0;
    }
    .ql-editor table td, .ql-editor table th {
      border: 1px solid #000;
      padding: 5px 8px;
      min-width: 40px;
    }
    .ql-editor table th {
      background: #f0f0f0;
      font-weight: bold;
    }
    .ql-editor img {
      max-width: 200px;
      height: auto;
      cursor: pointer;
    }
    .ql-editor img.selected {
      outline: 2px solid #0088ff;
    }
    .image-resize-dialog {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background: ${isDark ? '#333' : '#fff'};
      border: 1px solid ${isDark ? '#555' : '#ccc'};
      border-radius: 8px;
      padding: 16px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.3);
      z-index: 300;
      min-width: 200px;
    }
    .image-resize-dialog.show {
      display: block;
    }
    .image-resize-dialog h4 {
      margin: 0 0 12px 0;
      font-size: 14px;
      color: ${isDark ? '#fff' : '#333'};
    }
    .image-resize-dialog label {
      display: block;
      margin-bottom: 4px;
      font-size: 12px;
      color: ${isDark ? '#aaa' : '#666'};
    }
    .image-resize-dialog input {
      width: 100%;
      padding: 8px;
      margin-bottom: 12px;
      border: 1px solid ${isDark ? '#555' : '#ccc'};
      border-radius: 4px;
      background: ${isDark ? '#222' : '#fff'};
      color: ${isDark ? '#fff' : '#000'};
      font-size: 14px;
    }
    .image-resize-dialog .btn-row {
      display: flex;
      gap: 8px;
      justify-content: flex-end;
    }
    .image-resize-dialog button {
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      font-size: 12px;
      cursor: pointer;
    }
    .image-resize-dialog .btn-cancel {
      background: ${isDark ? '#555' : '#ddd'};
      color: ${isDark ? '#fff' : '#333'};
    }
    .image-resize-dialog .btn-apply {
      background: #0088ff;
      color: #fff;
    }
    .dialog-overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0,0,0,0.5);
      z-index: 250;
    }
    .dialog-overlay.show {
      display: block;
    }
    .ql-editor .template-var {
      background: #e1f0ff;
      color: #0066cc;
      padding: 2px 6px;
      border-radius: 4px;
      font-family: monospace;
      font-size: 11px;
    }
    .custom-btn {
      background: ${isDark ? '#444' : '#e8e8e8'};
      border: none;
      border-radius: 4px;
      padding: 4px 8px;
      font-size: 11px;
      color: ${isDark ? '#fff' : '#333'};
      cursor: pointer;
      white-space: nowrap;
    }
    .custom-btn:active {
      opacity: 0.7;
    }
    .custom-btn.active {
      background: ${isDark ? '#0088ff' : '#0066cc'};
      color: #fff;
    }
    #source-editor {
      display: none;
      position: absolute;
      top: 44px;
      bottom: 0;
      left: 0;
      right: 0;
      padding: 12px;
      font-family: 'Courier New', monospace;
      font-size: 12px;
      line-height: 1.5;
      background: #ffffff;
      color: #000000;
      border: none;
      resize: none;
      outline: none;
    }
    .table-dropdown {
      display: none;
      position: fixed;
      top: 50px;
      left: 50%;
      transform: translateX(-50%);
      background: ${isDark ? '#333' : '#fff'};
      border: 1px solid ${isDark ? '#555' : '#ccc'};
      border-radius: 6px;
      padding: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.2);
      z-index: 200;
    }
    .table-dropdown.show {
      display: block;
    }
    .table-grid {
      display: grid;
      grid-template-columns: repeat(5, 24px);
      gap: 2px;
    }
    .table-cell {
      width: 24px;
      height: 24px;
      border: 1px solid ${isDark ? '#555' : '#ccc'};
      background: ${isDark ? '#222' : '#f9f9f9'};
      cursor: pointer;
    }
    .table-cell:hover, .table-cell.selected {
      background: ${isDark ? '#0088ff' : '#0066cc'};
      border-color: ${isDark ? '#0088ff' : '#0066cc'};
    }
    .table-size-label {
      text-align: center;
      margin-top: 6px;
      font-size: 11px;
      color: ${isDark ? '#aaa' : '#666'};
    }
  </style>
</head>
<body>
  <div id="toolbar-container">
    <div id="toolbar">
      <span class="ql-formats">
        <button class="ql-bold" title="Жирный"></button>
        <button class="ql-italic" title="Курсив"></button>
        <button class="ql-underline" title="Подчёркнутый"></button>
      </span>
      <span class="ql-formats">
        <select class="ql-header" title="Заголовок">
          <option value="1">H1</option>
          <option value="2">H2</option>
          <option value="3">H3</option>
          <option selected></option>
        </select>
      </span>
      <span class="ql-formats">
        <select class="ql-align" title="Выравнивание"></select>
      </span>
      <span class="ql-formats">
        <button class="ql-list" value="ordered" title="Нумерованный список"></button>
        <button class="ql-list" value="bullet" title="Маркированный список"></button>
      </span>
      <span class="ql-formats" style="position: relative;">
        <button class="custom-btn" id="table-btn" title="Таблица">Таблица</button>
        <div class="table-dropdown" id="table-dropdown">
          <div class="table-grid" id="table-grid"></div>
          <div class="table-size-label" id="table-size-label">Выберите размер</div>
        </div>
      </span>
      <span class="ql-formats" style="margin-left: 4px;">
        <button class="custom-btn" id="signature-btn" title="Подпись" style="margin-right: 4px;">Подпись</button>
      </span>
      <span class="ql-formats">
        <button class="custom-btn" id="stamp-btn" title="Печать" style="margin-right: 4px;">Печать</button>
      </span>
      <span class="ql-formats">
        <button class="custom-btn" id="source-btn" title="HTML-код" style="margin-right: 4px;">HTML</button>
      </span>
      <span class="ql-formats">
        <button class="ql-clean" title="Очистить формат"></button>
      </span>
    </div>
  </div>
  <div id="editor-container">
    <div id="editor"></div>
  </div>
  <textarea id="source-editor" spellcheck="false"></textarea>
  <div class="dialog-overlay" id="dialog-overlay"></div>
  <div class="image-resize-dialog" id="image-resize-dialog">
    <h4>Размер изображения</h4>
    <label>Ширина (px)</label>
    <input type="number" id="img-width" min="20" max="500" />
    <div class="btn-row">
      <button class="btn-cancel" id="resize-cancel">Отмена</button>
      <button class="btn-apply" id="resize-apply">Применить</button>
    </div>
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

    document.addEventListener('touchstart', function(e) {
      var target = e.target;
      var isInput = target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' || target.isContentEditable || target.closest('.ql-editor');
      if (!isInput) {
        document.activeElement.blur();
      }
    });

    var selectedImage = null;
    var resizeDialog = document.getElementById('image-resize-dialog');
    var dialogOverlay = document.getElementById('dialog-overlay');
    var imgWidthInput = document.getElementById('img-width');

    quill.root.addEventListener('click', function(e) {
      if (e.target.tagName === 'IMG') {
        e.preventDefault();
        e.stopPropagation();
        if (selectedImage) selectedImage.classList.remove('selected');
        selectedImage = e.target;
        selectedImage.classList.add('selected');
        imgWidthInput.value = selectedImage.width || 100;
        resizeDialog.classList.add('show');
        dialogOverlay.classList.add('show');
      }
    });

    dialogOverlay.addEventListener('click', function() {
      closeResizeDialog();
    });

    document.getElementById('resize-cancel').addEventListener('click', function() {
      closeResizeDialog();
    });

    document.getElementById('resize-apply').addEventListener('click', function() {
      if (selectedImage) {
        var newWidth = parseInt(imgWidthInput.value) || 100;
        selectedImage.style.width = newWidth + 'px';
        selectedImage.style.maxWidth = newWidth + 'px';
        selectedImage.style.height = 'auto';
        notifyContentChange();
      }
      closeResizeDialog();
    });

    function closeResizeDialog() {
      resizeDialog.classList.remove('show');
      dialogOverlay.classList.remove('show');
      if (selectedImage) {
        selectedImage.classList.remove('selected');
        selectedImage = null;
      }
    }

    var sourceMode = false;
    var sourceEditor = document.getElementById('source-editor');
    var editorContainer = document.getElementById('editor-container');
    var sourceBtn = document.getElementById('source-btn');

    sourceBtn.addEventListener('click', function() {
      sourceMode = !sourceMode;
      if (sourceMode) {
        sourceEditor.value = formatHtml(quill.root.innerHTML);
        sourceEditor.style.display = 'block';
        editorContainer.style.display = 'none';
        sourceBtn.classList.add('active');
      } else {
        quill.root.innerHTML = sourceEditor.value;
        sourceEditor.style.display = 'none';
        editorContainer.style.display = 'block';
        sourceBtn.classList.remove('active');
        notifyContentChange();
      }
    });

    sourceEditor.addEventListener('input', function() {
      window.ReactNativeWebView.postMessage(JSON.stringify({
        type: 'content-change',
        html: sourceEditor.value
      }));
    });

    function formatHtml(html) {
      var formatted = '';
      var indent = 0;
      var tags = html.split(/(<[^>]+>)/g).filter(Boolean);
      tags.forEach(function(tag) {
        if (tag.match(/^<\\/[^>]+>$/)) {
          indent--;
        }
        if (tag.match(/^</)) {
          formatted += '  '.repeat(Math.max(0, indent)) + tag + '\\n';
        } else if (tag.trim()) {
          formatted += '  '.repeat(Math.max(0, indent)) + tag.trim() + '\\n';
        }
        if (tag.match(/^<[^/][^>]*[^/]>$/) && !tag.match(/^<(br|hr|img|input|meta|link)/i)) {
          indent++;
        }
      });
      return formatted.trim();
    }

    var tableBtn = document.getElementById('table-btn');
    var tableDropdown = document.getElementById('table-dropdown');
    var tableGrid = document.getElementById('table-grid');
    var tableSizeLabel = document.getElementById('table-size-label');
    var selectedRows = 0, selectedCols = 0;

    for (var r = 0; r < 5; r++) {
      for (var c = 0; c < 5; c++) {
        var cell = document.createElement('div');
        cell.className = 'table-cell';
        cell.dataset.row = r + 1;
        cell.dataset.col = c + 1;
        tableGrid.appendChild(cell);
      }
    }

    tableBtn.addEventListener('click', function(e) {
      e.stopPropagation();
      tableDropdown.classList.toggle('show');
    });

    tableGrid.addEventListener('mouseover', function(e) {
      if (e.target.classList.contains('table-cell')) {
        selectedRows = parseInt(e.target.dataset.row);
        selectedCols = parseInt(e.target.dataset.col);
        tableSizeLabel.textContent = selectedRows + ' x ' + selectedCols;
        updateGridSelection();
      }
    });

    tableGrid.addEventListener('click', function(e) {
      if (e.target.classList.contains('table-cell')) {
        insertTable(selectedRows, selectedCols);
        tableDropdown.classList.remove('show');
      }
    });

    document.addEventListener('click', function(e) {
      if (!tableDropdown.contains(e.target) && e.target !== tableBtn) {
        tableDropdown.classList.remove('show');
      }
    });

    function updateGridSelection() {
      var cells = tableGrid.querySelectorAll('.table-cell');
      cells.forEach(function(cell) {
        var r = parseInt(cell.dataset.row);
        var c = parseInt(cell.dataset.col);
        if (r <= selectedRows && c <= selectedCols) {
          cell.classList.add('selected');
        } else {
          cell.classList.remove('selected');
        }
      });
    }

    function insertTable(rows, cols) {
      var table = '<table><tbody>';
      for (var r = 0; r < rows; r++) {
        table += '<tr>';
        for (var c = 0; c < cols; c++) {
          if (r === 0) {
            table += '<th>Заголовок</th>';
          } else {
            table += '<td>Ячейка</td>';
          }
        }
        table += '</tr>';
      }
      table += '</tbody></table><p><br></p>';
      
      var range = quill.getSelection(true);
      quill.clipboard.dangerouslyPasteHTML(range.index, table);
      notifyContentChange();
    }

    function notifyContentChange() {
      var html = sourceMode ? sourceEditor.value : quill.root.innerHTML;
      window.ReactNativeWebView.postMessage(JSON.stringify({
        type: 'content-change',
        html: html
      }));
    }

    quill.on('text-change', function() {
      if (!sourceMode) {
        notifyContentChange();
      }
    });

    document.getElementById('signature-btn').addEventListener('click', function() {
      window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'pick-image', imageType: 'signature' }));
    });

    document.getElementById('stamp-btn').addEventListener('click', function() {
      window.ReactNativeWebView.postMessage(JSON.stringify({ type: 'pick-image', imageType: 'stamp' }));
    });

    window.insertImage = function(base64Data, alt) {
      var imgHtml = '<img src="' + base64Data + '" alt="' + alt + '" style="max-width: 150px; height: auto;" />';
      if (sourceMode) {
        var pos = sourceEditor.selectionStart;
        var text = sourceEditor.value;
        sourceEditor.value = text.slice(0, pos) + imgHtml + text.slice(pos);
        sourceEditor.selectionStart = sourceEditor.selectionEnd = pos + imgHtml.length;
        notifyContentChange();
      } else {
        var range = quill.getSelection(true);
        quill.clipboard.dangerouslyPasteHTML(range.index, imgHtml);
        notifyContentChange();
      }
    };

    window.insertVariable = function(varKey) {
      if (sourceMode) {
        var pos = sourceEditor.selectionStart;
        var text = sourceEditor.value;
        sourceEditor.value = text.slice(0, pos) + varKey + text.slice(pos);
        sourceEditor.selectionStart = sourceEditor.selectionEnd = pos + varKey.length;
        notifyContentChange();
      } else {
        var range = quill.getSelection(true);
        quill.insertText(range.index, varKey, { 'background': '#e1f0ff', 'color': '#0066cc' });
        quill.setSelection(range.index + varKey.length);
      }
    };

    window.getContent = function() {
      return sourceMode ? sourceEditor.value : quill.root.innerHTML;
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
        
        if (webViewRef.current && isReady) {
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
