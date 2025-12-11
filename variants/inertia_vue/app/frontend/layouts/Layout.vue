<script setup lang="ts">
import Flash from '$lib/components/Flash.vue';
</script>

<template>
  <div class="min-h-screen bg-gray-50">
    <Flash />
    <slot />
  </div>
</template>
