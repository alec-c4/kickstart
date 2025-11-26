import { usePage, Head } from '@inertiajs/react';
import Layout from '../layouts/Layout';

interface PageProps {
  app_name: string;
}

export default function Privacy() {
  const { app_name } = usePage<PageProps>().props;

  return (
    <Layout>
      <Head title="Privacy Policy" />
      <div className="flex min-h-screen items-center justify-center py-12">
        <div className="max-w-4xl px-6">
          <h1 className="text-4xl font-bold tracking-tight text-gray-900 sm:text-5xl mb-8">
            Privacy Policy
          </h1>
          <div className="prose prose-gray max-w-none">
            <p className="text-lg leading-8 text-gray-600">
              At {app_name}, we take your privacy seriously. This policy describes how we collect,
              use, and protect your personal information.
            </p>
            <h2 className="text-2xl font-bold text-gray-900 mt-8 mb-4">1. Information We Collect</h2>
            <p className="text-gray-600 mb-6">
              We collect information you provide directly to us, such as when you create an account.
            </p>
            <h2 className="text-2xl font-bold text-gray-900 mt-8 mb-4">2. How We Use Your Information</h2>
            <p className="text-gray-600 mb-6">
              We use your information to provide, maintain, and improve our services.
            </p>
            <h2 className="text-2xl font-bold text-gray-900 mt-8 mb-4">3. Information Sharing</h2>
            <p className="text-gray-600 mb-6">
              We do not share your personal information with third parties except as described in this policy.
            </p>
            <h2 className="text-2xl font-bold text-gray-900 mt-8 mb-4">4. Data Security</h2>
            <p className="text-gray-600 mb-6">
              We implement appropriate security measures to protect your information.
            </p>
          </div>
          <div className="mt-10">
            <a
              href="/"
              className="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500"
            >
              Back to Home
            </a>
          </div>
        </div>
      </div>
    </Layout>
  );
}
