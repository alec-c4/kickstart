<script lang="ts">
  import { router } from '@inertiajs/svelte';
  import { t, setLocale, getLocale } from '@/lib/i18n.svelte';

  interface Props {
    withBorder?: boolean;
  }

  let { withBorder = false }: Props = $props();

  let isOpen = $state(false);

  const languageConfigs = [
    { code: 'en', name: 'English' },
    { code: 'ru', name: 'Русский' }
  ];

  function switchLocale(lang: string) {
    setLocale(lang);
    isOpen = false;

    const url = new URL(window.location.href);
    url.searchParams.set('locale', lang);

    router.visit(url.toString(), {
      preserveState: false,
      preserveScroll: false
    });
  }

  function handleClickOutside() {
    isOpen = false;
  }
</script>

<div class="relative">
  <button
    onclick={() => isOpen = !isOpen}
    class="flex items-center justify-center h-9 w-9 rounded-md text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors {withBorder ? 'border border-gray-200 dark:border-gray-700' : ''}"
    aria-label={t('language.toggle')}
    title={t('language.toggle')}
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

  {#if isOpen}
    <!-- svelte-ignore a11y_click_events_have_key_events -->
    <!-- svelte-ignore a11y_no_static_element_interactions -->
    <div
      class="fixed inset-0 z-10"
      onclick={handleClickOutside}
    ></div>
    <div class="absolute right-0 mt-2 w-48 bg-white dark:bg-gray-800 rounded-md shadow-lg border border-gray-200 dark:border-gray-700 z-20">
      <div class="py-1">
        {#each languageConfigs as language}
          <button
            onclick={() => switchLocale(language.code)}
            class="w-full px-4 py-2 text-left text-sm hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center justify-between"
          >
            <span class="text-black dark:text-white">{language.name}</span>
            {#if getLocale() === language.code}
              <span class="text-green-500">✓</span>
            {/if}
          </button>
        {/each}
      </div>
    </div>
  {/if}
</div>
