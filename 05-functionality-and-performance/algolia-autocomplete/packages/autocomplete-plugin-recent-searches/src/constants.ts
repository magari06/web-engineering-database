import { AutocompleteRecentSearchesPluginTranslations } from './types';

export const LOCAL_STORAGE_KEY = 'AUTOCOMPLETE_RECENT_SEARCHES';
export const LOCAL_STORAGE_KEY_TEST =
  '__AUTOCOMPLETE_RECENT_SEARCHES_PLUGIN_TEST_KEY__';

export const defaultTranslations: AutocompleteRecentSearchesPluginTranslations =
  {
    removeSearchTitle: 'Remove this search',
    fillQueryTitle: (text: string) => `Fill query with "${text}"`,
  };
