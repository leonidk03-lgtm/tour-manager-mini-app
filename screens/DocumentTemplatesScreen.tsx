import { useState, useCallback } from 'react';
import { View, StyleSheet, Pressable, Alert, RefreshControl, ActivityIndicator } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { Feather } from '@expo/vector-icons';
import { ScreenFlatList } from '@/components/ScreenFlatList';
import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import { BorderRadius } from '@/constants/theme';
import { useDocumentTemplates, DocumentTemplate, TEMPLATE_TYPE_LABELS } from '@/contexts/DocumentTemplatesContext';
import { Colors, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/useTheme';
import { useAuth } from '@/contexts/AuthContext';

type RootStackParamList = {
  DocumentTemplates: undefined;
  TemplateEditor: { templateId?: string; type?: DocumentTemplate['type'] };
};

export default function DocumentTemplatesScreen() {
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const { isDark } = useTheme();
  const { isAdmin } = useAuth();
  const { 
    templates, 
    isLoading, 
    refreshTemplates, 
    deleteTemplate, 
    setAsDefault 
  } = useDocumentTemplates();

  const [refreshing, setRefreshing] = useState(false);
  const [selectedType, setSelectedType] = useState<DocumentTemplate['type'] | 'all'>('all');

  const onRefresh = useCallback(async () => {
    setRefreshing(true);
    await refreshTemplates();
    setRefreshing(false);
  }, [refreshTemplates]);

  const filteredTemplates = selectedType === 'all' 
    ? templates 
    : templates.filter(t => t.type === selectedType);

  const groupedTemplates = (['invoice', 'act', 'contract', 'waybill'] as const).map(type => ({
    type,
    templates: filteredTemplates.filter(t => t.type === type),
  })).filter(g => g.templates.length > 0 || selectedType === 'all');

  const handleDelete = (template: DocumentTemplate) => {
    Alert.alert(
      'Удалить шаблон?',
      `Шаблон "${template.name}" будет удалён`,
      [
        { text: 'Отмена', style: 'cancel' },
        {
          text: 'Удалить',
          style: 'destructive',
          onPress: async () => {
            const { error } = await deleteTemplate(template.id);
            if (error) {
              Alert.alert('Ошибка', error);
            }
          },
        },
      ]
    );
  };

  const handleSetDefault = async (template: DocumentTemplate) => {
    const { error } = await setAsDefault(template.id, template.type);
    if (error) {
      Alert.alert('Ошибка', error);
    }
  };

  const colors = isDark ? Colors.dark : Colors.light;

  const renderTemplate = (template: DocumentTemplate) => (
    <Pressable
      key={template.id}
      style={[styles.templateCard, { backgroundColor: colors.backgroundSecondary }]}
      onPress={() => navigation.navigate('TemplateEditor', { templateId: template.id })}
    >
      <View style={styles.templateHeader}>
        <View style={styles.templateInfo}>
          <ThemedText style={styles.templateName}>{template.name}</ThemedText>
          {template.isDefault ? (
            <View style={[styles.defaultBadge, { backgroundColor: colors.success + '20' }]}>
              <ThemedText style={[styles.defaultBadgeText, { color: colors.success }]}>
                По умолчанию
              </ThemedText>
            </View>
          ) : null}
        </View>
        <Feather name="chevron-right" size={20} color={colors.textSecondary} />
      </View>

      {isAdmin ? (
        <View style={styles.templateActions}>
          {!template.isDefault ? (
            <Pressable
              style={[styles.actionButton, { backgroundColor: colors.primary + '20' }]}
              onPress={() => handleSetDefault(template)}
            >
              <Feather name="check-circle" size={14} color={colors.primary} />
              <ThemedText style={[styles.actionButtonText, { color: colors.primary }]}>
                Сделать основным
              </ThemedText>
            </Pressable>
          ) : null}
          <Pressable
            style={[styles.actionButton, { backgroundColor: colors.error + '20' }]}
            onPress={() => handleDelete(template)}
          >
            <Feather name="trash-2" size={14} color={colors.error} />
            <ThemedText style={[styles.actionButtonText, { color: colors.error }]}>
              Удалить
            </ThemedText>
          </Pressable>
        </View>
      ) : null}
    </Pressable>
  );

  const renderGroup = ({ item }: { item: { type: DocumentTemplate['type']; templates: DocumentTemplate[] } }) => (
    <View style={styles.group}>
      <View style={styles.groupHeader}>
        <ThemedText style={styles.groupTitle}>{TEMPLATE_TYPE_LABELS[item.type]}</ThemedText>
        {isAdmin && selectedType === 'all' ? (
          <Pressable
            style={[styles.addButton, { backgroundColor: colors.primary }]}
            onPress={() => navigation.navigate('TemplateEditor', { type: item.type })}
          >
            <Feather name="plus" size={16} color="#fff" />
          </Pressable>
        ) : null}
      </View>
      {item.templates.length > 0 ? (
        item.templates.map(renderTemplate)
      ) : (
        <View style={[styles.emptyCard, { backgroundColor: colors.backgroundSecondary }]}>
          <ThemedText style={styles.emptyText}>Нет шаблонов</ThemedText>
        </View>
      )}
    </View>
  );

  if (isLoading && templates.length === 0) {
    return (
      <ThemedView style={styles.loadingContainer}>
        <ActivityIndicator size="large" color={colors.primary} />
      </ThemedView>
    );
  }

  return (
    <ThemedView style={styles.container}>
      <View style={styles.filterRow}>
        <Pressable
          style={[
            styles.filterButton,
            { backgroundColor: selectedType === 'all' ? colors.primary : colors.backgroundSecondary },
          ]}
          onPress={() => setSelectedType('all')}
        >
          <ThemedText
            style={[
              styles.filterButtonText,
              { color: selectedType === 'all' ? '#fff' : colors.text },
            ]}
          >
            Все
          </ThemedText>
        </Pressable>
        {(['invoice', 'act', 'contract', 'waybill'] as const).map((type) => (
          <Pressable
            key={type}
            style={[
              styles.filterButton,
              { backgroundColor: selectedType === type ? colors.primary : colors.backgroundSecondary },
            ]}
            onPress={() => setSelectedType(type)}
          >
            <ThemedText
              style={[
                styles.filterButtonText,
                { color: selectedType === type ? '#fff' : colors.text },
              ]}
            >
              {TEMPLATE_TYPE_LABELS[type]}
            </ThemedText>
          </Pressable>
        ))}
      </View>

      <ScreenFlatList
        data={selectedType === 'all' ? groupedTemplates : groupedTemplates.filter(g => g.type === selectedType)}
        renderItem={renderGroup}
        keyExtractor={(item) => item.type}
        contentContainerStyle={styles.listContent}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onRefresh} tintColor={colors.primary} />
        }
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Feather name="file-text" size={48} color={colors.textSecondary} />
            <ThemedText style={styles.emptyTitle}>Нет шаблонов</ThemedText>
            <ThemedText style={styles.emptySubtitle}>
              Создайте шаблоны документов для генерации счетов, актов и договоров
            </ThemedText>
          </View>
        }
      />

      {isAdmin && selectedType !== 'all' ? (
        <Pressable
          style={[styles.fab, { backgroundColor: colors.primary }]}
          onPress={() => navigation.navigate('TemplateEditor', { type: selectedType as DocumentTemplate['type'] })}
        >
          <Feather name="plus" size={24} color="#fff" />
        </Pressable>
      ) : null}
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  filterRow: {
    flexDirection: 'row',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    gap: Spacing.xs,
    flexWrap: 'wrap',
  },
  filterButton: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: 20,
  },
  filterButtonText: {
    fontSize: 13,
    fontWeight: '500',
  },
  listContent: {
    padding: Spacing.md,
  },
  group: {
    marginBottom: Spacing.lg,
  },
  groupHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.sm,
  },
  groupTitle: {
    fontSize: 16,
    fontWeight: '600',
  },
  addButton: {
    width: 28,
    height: 28,
    borderRadius: 14,
    justifyContent: 'center',
    alignItems: 'center',
  },
  templateCard: {
    marginBottom: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
  },
  templateHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  templateInfo: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
  },
  templateName: {
    fontSize: 15,
    fontWeight: '500',
  },
  defaultBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: 10,
  },
  defaultBadgeText: {
    fontSize: 11,
    fontWeight: '500',
  },
  templateActions: {
    flexDirection: 'row',
    gap: Spacing.sm,
    marginTop: Spacing.sm,
  },
  actionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: 6,
  },
  actionButtonText: {
    fontSize: 12,
    fontWeight: '500',
  },
  emptyCard: {
    padding: Spacing.md,
    alignItems: 'center',
    borderRadius: BorderRadius.lg,
  },
  emptyText: {
    fontSize: 14,
    opacity: 0.6,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: Spacing.xl * 2,
  },
  emptyTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginTop: Spacing.md,
  },
  emptySubtitle: {
    fontSize: 14,
    opacity: 0.6,
    textAlign: 'center',
    marginTop: Spacing.xs,
    paddingHorizontal: Spacing.xl,
  },
  fab: {
    position: 'absolute',
    bottom: 100,
    right: Spacing.lg,
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
});
