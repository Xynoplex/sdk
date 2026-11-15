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
    <div className="xynolog-loading-state-wrapper">
      <div className="xynolog-loading-state xynolog-loading-state-compose">
        <p className="xynolog-loading-message">{message}</p>
      </div>
    </div>
  );
}
