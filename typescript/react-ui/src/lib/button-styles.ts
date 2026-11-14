/**
 * Centralized button styles matching Figma design
 * Two primary styles from authenticated home page:
 * 1. Primary (cyan/blue gradient) - for main CTAs
 * 2. Secondary (gray with black outline) - for secondary actions
 */

export const buttonStyles = {
  // Primary button - cyan/blue gradient (used for main CTAs like "New Document", "Sign In", "Sign Up")
  primary: {
    base: "xynoplex-button xynoplex-button--primary",
    large: "xynoplex-button xynoplex-button--primary xynoplex-button--large",
  },

  // Secondary button - gray with subtle outline (used for "Search", "Cancel", etc.)
  secondary: {
    base: "xynoplex-button xynoplex-button--secondary",
    withScale: "xynoplex-button xynoplex-button--secondary xynoplex-button--scale",
  },

  // Tertiary button - minimal style for less important actions
  tertiary: {
    base: "xynoplex-button xynoplex-button--tertiary",
  },

  // Danger button - for destructive actions
  danger: {
    base: "xynoplex-button xynoplex-button--danger",
  },

  // Warning/Yellow button - for highlight actions
  warning: {
    base: "xynoplex-button xynoplex-button--warning",
  },

  // Utility function to combine classes
  combine: (...classes: string[]) => classes.filter(Boolean).join(' '),
} as const;