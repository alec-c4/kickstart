<script setup lang="ts">
import { usePage, Head } from '@inertiajs/vue3';
import Layout from '@/layouts/Layout.vue';

const page = usePage();
const appName = page.props.app_name as string;
</script>

<template>
  <Layout>
    <Head title="Home" />
    <div class="flex min-h-screen items-center justify-center">
      <div class="text-center">
        <h1 class="text-4xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-6xl">
          {{ appName }}
        </h1>
        <p class="mt-6 text-lg leading-8 text-gray-600 dark:text-gray-300">
          Built with Rails, Inertia.js, and Vue 3
        </p>
        <div class="mt-10 flex items-center justify-center gap-x-6">
          <a
            href="https://inertia-rails.dev"
            target="_blank"
            rel="noopener noreferrer"
            class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
          >
            Inertia Rails Docs
          </a>
          <a
            href="https://vuejs.org"
            target="_blank"
            rel="noopener noreferrer"
            class="text-sm font-semibold leading-6 text-gray-900 dark:text-gray-100"
          >
            Vue 3 Docs <span aria-hidden="true">→</span>
          </a>
        </div>
      </div>
    </div>
  </Layout>
</template>
