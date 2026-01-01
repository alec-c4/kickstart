import { useEffect } from 'react';
import { usePage } from '@inertiajs/react';
import Flash from '@/lib/components/Flash';
import LanguageSwitcher from '@/lib/components/LanguageSwitcher';
import ThemeToggle from '@/lib/components/ThemeToggle';
import { syncLocaleFromProps } from '@/lib/i18n';
import '@/lib/i18n';

interface SharedProps {
  locale?: string;
}

export default function Layout({ children }: { children: React.ReactNode }) {
  const { props } = usePage<SharedProps>();

  useEffect(() => {
    if (props.locale) {
      syncLocaleFromProps(props.locale);
    }
  }, [props.locale]);

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors">
      <header className="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 transition-colors">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center">
              <h1 className="text-xl font-semibold text-gray-900 dark:text-white">
                App
              </h1>
            </div>
            <div className="flex items-center gap-2">
              <LanguageSwitcher />
              <ThemeToggle />
            </div>
          </div>
        </div>
      </header>
      <Flash />
      <main>{children}</main>
    </div>
  );
}
