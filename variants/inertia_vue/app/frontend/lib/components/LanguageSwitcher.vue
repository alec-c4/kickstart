<template>
  <div class="relative">
    <button
      @click="isOpen = !isOpen"
      :class="[
        'flex items-center justify-center h-9 w-9 rounded-md text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors',
        withBorder ? 'border border-gray-200 dark:border-gray-700' : '',
      ]"
      :aria-label="t('language.toggle')"
      :title="t('language.toggle')"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="20"
        height="20"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
        <path d="m5 8 6 6" />
        <path d="m4 14 6-6 2-3" />
        <path d="M2 5h12" />
        <path d="M7 2h1" />
        <path d="m22 22-5-10-5 10" />
        <path d="M14 18h6" />
      </svg>
    </button>

    <div v-if="isOpen" class="fixed inset-0 z-10" @click="isOpen = false" />

    <div
      v-if="isOpen"
      class="absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg border border-gray-200 dark:border-gray-700 z-20"
    >
      <div class="py-1">
        <button
          v-for="language in languages"
          :key="language.code"
          @click="switchLocale(language.code)"
          class="w-full px-4 py-2 text-left text-sm hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center justify-between"
        >
          <span class="text-black dark:text-white">{{ language.name }}</span>
          <span v-if="currentLocale === language.code" class="text-green-500"
            >✓</span
          >
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from "vue";
import { useI18n } from "vue-i18n";
import { router } from "@inertiajs/vue3";
import { setLocale, getLocale, type Locale } from "@/lib/i18n";

interface Props {
  withBorder?: boolean;
}

withDefaults(defineProps<Props>(), {
  withBorder: false,
});

const { t } = useI18n();
const isOpen = ref(false);
const currentLocale = computed(() => getLocale());

const languages = [
  { code: "en" as Locale, name: "English" },
  { code: "ru" as Locale, name: "Русский" },
];

function switchLocale(locale: Locale) {
  setLocale(locale);
  isOpen.value = false;

  const url = new URL(window.location.href);
  url.searchParams.set("locale", locale);

  router.visit(url.toString(), {
    preserveState: false,
    preserveScroll: false,
  });
}
</script>
