import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { router } from "@inertiajs/react";
import {
  setLocale,
  getLocale,
  AVAILABLE_LOCALES,
  type Locale,
} from "@/lib/i18n";

const LOCALE_NAMES: Record<Locale, string> = {
  en: "English",
  ru: "Русский",
};

interface LanguageSwitcherProps {
  withBorder?: boolean;
}

export default function LanguageSwitcher({
  withBorder = false,
}: LanguageSwitcherProps) {
  const { t } = useTranslation();
  const [isOpen, setIsOpen] = useState(false);
  const [currentLocale, setCurrentLocale] = useState<Locale>(getLocale());

  useEffect(() => {
    const handleLocaleChange = () => {
      setCurrentLocale(getLocale());
    };

    window.addEventListener("languageChanged", handleLocaleChange);
    return () =>
      window.removeEventListener("languageChanged", handleLocaleChange);
  }, []);

  const handleLocaleChange = (locale: Locale) => {
    setLocale(locale);
    setIsOpen(false);

    // Reload page with new locale to sync with backend
    const url = new URL(window.location.href);
    url.searchParams.set("locale", locale);
    router.visit(url.toString(), {
      preserveState: false,
      preserveScroll: false,
    });
  };

  return (
    <div className="relative">
      <button
        onClick={() => setIsOpen(!isOpen)}
        className={`flex items-center justify-center h-9 w-9 rounded-md text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors ${
          withBorder ? "border border-gray-200 dark:border-gray-700" : ""
        }`}
        aria-label={t("language.toggle")}
        title={t("language.toggle")}
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          strokeLinecap="round"
          strokeLinejoin="round"
        >
          <path d="m5 8 6 6" />
          <path d="m4 14 6-6 2-3" />
          <path d="M2 5h12" />
          <path d="M7 2h1" />
          <path d="m22 22-5-10-5 10" />
          <path d="M14 18h6" />
        </svg>
      </button>

      {isOpen && (
        <>
          <div
            className="fixed inset-0 z-10"
            onClick={() => setIsOpen(false)}
          />
          <div className="absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg border border-gray-200 dark:border-gray-700 z-20">
            <div className="py-1">
              {AVAILABLE_LOCALES.map((locale) => (
                <button
                  key={locale}
                  onClick={() => handleLocaleChange(locale)}
                  className="w-full px-4 py-2 text-left text-sm hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center justify-between"
                >
                  <span className="text-black dark:text-white">
                    {LOCALE_NAMES[locale]}
                  </span>
                  {currentLocale === locale && (
                    <span className="text-green-500">✓</span>
                  )}
                </button>
              ))}
            </div>
          </div>
        </>
      )}
    </div>
  );
}
