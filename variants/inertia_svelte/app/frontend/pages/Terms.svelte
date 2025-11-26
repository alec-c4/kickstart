<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import Layout from '../layouts/Layout.svelte';
</script>

<svelte:head>
  <title>Terms of Service - {$page.props.app_name}</title>
</svelte:head>

<Layout>
  <div class="flex min-h-screen items-center justify-center py-12">
    <div class="max-w-4xl px-6">
      <h1 class="text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl mb-8">
        Terms of Service
      </h1>
      <div class="prose prose-gray max-w-none">
        <p class="text-lg leading-8 text-gray-600">
          Welcome to {$page.props.app_name}. By using our service, you agree to these terms.
        </p>
        <h2 class="text-2xl font-bold text-gray-900 mt-8 mb-4">1. Use of Service</h2>
        <p class="text-gray-600 mb-6">
          You may use our service in accordance with these terms and applicable laws.
        </p>
        <h2 class="text-2xl font-bold text-gray-900 mt-8 mb-4">2. User Accounts</h2>
        <p class="text-gray-600 mb-6">
          You are responsible for maintaining the security of your account.
        </p>
        <h2 class="text-2xl font-bold text-gray-900 mt-8 mb-4">3. Content</h2>
        <p class="text-gray-600 mb-6">
          You retain ownership of content you submit, but grant us a license to use it.
        </p>
      </div>
      <div class="mt-10">
        <a
          href="/"
          class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500"
        >
          Back to Home
        </a>
      </div>
    </div>
  </div>
</Layout>
