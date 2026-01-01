import i18next from "i18next";
import en from "@/locales/en.json";
import ru from "@/locales/ru.json";

// Available locales
const AVAILABLE_LOCALES = ["en", "ru"] as const;
const DEFAULT_LOCALE = "en";
const LOCALE_COOKIE_NAME = "locale";

// Cookie helpers
function getCookie(name: string): string | null {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) {
    return parts.pop()?.split(';').shift() || null;
  }
  return null;
}

function setCookie(name: string, value: string, days: number = 365) {
  const expires = new Date();
  expires.setTime(expires.getTime() + days * 24 * 60 * 60 * 1000);
  document.cookie = `${name}=${value};expires=${expires.toUTCString()};path=/;SameSite=Lax`;
}

// Get initial locale from cookie or default
function getInitialLocale(): string {
  const savedLocale = getCookie(LOCALE_COOKIE_NAME);

  // Validate saved locale
  if (savedLocale && AVAILABLE_LOCALES.includes(savedLocale as any)) {
    return savedLocale;
  }

  return DEFAULT_LOCALE;
}

// Initialize i18next with locale from cookie
const initialLocale = getInitialLocale();

i18next.init({
  lng: initialLocale,
  fallbackLng: DEFAULT_LOCALE,
  resources: {
    en: { translation: en },
    ru: { translation: ru },
  },
  interpolation: {
    escapeValue: false,
  },
});

// Svelte 5 rune-based reactive locale
let currentLocale = $state(i18next.language);

// Listen to i18next language changes
i18next.on("languageChanged", (lng) => {
  currentLocale = lng;
});

// Reactive translation function using Svelte 5 runes
export function t(key: string, options?: any): string {
  // Access currentLocale to make this reactive
  const _ = currentLocale;
  return i18next.t(key, options) as string;
}

// Get current locale (reactive)
export function getLocale(): string {
  return currentLocale;
}

// Set locale and save to cookie
export function setLocale(lang: string) {
  // Validate locale
  if (!AVAILABLE_LOCALES.includes(lang as any)) {
    console.warn(`Invalid locale: ${lang}. Falling back to ${DEFAULT_LOCALE}`);
    lang = DEFAULT_LOCALE;
  }

  // Save to cookie
  setCookie(LOCALE_COOKIE_NAME, lang);

  // Change language
  i18next.changeLanguage(lang);
}

// Synchronize locale from Inertia shared props
export function syncLocaleFromProps(propsLocale: string) {
  if (propsLocale && propsLocale !== i18next.language) {
    // Validate locale
    if (AVAILABLE_LOCALES.includes(propsLocale as any)) {
      // Save to cookie
      setCookie(LOCALE_COOKIE_NAME, propsLocale);
      // Change language
      i18next.changeLanguage(propsLocale);
    }
  }
}

// Export i18next instance
export { i18next };
