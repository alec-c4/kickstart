import Flash from '@/lib/components/Flash';

export default function Layout({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen bg-gray-50">
      <Flash />
      {children}
    </div>
  );
}
