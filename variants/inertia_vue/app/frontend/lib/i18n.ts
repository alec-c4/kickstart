import { createI18n } from 'vue-i18n';
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

// Create i18n instance
export const i18n = createI18n({
  legacy: false,
  locale: getCookie('locale') || DEFAULT_LOCALE,
  fallbackLocale: DEFAULT_LOCALE,
  messages: {
    en: enTranslations,
    ru: ruTranslations
  }
});

export function setLocale(locale: Locale): void {
  if (AVAILABLE_LOCALES.includes(locale)) {
    i18n.global.locale.value = locale;
    setCookie('locale', locale);
  }
}

export function getLocale(): Locale {
  return i18n.global.locale.value as Locale;
}

export function syncLocaleFromProps(propsLocale?: string): void {
  if (propsLocale && AVAILABLE_LOCALES.includes(propsLocale as Locale)) {
    const currentLocale = getLocale();
    if (currentLocale !== propsLocale) {
      setLocale(propsLocale as Locale);
    }
  }
}
