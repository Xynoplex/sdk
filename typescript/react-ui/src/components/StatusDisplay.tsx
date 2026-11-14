'use client';

import { useEffect, useState } from 'react';
import { useXynoplex } from '../session/XynoplexProvider';
import { useObservable } from '../hooks/useObservable';
import './StatusDisplay.css';

interface StatusDisplayProps {
  isFullyAuthenticated?: boolean;
  isAuthenticated?: boolean;
  hasValidGatewayToken?: boolean;
}

interface StatusData {
  status: string;
  version: string;
}

export function StatusDisplay({
  isFullyAuthenticated = false,
  isAuthenticated = false,
  hasValidGatewayToken = false
}: StatusDisplayProps) {
  const xynoplex = useObservable(useXynoplex().activeSession$)?.client;
  const [data, setData] = useState<StatusData | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    if (!xynoplex) { setLoading(false); return; }

    const fetchStatus = () => {
      xynoplex.system!.status()
        .then((result) => {
          setData(result as StatusData);
          setError(null);
          setLoading(false);
        })
        .catch((err) => {
          setError(err instanceof Error ? err : new Error(String(err)));
          setLoading(false);
        });
    };

    fetchStatus();
    const interval = setInterval(fetchStatus, 30000);
    return () => clearInterval(interval);
  }, [xynoplex]);

  const getStatusContent = () => {
    if (isAuthenticated && !hasValidGatewayToken) {
      return '🚀 Frontend Status: Ready • Gateway: Please sign out and sign in again to reconnect';
    }

    if (!isFullyAuthenticated) {
      return '🚀 Frontend Status: Ready • Gateway: Authentication required';
    }

    if (data) {
      return `🚀 Frontend Status: Ready • Gateway: ${data.status} (v${data.version})`;
    }

    if (loading) {
      return '🚀 Frontend Status: Ready • Gateway: Connecting...';
    }

    if (error) {
      const errorMessage = error.message;
      if (errorMessage.includes('401') || errorMessage.includes('Unauthorized')) {
        return '🚀 Frontend Status: Ready • Gateway: Please sign out and sign in again';
      }
      return '🚀 Frontend Status: Ready • Gateway: Connection failed';
    }

    return '🚀 Frontend Status: Ready • Gateway: Unknown';
  };

  const getStatusType = (): 'warning' | 'info' | 'success' | 'loading' | 'error' => {
    if (isAuthenticated && !hasValidGatewayToken) {
      return 'warning';
    }

    if (!isFullyAuthenticated) {
      return 'info';
    }

    if (data) {
      return 'success';
    }

    if (loading) {
      return 'loading';
    }

    return 'error';
  };

  return (
    <section
      className="xynoplex-status-display"
      data-status={getStatusType()}
      role="status"
      aria-live="polite"
      aria-label="System status information"
    >
      <p className="xynoplex-status-message">
        <span className="sr-only">System status: </span>
        {getStatusContent()}
      </p>
      {!isFullyAuthenticated ? (
        <p className="xynoplex-status-hint">
          Sign in to view gateway status
        </p>
      ) : error ? (
        <p className="xynoplex-status-hint xynoplex-status-error-hint" role="alert">
          <span className="sr-only">Error: </span>
          Check that the gateway server is running and accessible
        </p>
      ) : null}
    </section>
  );
}
