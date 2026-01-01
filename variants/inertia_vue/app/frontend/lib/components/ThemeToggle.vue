<template>
  <div class="relative">
    <button
      @click="isOpen = !isOpen"
      :class="[
        'flex items-center justify-center h-9 w-9 rounded-md text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors',
        withBorder ? 'border border-gray-200 dark:border-gray-700' : '',
      ]"
      :aria-label="t('theme.toggle')"
      :title="t('theme.toggle')"
      v-html="getIcon(theme)"
    />

    <div v-if="isOpen" class="fixed inset-0 z-10" @click="isOpen = false" />

    <div
      v-if="isOpen"
      class="absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg border border-gray-200 dark:border-gray-700 z-20"
    >
      <div class="py-1">
        <button
          v-for="themeConfig in themes"
          :key="themeConfig.value"
          @click="handleSetTheme(themeConfig.value)"
          class="w-full px-4 py-2 text-left text-sm hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center justify-between"
        >
          <span class="text-black dark:text-white">{{
            t(themeConfig.label)
          }}</span>
          <span v-if="theme === themeConfig.value" class="text-green-500"
            >✓</span
          >
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from "vue";
import { useI18n } from "vue-i18n";

type Theme = "light" | "dark" | "system";

interface Props {
  withBorder?: boolean;
}

withDefaults(defineProps<Props>(), {
  withBorder: false,
});

const { t } = useI18n();
const STORAGE_KEY = "theme-preference";

const isOpen = ref(false);
const theme = ref<Theme>("system");

const themes: Array<{ value: Theme; label: string }> = [
  { value: "light", label: "theme.light" },
  { value: "dark", label: "theme.dark" },
  { value: "system", label: "theme.system" },
];

function getIcon(iconTheme: Theme): string {
  switch (iconTheme) {
    case "light":
      return `
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="4" />
          <path d="M12 2v2" />
          <path d="M12 20v2" />
          <path d="m4.93 4.93 1.41 1.41" />
          <path d="m17.66 17.66 1.41 1.41" />
          <path d="M2 12h2" />
          <path d="M20 12h2" />
          <path d="m6.34 17.66-1.41 1.41" />
          <path d="m19.07 4.93-1.41 1.41" />
        </svg>
      `;
    case "dark":
      return `
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z" />
        </svg>
      `;
    default:
      return `
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect width="20" height="14" x="2" y="3" rx="2" />
          <line x1="8" x2="16" y1="21" y2="21" />
          <line x1="12" x2="12" y1="17" y2="21" />
        </svg>
      `;
  }
}

function applyTheme(newTheme: Theme) {
  const root = document.documentElement;
  root.classList.remove("light", "dark");

  if (newTheme === "system") {
    const systemTheme = window.matchMedia("(prefers-color-scheme: dark)")
      .matches
      ? "dark"
      : "light";
    root.classList.add(systemTheme);
  } else {
    root.classList.add(newTheme);
  }
}

function handleSetTheme(newTheme: Theme) {
  theme.value = newTheme;
  localStorage.setItem(STORAGE_KEY, newTheme);
  applyTheme(newTheme);
  isOpen.value = false;
}

onMounted(() => {
  const stored = localStorage.getItem(STORAGE_KEY);
  if (
    stored &&
    (stored === "light" || stored === "dark" || stored === "system")
  ) {
    theme.value = stored;
  }
  applyTheme(theme.value);

  const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");
  const handleChange = () => {
    if (theme.value === "system") {
      applyTheme("system");
    }
  };

  mediaQuery.addEventListener("change", handleChange);
});

watch(theme, (newTheme) => {
  applyTheme(newTheme);
});
</script>
