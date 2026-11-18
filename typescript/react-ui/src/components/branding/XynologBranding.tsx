'use client';

import type { TranslateFn } from '../../types/translation';
import './Branding.css';

interface XynologBrandingProps {
  t: TranslateFn;
  className?: string;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  showTagline?: boolean;
  animated?: boolean;
  compactTagline?: boolean;
}

export function XynologBranding({
  t,
  className = '',
  size = 'lg',
  showTagline = true,
  animated = true,
  compactTagline = false,
}: XynologBrandingProps) {
  return (
    <div
      className={`xynolog-branding ${className}`}
      data-size={size}
      data-animated={animated}
      data-compact-tagline={compactTagline}
    >
      {/* Main heading */}
      <h1 className="xynolog-branding-title">
        <span className="xynolog-branding-text">Xynolog</span>
      </h1>

      {/* Tagline */}
      {showTagline && (
        <h2 className="xynolog-branding-tagline">{t('tagline')}</h2>
      )}
    </div>
  );
}
