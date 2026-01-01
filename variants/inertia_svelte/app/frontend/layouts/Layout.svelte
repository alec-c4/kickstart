<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import Flash from '@/lib/components/Flash.svelte';
  import LanguageSwitcher from '@/lib/components/LanguageSwitcher.svelte';
  import ThemeToggle from '@/lib/components/ThemeToggle.svelte';
  import { syncLocaleFromProps } from '@/lib/i18n.svelte';

  interface Props {
    children: any;
  }

  let { children }: Props = $props();

  $effect(() => {
    const locale = ($page.props as any).locale;
    if (locale) {
      syncLocaleFromProps(locale);
    }
  });
</script>

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
    {@render children()}
  </main>
</div>
