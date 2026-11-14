/**
 * ComposeLoadingState Component
 *
 * Simple loading state display for the compose page.
 */

export interface ComposeLoadingStateProps {
  message: string;
}

export function ComposeLoadingState({ message }: ComposeLoadingStateProps) {
  return (
    <div className="xynoplex-loading-state-wrapper">
      <div className="xynoplex-loading-state xynoplex-loading-state-compose">
        <p className="xynoplex-loading-message">{message}</p>
      </div>
    </div>
  );
}
