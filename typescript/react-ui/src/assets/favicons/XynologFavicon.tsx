interface XynologFaviconProps {
  size?: number;
  className?: string;
  variant?: 'gradient' | 'solid' | 'outline';
  background?: boolean;
}

export function XynologFavicon({
  size = 32,
  className = '',
  variant = 'gradient',
  background = true
}: XynologFaviconProps) {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 512 512"
      width={size}
      height={size}
      className={className}
      aria-label="Xynolog Logo"
    >
      <defs>
        <linearGradient id="xynologGradient" x1="0%" y1="0%" x2="100%" y2="100%">
          <stop offset="0%" style={{ stopColor: '#00FFFF', stopOpacity: 1 }} />
          <stop offset="100%" style={{ stopColor: '#0080FF', stopOpacity: 1 }} />
        </linearGradient>
        {variant === 'outline' && (
          <linearGradient id="xynologOutline" x1="0%" y1="0%" x2="100%" y2="100%">
            <stop offset="0%" style={{ stopColor: '#00FFFF', stopOpacity: 1 }} />
            <stop offset="100%" style={{ stopColor: '#0080FF', stopOpacity: 1 }} />
          </linearGradient>
        )}
      </defs>

      {/* Background */}
      {background && (
        <rect width="512" height="512" fill="#1a1a1a" />
      )}

      {/* S Letter */}
      <text
        x="256"
        y="380"
        fontFamily="'Orbitron', 'Arial Black', sans-serif"
        fontWeight="900"
        fontSize="380"
        textAnchor="middle"
        fill={
          variant === 'gradient'
            ? 'url(#xynologGradient)'
            : variant === 'solid'
            ? '#00FFFF'
            : 'none'
        }
        stroke={variant === 'outline' ? 'url(#xynologOutline)' : 'none'}
        strokeWidth={variant === 'outline' ? '12' : '0'}
      >
        S
      </text>
    </svg>
  );
}