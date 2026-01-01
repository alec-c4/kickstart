import { usePage, Head } from '@inertiajs/react';
import Layout from '@/layouts/Layout';

interface PageProps {
  app_name: string;
  [key: string]: any;
}

export default function Home() {
  const { app_name } = usePage<PageProps>().props;

  return (
    <Layout>
      <Head title="Home" />
      <div className="flex min-h-screen items-center justify-center">
        <div className="text-center">
          <h1 className="text-4xl font-bold tracking-tight text-gray-900 dark:text-white sm:text-6xl">
            {app_name}
          </h1>
          <p className="mt-6 text-lg leading-8 text-gray-600 dark:text-gray-300">
            Built with Rails, Inertia.js, and React
          </p>
          <div className="mt-10 flex items-center justify-center gap-x-6">
            <a
              href="https://inertia-rails.dev"
              target="_blank"
              rel="noopener noreferrer"
              className="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
            >
              Inertia Rails Docs
            </a>
            <a
              href="https://react.dev"
              target="_blank"
              rel="noopener noreferrer"
              className="text-sm font-semibold leading-6 text-gray-900 dark:text-gray-100"
            >
              React Docs <span aria-hidden="true">→</span>
            </a>
          </div>
        </div>
      </div>
    </Layout>
  );
}
