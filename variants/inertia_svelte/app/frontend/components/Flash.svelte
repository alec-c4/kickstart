<script lang="ts">
  import { page } from '@inertiajs/svelte';

  let flash = $derived($page.props.flash);
  let visible = $state(false);

  $effect(() => {
    if (flash?.notice || flash?.alert || flash?.error) {
      visible = true;
      setTimeout(() => {
        visible = false;
      }, 5000);
    }
  });

  function getFlashType(): 'notice' | 'alert' | 'error' | null {
    if (flash?.notice) return 'notice';
    if (flash?.alert) return 'alert';
    if (flash?.error) return 'error';
    return null;
  }

  function getFlashMessage(): string {
    const type = getFlashType();
    if (!type) return '';
    return flash[type] as string;
  }

  function getFlashStyles(): string {
    const type = getFlashType();
    switch (type) {
      case 'notice':
        return 'bg-green-50 text-green-800 border-green-200';
      case 'error':
        return 'bg-red-50 text-red-800 border-red-200';
      case 'alert':
        return 'bg-yellow-50 text-yellow-800 border-yellow-200';
      default:
        return '';
    }
  }
</script>

{#if visible && getFlashType()}
  <div class="fixed top-4 right-4 z-50 max-w-md">
    <div class="border rounded-lg shadow-lg p-4 {getFlashStyles()}">
      <div class="flex items-center justify-between">
        <p class="text-sm font-medium">{getFlashMessage()}</p>
        <button
          onclick={() => (visible = false)}
          class="ml-4 text-current opacity-70 hover:opacity-100"
          aria-label="Close notification"
        >
          <svg class="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
            <path
              fill-rule="evenodd"
              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
              clip-rule="evenodd"
            />
          </svg>
        </button>
      </div>
    </div>
  </div>
{/if}
