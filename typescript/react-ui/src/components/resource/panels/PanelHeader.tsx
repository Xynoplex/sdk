'use client';

interface PanelHeaderProps {
  count: number;
  title: string;
}

/**
 * Shared header for annotation panels
 *
 * Displays the translated title and the count in a consistent format
 */
export function PanelHeader({ count, title }: PanelHeaderProps) {
  return (
    <div className="xynolog-panel-header">
      <h2 className="xynolog-panel-header__title">
        <span className="xynolog-panel-header__text">{title}</span>
        <span className="xynolog-panel-header__count">({count})</span>
      </h2>
    </div>
  );
}
