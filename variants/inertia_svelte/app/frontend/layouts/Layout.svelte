<script lang="ts">
  import Flash from '@/lib/components/Flash.svelte';

  interface Props {
    children: any;
  }

  let { children }: Props = $props();
</script>

<div class="min-h-screen bg-gray-50">
  <Flash />
  {@render children()}
</div>
