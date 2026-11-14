"use client";

import type { TranslateFn } from '../../types/translation';
import './Branding.css';

interface XynoplexBrandingProps {
  t: TranslateFn;
  className?: string;
  size?: 'sm' | 'md' | 'lg' | 'xl';
  showTagline?: boolean;
  animated?: boolean;
  compactTagline?: boolean;
}

export function XynoplexBranding({
  t,
  className = "",
  size = 'lg',
  showTagline = true,
  animated = true,
  compactTagline = false
}: XynoplexBrandingProps) {
  return (
    <div
      className={`xynoplex-branding ${className}`}
      data-size={size}
      data-animated={animated}
      data-compact-tagline={compactTagline}
    >
      {/* Main heading */}
      <h1 className="xynoplex-branding-title">
        <span className="xynoplex-branding-text">
          Xynoplex
        </span>
      </h1>

      {/* Tagline */}
      {showTagline && (
        <h2 className="xynoplex-branding-tagline">
          {t('tagline')}
        </h2>
      )}
    </div>
  );
}
