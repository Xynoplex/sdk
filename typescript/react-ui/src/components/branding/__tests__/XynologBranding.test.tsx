import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import { XynologBranding } from '../XynologBranding';

describe('XynologBranding Component', () => {
  const mockTranslate = vi.fn((key: string) => {
    const translations: Record<string, string> = {
      tagline: 'Semantic Annotation Tool',
    };
    return translations[key] || key;
  });

  beforeEach(() => {
    mockTranslate.mockClear();
  });

  describe('Basic Rendering', () => {
    it('should render the Xynolog heading', () => {
      render(<XynologBranding t={mockTranslate} />);

      expect(screen.getByText('Xynolog')).toBeInTheDocument();
    });

    it('should render the tagline by default', () => {
      render(<XynologBranding t={mockTranslate} />);

      expect(screen.getByText('Semantic Annotation Tool')).toBeInTheDocument();
      expect(mockTranslate).toHaveBeenCalledWith('tagline');
    });

    it('should render main heading as h1', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h1 = container.querySelector('h1');
      expect(h1).toBeInTheDocument();
      expect(h1).toHaveTextContent('Xynolog');
    });

    it('should render tagline as h2 when shown', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h2 = container.querySelector('h2');
      expect(h2).toBeInTheDocument();
      expect(h2).toHaveTextContent('Semantic Annotation Tool');
    });
  });

  describe('Tagline Display Control', () => {
    it('should show tagline when showTagline is true', () => {
      render(<XynologBranding t={mockTranslate} showTagline={true} />);

      expect(screen.getByText('Semantic Annotation Tool')).toBeInTheDocument();
    });

    it('should hide tagline when showTagline is false', () => {
      render(<XynologBranding t={mockTranslate} showTagline={false} />);

      expect(
        screen.queryByText('Semantic Annotation Tool'),
      ).not.toBeInTheDocument();
      expect(mockTranslate).not.toHaveBeenCalledWith('tagline');
    });

    it('should not render h2 when tagline is hidden', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} showTagline={false} />,
      );

      expect(container.querySelector('h2')).not.toBeInTheDocument();
    });
  });

  describe('Size Variants', () => {
    it('should apply small size classes', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="sm" />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });

    it('should apply medium size classes', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="md" />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });

    it('should apply large size classes by default', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });

    it('should apply extra large size classes', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="xl" />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });
  });

  describe('Tagline Size Variants', () => {
    it('should apply small tagline size', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="sm" showTagline={true} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should apply medium tagline size', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="md" showTagline={true} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should apply large tagline size', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="lg" showTagline={true} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should apply extra large tagline size', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="xl" showTagline={true} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });
  });

  describe('Compact Tagline Mode', () => {
    it('should apply compact tagline styles when compactTagline is true', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} compactTagline={true} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should apply different spacing with compact tagline', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} compactTagline={true} />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
      // Component uses data-compact-tagline attribute for compact mode
    });

    it('should apply normal spacing without compact tagline', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} compactTagline={false} />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });

    it('should use compact size classes with compactTagline', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} size="sm" compactTagline={true} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should apply tracking-wide for normal tagline', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} compactTagline={false} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });
  });

  describe('Animation', () => {
    it('should apply animation classes by default', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
      // Component uses data-animated attribute for animation
    });

    it('should apply delayed animation to tagline', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should not apply animation classes when animated is false', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} animated={false} />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });

    it('should not animate tagline when animated is false', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} animated={false} />,
      );

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });
  });

  describe('Custom Styling', () => {
    it('should apply custom className', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} className="custom-class" />,
      );

      const wrapper = container.querySelector('.custom-class');
      expect(wrapper).toBeInTheDocument();
    });

    it('should preserve default classes with custom className', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} className="custom-class" />,
      );

      const wrapper = container.querySelector('.custom-class');
      expect(wrapper).toHaveClass('xynolog-branding');
    });

    it('should apply empty className by default', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const wrapper = container.firstChild as HTMLElement;
      expect(wrapper).toHaveClass('xynolog-branding');
    });
  });

  describe('Typography Classes', () => {
    it('should apply font-orbitron to heading', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });

    it('should apply font-orbitron to tagline', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });

    it('should apply gradient text to heading', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const span = container.querySelector('h1 span');
      expect(span).toHaveClass('xynolog-branding-text');
    });

    it('should apply color classes to tagline', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const h2 = container.querySelector('h2');
      expect(h2).toHaveClass('xynolog-branding-tagline');
    });
  });

  describe('Layout Structure', () => {
    it('should have flex column layout', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const wrapper = container.firstChild as HTMLElement;
      expect(wrapper).toHaveClass('xynolog-branding');
    });

    it('should center items', () => {
      const { container } = render(<XynologBranding t={mockTranslate} />);

      const wrapper = container.firstChild as HTMLElement;
      expect(wrapper).toHaveClass('xynolog-branding');
    });
  });

  describe('Translation Integration', () => {
    it('should call translate function with tagline key', () => {
      render(<XynologBranding t={mockTranslate} showTagline={true} />);

      expect(mockTranslate).toHaveBeenCalledWith('tagline');
      expect(mockTranslate).toHaveBeenCalledTimes(1);
    });

    it('should not call translate when tagline is hidden', () => {
      render(<XynologBranding t={mockTranslate} showTagline={false} />);

      expect(mockTranslate).not.toHaveBeenCalled();
    });

    it('should display custom translation', () => {
      const customTranslate = vi.fn(() => 'Custom Tagline Text');

      render(<XynologBranding t={customTranslate} />);

      expect(screen.getByText('Custom Tagline Text')).toBeInTheDocument();
    });
  });

  describe('Edge Cases', () => {
    it('should handle missing translation gracefully', () => {
      const emptyTranslate = vi.fn(() => '');

      render(<XynologBranding t={emptyTranslate} />);

      const h2 = screen.queryByRole('heading', { level: 2 });
      expect(h2).toBeInTheDocument();
      expect(h2).toHaveTextContent('');
    });

    it('should combine all props correctly', () => {
      const { container } = render(
        <XynologBranding
          t={mockTranslate}
          size="md"
          showTagline={true}
          animated={false}
          compactTagline={true}
          className="custom"
        />,
      );

      const h1 = container.querySelector('h1');
      const h2 = container.querySelector('h2');

      expect(h1).toHaveClass('xynolog-branding-title');
      expect(h2).toHaveClass('xynolog-branding-tagline');
      expect(container.querySelector('.custom')).toBeInTheDocument();
    });
  });

  describe('Spacing Behavior', () => {
    it('should not apply margin-bottom when tagline is hidden', () => {
      const { container } = render(
        <XynologBranding t={mockTranslate} showTagline={false} />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).not.toHaveClass('xynolog-branding__heading--compact');
      expect(h1).not.toHaveClass('xynolog-branding__heading--normal');
    });

    it('should apply margin-bottom when tagline is shown', () => {
      const { container } = render(
        <XynologBranding
          t={mockTranslate}
          showTagline={true}
          compactTagline={false}
        />,
      );

      const h1 = container.querySelector('h1');
      expect(h1).toHaveClass('xynolog-branding-title');
    });
  });
});
