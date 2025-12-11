import { usePage } from '@inertiajs/react';
import { useEffect, useState } from 'react';

interface PageProps {
  flash: {
    notice?: string;
    alert?: string;
    error?: string;
  };
  [key: string]: any;
}

export default function Flash() {
  const { flash } = usePage<PageProps>().props;
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    if (flash?.notice || flash?.alert || flash?.error) {
      setVisible(true);
      const timer = setTimeout(() => {
        setVisible(false);
      }, 5000);
      return () => clearTimeout(timer);
    }
  }, [flash]);

  const getFlashType = (): 'notice' | 'alert' | 'error' | null => {
    if (flash?.notice) return 'notice';
    if (flash?.alert) return 'alert';
    if (flash?.error) return 'error';
    return null;
  };

  const getFlashMessage = (): string => {
    const type = getFlashType();
    if (!type) return '';
    return flash[type] as string;
  };

  const getFlashStyles = (): string => {
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
  };

  if (!visible || !getFlashType()) {
    return null;
  }

  return (
    <div className="fixed top-4 right-4 z-50 max-w-md">
      <div className={`border rounded-lg shadow-lg p-4 ${getFlashStyles()}`}>
        <div className="flex items-center justify-between">
          <p className="text-sm font-medium">{getFlashMessage()}</p>
          <button
            onClick={() => setVisible(false)}
            className="ml-4 text-current opacity-70 hover:opacity-100"
            aria-label="Close notification"
          >
            <svg className="h-5 w-5" fill="currentColor" viewBox="0 0 20 20">
              <path
                fillRule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clipRule="evenodd"
              />
            </svg>
          </button>
        </div>
      </div>
    </div>
  );
}
