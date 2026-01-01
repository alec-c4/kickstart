import { createApp, h, type DefineComponent } from 'vue';
import { createInertiaApp } from '@inertiajs/vue3';
import { i18n } from '@/lib/i18n';

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob<DefineComponent>('../pages/**/*.vue', {
      eager: true,
    });
    const page = pages[`../pages/${name}.vue`];
    if (!page) {
      console.error(`Missing Inertia page component: '${name}.vue'`);
    }

    return page;
  },

  setup({ el, App, props, plugin }) {
    createApp({ render: () => h(App, props) })
      .use(plugin)
      .use(i18n)
      .mount(el);
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
