import { usePage, Head } from '@inertiajs/react';
import Layout from '../layouts/Layout';

interface PageProps {
  app_name: string;
}

export default function About() {
  const { app_name } = usePage<PageProps>().props;

  return (
    <Layout>
      <Head title="About" />
      <div className="flex min-h-screen items-center justify-center">
        <div className="max-w-2xl text-center">
          <h1 className="text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
            About {app_name}
          </h1>
          <p className="mt-6 text-lg leading-8 text-gray-600">
            This is a modern web application built with Rails, Inertia.js, and React.
            It combines the power of server-side rendering with the flexibility of a
            single-page application.
          </p>
          <div className="mt-10">
            <a
              href="/"
              className="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
            >
              Back to Home
            </a>
          </div>
        </div>
      </div>
    </Layout>
  );
}
