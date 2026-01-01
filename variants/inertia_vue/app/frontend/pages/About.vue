<script setup lang="ts">
import { usePage, Head } from '@inertiajs/vue3';
import Layout from '@/layouts/Layout.vue';

const page = usePage();
const appName = page.props.app_name as string;
</script>

<template>
  <Layout>
    <Head title="About" />
    <div class="flex min-h-screen items-center justify-center">
      <div class="max-w-2xl text-center">
        <h1 class="text-4xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-6xl">
          About {{ appName }}
        </h1>
        <p class="mt-6 text-lg leading-8 text-gray-600 dark:text-gray-300">
          This is a modern web application built with Rails, Inertia.js, and Vue 3.
          It combines the power of server-side rendering with the flexibility of a
          single-page application.
        </p>
        <div class="mt-10">
          <a
            href="/"
            class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
          >
            Back to Home
          </a>
        </div>
      </div>
    </div>
  </Layout>
</template>
