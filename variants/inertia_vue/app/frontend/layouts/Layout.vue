<script setup lang="ts">
import { watch } from 'vue';
import { usePage } from '@inertiajs/vue3';
import Flash from '@/lib/components/Flash.vue';
import LanguageSwitcher from '@/lib/components/LanguageSwitcher.vue';
import ThemeToggle from '@/lib/components/ThemeToggle.vue';
import { syncLocaleFromProps, i18n } from '@/lib/i18n';

const page = usePage();

watch(
  () => (page.props as any).locale,
  (locale) => {
    if (locale) {
      syncLocaleFromProps(locale);
    }
  },
  { immediate: true }
);
</script>

<template>
  <div class="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors">
    <header class="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 transition-colors">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
          <div class="flex items-center">
            <h1 class="text-xl font-semibold text-gray-900 dark:text-white">
              App
            </h1>
          </div>
          <div class="flex items-center gap-2">
            <LanguageSwitcher />
            <ThemeToggle />
          </div>
        </div>
      </div>
    </header>
    <Flash />
    <main>
      <slot />
    </main>
  </div>
</template>
