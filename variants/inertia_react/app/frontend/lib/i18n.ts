import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

import enTranslations from '@/locales/en.json';
import ruTranslations from '@/locales/ru.json';

export const AVAILABLE_LOCALES = ['en', 'ru'] as const;
export type Locale = typeof AVAILABLE_LOCALES[number];

const DEFAULT_LOCALE: Locale = 'en';

// Cookie helpers
function getCookie(name: string): string | undefined {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop()?.split(';').shift();
}

function setCookie(name: string, value: string, days = 365): void {
  const expires = new Date(Date.now() + days * 864e5).toUTCString();
  document.cookie = `${name}=${value}; expires=${expires}; path=/; SameSite=Lax`;
}

// Initialize i18next
i18n
  .use(initReactI18next)
  .init({
    resources: {
      en: { translation: enTranslations },
      ru: { translation: ruTranslations }
    },
    lng: getCookie('locale') || DEFAULT_LOCALE,
    fallbackLng: DEFAULT_LOCALE,
    interpolation: {
      escapeValue: false
    }
  });

// Sync locale to cookie
i18n.on('languageChanged', (lng) => {
  setCookie('locale', lng);
});

export function setLocale(locale: Locale): void {
  if (AVAILABLE_LOCALES.includes(locale)) {
    i18n.changeLanguage(locale);
  }
}

export function getLocale(): Locale {
  return (i18n.language as Locale) || DEFAULT_LOCALE;
}

export function syncLocaleFromProps(propsLocale?: string): void {
  if (propsLocale && AVAILABLE_LOCALES.includes(propsLocale as Locale)) {
    const currentLocale = getLocale();
    if (currentLocale !== propsLocale) {
      setLocale(propsLocale as Locale);
    }
  }
}

export default i18n;
