<script>
  /**
   * ServiceCard.svelte
   * Glass-Metal Service Card Component — Cuervo 2025 Specification
   *
   * Perfectly homologated with Zuclubit navbar and bottom dock.
   * Dual-chamber frosted glass with unified turquoise-cyan lighting system.
   *
   * @component
   */

  import { onMount } from 'svelte';

  // Props API
  export let icon = null;              // Lucide Svelte icon component
  export let title = '';               // Service title (20-22px)
  export let body = '';                // Service description (16-17px)
  export let tags = [];                // Array of tag strings
  export let ctaText = 'Learn More';   // CTA link text
  export let ctaHref = '#';            // CTA link href
  export let delay = 0;                // Scroll reveal delay (for stagger)

  let cardElement;
  let isVisible = false;

  onMount(() => {
    // Scroll reveal animation will be handled by parent (App.svelte)
    // via GSAP ScrollTrigger for performance
  });
</script>

<!-- Service Card Container -->
<article
  class="service-card"
  bind:this={cardElement}
  style="--reveal-delay: {delay}ms"
>
  <!-- Inner Diffuser Layer -->
  <div class="card-diffuser" aria-hidden="true"></div>

  <!-- Content Container -->
  <div class="card-content">

    <!-- Icon Medallion (Top) -->
    {#if icon}
      <div class="card-icon-container">
        <svelte:component
          this={icon}
          size={48}
          strokeWidth={2}
          class="card-icon"
        />
      </div>
    {/if}

    <!-- Title -->
    <h3 class="card-title">{title}</h3>

    <!-- Body Text -->
    <p class="card-body">{body}</p>

    <!-- Tags (Glass Chips) -->
    {#if tags.length > 0}
      <div class="card-tags">
        {#each tags as tag}
          <span class="card-tag">{tag}</span>
        {/each}
      </div>
    {/if}

    <!-- CTA Link -->
    <a href={ctaHref} class="card-cta">
      {ctaText}
      <svg
        class="card-cta-arrow"
        width="16"
        height="16"
        viewBox="0 0 16 16"
        fill="none"
        aria-hidden="true"
      >
        <path
          d="M6 12L10 8L6 4"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        />
      </svg>
    </a>

  </div>
</article>

<style>
  /* ========================================
     SERVICE CARD — CUERVO 2025 GLASS-METAL
     Perfect homologation with navbar/dock
     ======================================== */

  /* Design Tokens - Unified Glass System */
  :root {
    /* Material Glass Premium */
    --card-blur: 16px;           /* 16px dual-chamber frosted */
    --card-opacity: 0.80;        /* 78-82% opacity */
    --card-sat: 110%;            /* Subtle saturation boost */

    /* Border radius (consistent with dock 22px) */
    --card-radius: 20px;         /* 18-22px range */

    /* Inner bevel */
    --card-bevel: 1px solid rgba(45, 51, 60, 0.85);  /* #2D333C */

    /* Typography */
    --card-title-size: 21px;     /* 20-22px */
    --card-body-size: 16px;      /* 16-17px */
    --card-weight: 600;          /* Semibold 600-700 */
    --card-tracking: -0.003em;   /* -0.3% tight */

    /* Motion timing (matches navbar shrink) */
    --card-t-hover: 200ms;
    --card-ease: cubic-bezier(0.2, 0.8, 0.2, 1);

    /* Spacing */
    --card-padding: clamp(24px, 3vw, 32px);
    --card-gap: 16px;
  }

  /* Main Card Container - Dual-Chamber Frosted Glass */
  .service-card {
    position: relative;

    /* Flexible container */
    display: flex;
    flex-direction: column;

    /* Padding */
    padding: var(--card-padding);

    /* Dual-Chamber Frosted Glass Shell */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.80) 0%,
      rgba(18, 22, 27, 0.80) 100%
    );
    backdrop-filter: blur(var(--card-blur)) saturate(var(--card-sat));
    -webkit-backdrop-filter: blur(var(--card-blur)) saturate(var(--card-sat));

    /* Inner bevel: 1px #2D333C */
    border: 1px solid rgba(45, 51, 60, 0.85);
    border-radius: var(--card-radius);

    /* Unified Lighting System - Triple Layer */
    box-shadow:
      /* Outer elevation shadow */
      0 4px 16px rgba(0, 0, 0, 0.24),
      0 2px 8px rgba(0, 0, 0, 0.16),

      /* Specular highlight top-left 45° (#C7D1F6) */
      inset 1.5px 1.5px 3px rgba(199, 209, 246, 0.18),
      inset 0.5px 0.5px 1.5px rgba(199, 209, 246, 0.12),

      /* Turquoise rimlight 225° bottom-right (#00E5C3) */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.12),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.08),

      /* Ambient occlusion (AO) - bottom divider */
      inset 0 -1px 2px rgba(0, 0, 0, 0.15);

    /* Smooth transitions */
    transition:
      transform var(--card-t-hover) var(--card-ease),
      box-shadow var(--card-t-hover) var(--card-ease),
      opacity var(--card-t-hover) var(--card-ease);

    /* Initial state for scroll reveal */
    opacity: 0;
    transform: translateY(20px);
    filter: blur(4px);

    /* Will-change for GPU acceleration */
    will-change: transform, opacity, filter;
  }

  /* Scroll reveal animation (applied via GSAP) */
  .service-card.revealed {
    opacity: 1;
    transform: translateY(0);
    filter: blur(0);
  }

  /* Hover State - Elevation +2px, scale 1.015 */
  .service-card:hover {
    transform: translateY(-2px) scale(1.015);

    /* Enhanced glow on hover */
    box-shadow:
      /* Outer elevation increased */
      0 8px 28px rgba(0, 0, 0, 0.28),
      0 4px 12px rgba(0, 0, 0, 0.20),

      /* Turquoise perimeter glow (subtle) */
      0 0 16px rgba(0, 229, 195, 0.12),
      0 0 32px rgba(0, 229, 195, 0.06),

      /* Specular highlight enhanced */
      inset 1.5px 1.5px 3px rgba(199, 209, 246, 0.22),
      inset 0.5px 0.5px 1.5px rgba(199, 209, 246, 0.16),

      /* Turquoise rimlight enhanced */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.16),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.12),

      /* AO */
      inset 0 -1px 2px rgba(0, 0, 0, 0.15);
  }

  /* Active/Pressed State - scale 0.985 */
  .service-card:active {
    transform: translateY(0) scale(0.985);
    transition-duration: 100ms;
  }

  /* Inner Matte Diffuser Layer */
  .card-diffuser {
    position: absolute;
    inset: 0;

    /* Radial gradient diffuser with turquoise tint */
    background: radial-gradient(
      ellipse at 50% 0%,
      rgba(199, 209, 246, 0.06) 0%,
      rgba(199, 209, 246, 0.03) 50%,
      rgba(0, 229, 195, 0.02) 100%
    );

    border-radius: var(--card-radius);
    pointer-events: none;
    z-index: 0;
  }

  /* Content Container */
  .card-content {
    position: relative;
    z-index: 1;

    display: flex;
    flex-direction: column;
    gap: var(--card-gap);
  }

  /* Icon Container - Medallion with Turquoise Glow */
  .card-icon-container {
    display: flex;
    align-items: center;
    justify-content: center;

    width: 72px;
    height: 72px;

    /* Glass capsule background */
    background: rgba(31, 36, 42, 0.6);
    border: 1px solid rgba(45, 51, 60, 0.85);
    border-radius: 50%;

    /* Icon glow with turquoise accent */
    box-shadow:
      0 4px 12px rgba(0, 0, 0, 0.20),
      inset 0 1px 2px rgba(199, 209, 246, 0.15);

    transition: all var(--card-t-hover) var(--card-ease);
  }

  .service-card:hover .card-icon-container {
    /* Enhanced glow on card hover */
    box-shadow:
      0 6px 16px rgba(0, 229, 195, 0.20),
      0 2px 8px rgba(0, 229, 195, 0.15),
      inset 0 1px 2px rgba(199, 209, 246, 0.20);

    background: rgba(31, 36, 42, 0.75);
  }

  /* Icon - Monoline 2px with Turquoise Drop-Shadow */
  :global(.card-icon) {
    color: #C7D1F6;

    /* Subtle turquoise drop-shadow (8px @ 15%) */
    filter: drop-shadow(0 2px 8px rgba(0, 229, 195, 0.15));

    transition: all var(--card-t-hover) var(--card-ease);
  }

  .service-card:hover :global(.card-icon) {
    color: #EAF1FC;  /* Brighten on hover */
    filter: drop-shadow(0 4px 12px rgba(0, 229, 195, 0.25));
  }

  /* Title - Inter/SF Pro 600-700, 20-22px */
  .card-title {
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: var(--card-title-size);
    font-weight: 700;
    letter-spacing: var(--card-tracking);
    line-height: 1.3;

    color: #EAF1FC;  /* WCAG AA contrast 13.94:1 on dark bg */
    margin: 0;

    transition: color var(--card-t-hover) var(--card-ease);
  }

  .service-card:hover .card-title {
    color: #FFFFFF;  /* Pure white on hover for emphasis */
  }

  /* Body Text - Inter 16-17px */
  .card-body {
    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: var(--card-body-size);
    font-weight: 400;
    letter-spacing: -0.002em;
    line-height: 1.6;

    color: #C7D1F6;  /* WCAG AA contrast 9.87:1 */
    margin: 0;

    /* Low-vignette depth effect */
    opacity: 0.92;
  }

  /* Tags Container */
  .card-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;

    margin-top: 4px;
  }

  /* Individual Tag - Glass Chip */
  .card-tag {
    display: inline-flex;
    align-items: center;

    padding: 6px 12px;

    /* Glass capsule with blur 8px */
    background: rgba(31, 36, 42, 0.65);
    backdrop-filter: blur(8px) saturate(120%);
    -webkit-backdrop-filter: blur(8px) saturate(120%);

    /* Border: 1px rgba(199,209,246,0.25) */
    border: 1px solid rgba(199, 209, 246, 0.25);
    border-radius: 12px;

    /* Typography */
    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: 13px;
    font-weight: 600;
    letter-spacing: 0.01em;

    color: #A0A5BE;  /* Muted accent */

    /* Soft shadow */
    box-shadow:
      0 2px 4px rgba(0, 0, 0, 0.12),
      inset 0 1px 1px rgba(199, 209, 246, 0.08);

    transition: all var(--card-t-hover) var(--card-ease);
  }

  /* Tag Hover - Glow accent #00E5C3 (consistent with navbar links) */
  .card-tag:hover {
    background: rgba(31, 36, 42, 0.80);
    border-color: rgba(0, 229, 195, 0.40);
    color: #EAF1FC;

    /* Turquoise glow */
    box-shadow:
      0 0 8px rgba(0, 229, 195, 0.25),
      0 2px 6px rgba(0, 0, 0, 0.16),
      inset 0 1px 1px rgba(199, 209, 246, 0.12);
  }

  /* CTA Link - Underline Animation (matching navbar) */
  .card-cta {
    position: relative;

    display: inline-flex;
    align-items: center;
    gap: 6px;

    margin-top: 8px;

    /* Typography */
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: 16px;
    font-weight: 600;
    letter-spacing: -0.002em;

    color: #00E5C3;  /* Turquoise CTA color */
    text-decoration: none;

    transition: color var(--card-t-hover) var(--card-ease);
  }

  .card-cta:hover {
    color: #00FFDB;  /* Brighter turquoise on hover */
  }

  /* CTA Underline Animation - 200ms ease-out (matching nav) */
  .card-cta::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    right: 20px;  /* Account for arrow */

    height: 2px;
    background: #00E5C3;
    border-radius: 1px;

    /* Subtle bloom */
    box-shadow: 0 0 4px rgba(0, 229, 195, 0.3);

    transform: scaleX(0);
    transform-origin: left center;

    transition: transform 200ms cubic-bezier(0.2, 0.8, 0.2, 1);
  }

  .card-cta:hover::after {
    transform: scaleX(1);
  }

  /* CTA Arrow Icon */
  .card-cta-arrow {
    transition: transform var(--card-t-hover) var(--card-ease);
  }

  .card-cta:hover .card-cta-arrow {
    transform: translateX(3px);
  }

  /* Focus State (Accessibility) */
  .service-card:focus-within {
    outline: none;

    /* Turquoise focus ring */
    box-shadow:
      0 0 0 2px rgba(31, 36, 42, 1),
      0 0 0 4px #00E5C3,
      0 0 16px rgba(0, 229, 195, 0.4),

      /* Maintain inner lighting */
      inset 1.5px 1.5px 3px rgba(199, 209, 246, 0.18),
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.12);
  }

  /* Responsive Adjustments */
  @media (max-width: 768px) {
    :root {
      --card-padding: 20px;
      --card-gap: 14px;
      --card-title-size: 20px;
      --card-body-size: 15px;
    }

    .card-icon-container {
      width: 64px;
      height: 64px;
    }

    :global(.card-icon) {
      width: 40px;
      height: 40px;
    }
  }

  /* Reduced Motion (Accessibility) */
  @media (prefers-reduced-motion: reduce) {
    .service-card,
    .card-icon-container,
    :global(.card-icon),
    .card-tag,
    .card-cta,
    .card-cta::after,
    .card-cta-arrow {
      transition: none;
    }

    .service-card {
      transform: none !important;
      filter: none !important;
    }
  }

  /* High Contrast Mode (Accessibility) */
  @media (prefers-contrast: high) {
    .service-card {
      border: 2px solid #FFFFFF;
    }

    .card-title,
    .card-body {
      color: #FFFFFF;
    }

    .card-tag {
      border-color: #FFFFFF;
      color: #FFFFFF;
    }
  }
</style>
