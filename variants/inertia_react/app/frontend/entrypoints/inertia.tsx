import { createInertiaApp } from '@inertiajs/react';
import { createRoot } from 'react-dom/client';
import { I18nextProvider } from 'react-i18next';
import i18n from '@/lib/i18n';

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob('../pages/**/*.tsx', { eager: true });
    const page = pages[`../pages/${name}.tsx`];
    if (!page) {
      console.error(`Missing Inertia page component: '${name}.tsx'`);
    }

    return page;
  },

  setup({ el, App, props }) {
    if (el) {
      const root = createRoot(el);
      root.render(
        <I18nextProvider i18n={i18n}>
          <App {...props} />
        </I18nextProvider>
      );
    } else {
      console.error(
        'Missing root element.\n\n' +
          'If you see this error, it probably means you load Inertia.js on non-Inertia pages.\n' +
          'Consider moving <%= vite_typescript_tag "inertia" %> to the Inertia-specific layout instead.'
      );
    }
  },

  defaults: {
    form: {
      forceIndicesArrayFormatInFormData: false,
    },
    future: {
      useDataInertiaHeadAttribute: true,
      useDialogForErrorModal: true,
      preserveEqualProps: true,
    },
  },
});
