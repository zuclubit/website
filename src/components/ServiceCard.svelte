<script>
  /**
   * ServiceCard.svelte
   * Ultra-Refined Glass-Metal Service Card — Cuervo 2025 Specification
   *
   * Futuristic luminous glass-metal fusion seamlessly merging Zuclubit dark AI aesthetic
   * with advanced neumorphism. Physical plausibility + cinematic depth.
   *
   * @component
   */

  import { onMount } from 'svelte';

  // Props API
  export let icon = null;              // Lucide Svelte icon component
  export let title = '';               // Service title (22px 700)
  export let body = '';                // Service description (16px 400)
  export let tags = [];                // Array of tag strings (14px semibold)
  export let ctaText = 'Learn More';   // CTA link text
  export let ctaHref = '#';            // CTA link href
  export let delay = 0;                // Scroll reveal delay (for stagger)

  let cardElement;
  let isPressed = false;

  onMount(() => {
    // Scroll reveal animation handled by parent (App.svelte) via GSAP ScrollTrigger
  });
</script>

<!-- Service Card Container -->
<article
  class="service-card"
  class:pressed={isPressed}
  bind:this={cardElement}
  style="--reveal-delay: {delay}ms"
  on:mousedown={() => (isPressed = true)}
  on:mouseup={() => (isPressed = false)}
  on:mouseleave={() => (isPressed = false)}
>
  <!-- Top-Left Specular Reflection Edge -->
  <div class="specular-edge" aria-hidden="true"></div>

  <!-- Gradient Light Layer (Cool Cyan → Turquoise) -->
  <div class="gradient-light" aria-hidden="true"></div>

  <!-- Inner Soft Diffusion Layer -->
  <div class="card-diffuser" aria-hidden="true"></div>

  <!-- Content Container -->
  <div class="card-content">

    <!-- Icon with Luminous Circular Aura -->
    {#if icon}
      <div class="icon-aura-container">
        <!-- Luminous Aura Background -->
        <div class="icon-aura" aria-hidden="true"></div>
        <!-- Icon -->
        <div class="icon-wrapper">
          <svelte:component
            this={icon}
            size={48}
            strokeWidth={2}
            class="card-icon"
          />
        </div>
      </div>
    {/if}

    <!-- Title (22px 700 #EAF1FC) -->
    <h3 class="card-title">{title}</h3>

    <!-- Body Text (16px 400 #A0A5BE) -->
    <p class="card-body">{body}</p>

    <!-- Frosted Glass Tags (Pill Style with Light Diffusion) -->
    {#if tags.length > 0}
      <div class="card-tags">
        {#each tags as tag}
          <span class="card-tag">
            <span class="tag-diffuser" aria-hidden="true"></span>
            <span class="tag-text">{tag}</span>
          </span>
        {/each}
      </div>
    {/if}

    <!-- CTA with Glowing Capsule + Animated Underline -->
    <a href={ctaHref} class="card-cta">
      <span class="cta-glow" aria-hidden="true"></span>
      <span class="cta-text">{ctaText}</span>
      <svg
        class="cta-arrow"
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
     ULTRA-REFINED SERVICE CARD
     Cuervo 2025 — Luminous Glass-Metal Fusion
     ======================================== */

  /* Design Tokens — Ultra-Refined System */
  :root {
    /* Glass-Metal Material */
    --card-blur: 18px;           /* 16-20px frosted glass */
    --card-opacity: 0.80;        /* 78-82% precise opacity */
    --card-sat: 110%;            /* Saturation boost */

    /* Border & Radius */
    --card-radius: 20px;         /* 18-22px range */
    --card-bevel: 1px;           /* Inner bevel width */

    /* Typography Ultra-Refined */
    --card-title-size: 22px;     /* Exact 22px */
    --card-title-weight: 700;    /* Bold */
    --card-body-size: 16px;      /* Exact 16px */
    --card-body-weight: 400;     /* Regular */
    --card-tag-size: 14px;       /* Exact 14px */
    --card-tag-weight: 600;      /* Semibold */

    /* Motion (300ms cubic-bezier) */
    --card-duration: 300ms;
    --card-ease: cubic-bezier(0.2, 0.8, 0.2, 1);

    /* Spacing */
    --card-padding: clamp(24px, 3vw, 32px);
    --card-gap: 18px;
  }

  /* Main Card Container — Dual-Layer Frosted Glass */
  .service-card {
    position: relative;
    overflow: hidden;

    /* Flexible container */
    display: flex;
    flex-direction: column;

    /* Padding */
    padding: var(--card-padding);

    /* Dark Translucent Base: #1F242A → #12161B */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.80) 0%,
      rgba(18, 22, 27, 0.80) 100%
    );

    /* Glass-metal fusion blur */
    backdrop-filter: blur(var(--card-blur)) saturate(var(--card-sat));
    -webkit-backdrop-filter: blur(var(--card-blur)) saturate(var(--card-sat));

    /* Inner bevel 1px #2D333C */
    border: var(--card-bevel) solid rgba(45, 51, 60, 0.85);
    border-radius: var(--card-radius);

    /* Ultra-Refined Shadow System */
    box-shadow:
      /* Ambient shadow 0 8px 32px */
      0 8px 32px rgba(0, 0, 0, 0.45),
      0 4px 16px rgba(0, 0, 0, 0.25),

      /* Turquoise halo rgba(0,229,195,0.1) */
      0 0 0 1px rgba(0, 229, 195, 0.08),

      /* Top-left specular highlight (#C7D1F6) */
      inset 1.5px 1.5px 3px rgba(199, 209, 246, 0.18),
      inset 0.5px 0.5px 1.5px rgba(199, 209, 246, 0.12),

      /* 225° turquoise rimlight (#00E5C3) */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.14),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.10),

      /* Ambient occlusion (AO) bottom */
      inset 0 -1.5px 3px rgba(0, 0, 0, 0.20);

    /* Smooth transitions (300ms) */
    transition:
      transform var(--card-duration) var(--card-ease),
      box-shadow var(--card-duration) var(--card-ease),
      opacity var(--card-duration) var(--card-ease),
      filter var(--card-duration) var(--card-ease);

    /* Initial state for scroll reveal */
    opacity: 0;
    transform: translateY(20px);
    filter: blur(4px);

    /* GPU acceleration */
    will-change: transform, opacity, filter;
  }

  /* Top-Left Specular Reflection Edge (#C7D1F6) */
  .specular-edge {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;

    height: 1px;

    /* Highlight 1px top edge #C7D1F6 */
    background: linear-gradient(90deg,
      transparent 0%,
      rgba(199, 209, 246, 0.30) 20%,
      rgba(199, 209, 246, 0.20) 50%,
      transparent 100%
    );

    border-radius: var(--card-radius) var(--card-radius) 0 0;
    pointer-events: none;
    z-index: 3;
  }

  /* Gradient Light (Cool Cyan Top-Left → Turquoise Bottom-Right) */
  .gradient-light {
    position: absolute;
    inset: 0;

    /* Directional lighting gradient */
    background:
      linear-gradient(
        135deg,
        rgba(0, 207, 255, 0.04) 0%,      /* Cool cyan top-left */
        transparent 40%,
        transparent 60%,
        rgba(0, 229, 195, 0.06) 100%     /* Turquoise bottom-right */
      );

    border-radius: var(--card-radius);
    pointer-events: none;
    z-index: 1;

    transition: opacity var(--card-duration) var(--card-ease);
  }

  /* Inner Soft Diffusion Layer */
  .card-diffuser {
    position: absolute;
    inset: 0;

    /* Radial soft internal diffusion */
    background: radial-gradient(
      ellipse at 50% 0%,
      rgba(199, 209, 246, 0.05) 0%,
      rgba(199, 209, 246, 0.02) 50%,
      rgba(0, 229, 195, 0.02) 100%
    );

    border-radius: var(--card-radius);
    pointer-events: none;
    z-index: 0;
  }

  /* Hover State — Glow Intensifies +20%, Scale 1.015 */
  .service-card:hover {
    transform: translateY(-2px) scale(1.015);

    /* Enhanced shadow + glow +20% */
    box-shadow:
      /* Ambient shadow enhanced */
      0 12px 42px rgba(0, 0, 0, 0.50),
      0 6px 20px rgba(0, 0, 0, 0.30),

      /* Turquoise halo intensified +20% */
      0 0 0 1px rgba(0, 229, 195, 0.12),
      0 0 20px rgba(0, 229, 195, 0.15),
      0 0 40px rgba(0, 229, 195, 0.08),

      /* Specular highlight enhanced */
      inset 1.5px 1.5px 3px rgba(199, 209, 246, 0.24),
      inset 0.5px 0.5px 1.5px rgba(199, 209, 246, 0.18),

      /* Rimlight enhanced */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.18),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.14),

      /* AO */
      inset 0 -1.5px 3px rgba(0, 0, 0, 0.20);
  }

  .service-card:hover .gradient-light {
    opacity: 1.2;
  }

  /* Pressed State — Inner Reflection Compress (Tactile Glass Feedback) */
  .service-card.pressed {
    transform: translateY(0) scale(0.985);

    /* Inner reflection compressed */
    box-shadow:
      /* Reduced elevation */
      0 4px 16px rgba(0, 0, 0, 0.40),

      /* Inner glow pulse */
      inset 0 0 16px rgba(0, 229, 195, 0.20),
      inset 0 2px 8px rgba(0, 0, 0, 0.30),

      /* Compressed specular */
      inset 2px 2px 4px rgba(199, 209, 246, 0.15),

      /* AO enhanced */
      inset 0 -2px 6px rgba(0, 0, 0, 0.35);

    transition-duration: 100ms;
  }

  /* Content Container */
  .card-content {
    position: relative;
    z-index: 2;

    display: flex;
    flex-direction: column;
    gap: var(--card-gap);
  }

  /* ========================================
     ICON WITH LUMINOUS CIRCULAR AURA
     ======================================== */

  .icon-aura-container {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;

    width: 88px;
    height: 88px;

    margin-bottom: 4px;
  }

  /* Luminous Aura (Circular Glow) */
  .icon-aura {
    position: absolute;
    inset: 0;

    /* Circular luminous aura */
    background: radial-gradient(
      circle at center,
      rgba(0, 229, 195, 0.15) 0%,
      rgba(0, 207, 255, 0.10) 30%,
      rgba(0, 229, 195, 0.05) 60%,
      transparent 100%
    );

    border-radius: 50%;

    /* Micro-glow around edge */
    box-shadow:
      0 0 20px rgba(0, 229, 195, 0.20),
      0 0 40px rgba(0, 229, 195, 0.10),
      inset 0 0 20px rgba(0, 229, 195, 0.08);

    opacity: 0.7;

    transition: all var(--card-duration) var(--card-ease);
  }

  .service-card:hover .icon-aura {
    opacity: 1;

    /* Aura expansion on hover */
    transform: scale(1.08);

    /* Enhanced glow */
    box-shadow:
      0 0 28px rgba(0, 229, 195, 0.30),
      0 0 56px rgba(0, 229, 195, 0.15),
      inset 0 0 24px rgba(0, 229, 195, 0.12);
  }

  /* Icon Wrapper */
  .icon-wrapper {
    position: relative;
    z-index: 1;

    display: flex;
    align-items: center;
    justify-content: center;

    width: 72px;
    height: 72px;

    /* Glass circle container */
    background: rgba(31, 36, 42, 0.60);
    border: 1px solid rgba(199, 209, 246, 0.15);
    border-radius: 50%;

    /* Icon container shadow */
    box-shadow:
      0 4px 12px rgba(0, 0, 0, 0.20),
      inset 0 1px 2px rgba(255, 255, 255, 0.08);

    transition: all var(--card-duration) var(--card-ease);
  }

  .service-card:hover .icon-wrapper {
    background: rgba(31, 36, 42, 0.75);
    border-color: rgba(0, 229, 195, 0.30);

    box-shadow:
      0 6px 18px rgba(0, 229, 195, 0.25),
      0 2px 8px rgba(0, 0, 0, 0.25),
      inset 0 1px 2px rgba(255, 255, 255, 0.12);
  }

  /* Icon — Line Pictogram with Micro-Glow */
  :global(.card-icon) {
    color: #C7D1F6;

    /* Micro-glow around icon */
    filter: drop-shadow(0 2px 8px rgba(0, 229, 195, 0.20));

    transition: all var(--card-duration) var(--card-ease);
  }

  .service-card:hover :global(.card-icon) {
    color: #EAF1FC;

    /* Enhanced micro-glow on hover */
    filter: drop-shadow(0 4px 12px rgba(0, 229, 195, 0.35));
  }

  /* ========================================
     TYPOGRAPHY — ULTRA-REFINED
     ======================================== */

  /* Title (22px 700 #EAF1FC) */
  .card-title {
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: var(--card-title-size);
    font-weight: var(--card-title-weight);
    letter-spacing: -0.015em;
    line-height: 1.3;

    color: #EAF1FC;
    margin: 0;

    /* Text highlight softens in/out on hover */
    transition: color var(--card-duration) var(--card-ease);
  }

  .service-card:hover .card-title {
    color: #FFFFFF;
  }

  /* Body (16px 400 #A0A5BE) */
  .card-body {
    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: var(--card-body-size);
    font-weight: var(--card-body-weight);
    letter-spacing: -0.005em;
    line-height: 1.6;

    color: #A0A5BE;
    margin: 0;

    /* Maintain visual hierarchy */
    opacity: 0.95;
  }

  /* ========================================
     FROSTED GLASS TAGS (Pill Style)
     ======================================== */

  .card-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }

  .card-tag {
    position: relative;

    display: inline-flex;
    align-items: center;

    padding: 7px 14px;

    /* Frosted glass pill */
    background: rgba(31, 36, 42, 0.65);
    backdrop-filter: blur(10px) saturate(120%);
    -webkit-backdrop-filter: blur(10px) saturate(120%);

    border: 1px solid rgba(199, 209, 246, 0.20);
    border-radius: 14px;

    /* Subtle shadow */
    box-shadow:
      0 2px 6px rgba(0, 0, 0, 0.12),
      inset 0 1px 1px rgba(255, 255, 255, 0.08);

    overflow: hidden;

    transition: all 200ms var(--card-ease);
  }

  /* Tag Light Diffusion Layer */
  .tag-diffuser {
    position: absolute;
    inset: 0;

    /* Light diffusion effect */
    background: radial-gradient(
      ellipse at 30% 20%,
      rgba(199, 209, 246, 0.08) 0%,
      transparent 70%
    );

    pointer-events: none;
  }

  /* Tag Text (14px semibold) */
  .tag-text {
    position: relative;
    z-index: 1;

    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: var(--card-tag-size);
    font-weight: var(--card-tag-weight);
    letter-spacing: 0.005em;

    color: #C7D1F6;
  }

  .card-tag:hover {
    background: rgba(31, 36, 42, 0.80);
    border-color: rgba(0, 229, 195, 0.40);

    /* Turquoise glow on hover */
    box-shadow:
      0 0 12px rgba(0, 229, 195, 0.25),
      0 2px 8px rgba(0, 0, 0, 0.16),
      inset 0 1px 1px rgba(255, 255, 255, 0.12);
  }

  .card-tag:hover .tag-text {
    color: #EAF1FC;
  }

  /* ========================================
     CTA — GLOWING CAPSULE + ANIMATED UNDERLINE
     ======================================== */

  .card-cta {
    position: relative;

    display: inline-flex;
    align-items: center;
    gap: 8px;

    padding: 12px 20px;
    margin-top: 4px;

    /* Glowing glass capsule */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.70) 0%,
      rgba(18, 22, 27, 0.70) 100%
    );
    backdrop-filter: blur(12px) saturate(115%);
    -webkit-backdrop-filter: blur(12px) saturate(115%);

    border: 1px solid rgba(199, 209, 246, 0.18);
    border-radius: 14px;

    /* Typography */
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: 15px;
    font-weight: 600;
    letter-spacing: -0.003em;

    color: #00E5C3;
    text-decoration: none;

    /* Shadow */
    box-shadow:
      0 3px 10px rgba(0, 0, 0, 0.18),
      inset 0 1px 1px rgba(255, 255, 255, 0.08);

    cursor: pointer;
    overflow: hidden;

    transition: all 240ms var(--card-ease);
  }

  /* CTA Glow Layer (Inner) */
  .cta-glow {
    position: absolute;
    inset: 0;

    /* Inner glow gradient */
    background: radial-gradient(
      ellipse at 50% 50%,
      rgba(0, 229, 195, 0.08) 0%,
      transparent 70%
    );

    opacity: 0;
    transition: opacity 240ms var(--card-ease);
  }

  /* CTA Text */
  .cta-text {
    position: relative;
    z-index: 1;
  }

  /* CTA Arrow */
  .cta-arrow {
    position: relative;
    z-index: 1;

    transition: transform 240ms var(--card-ease);
  }

  /* CTA Hover — Glowing Capsule Enhanced */
  .card-cta:hover {
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.85) 0%,
      rgba(18, 22, 27, 0.85) 100%
    );

    border-color: rgba(0, 229, 195, 0.40);

    /* Turquoise glow */
    box-shadow:
      0 0 16px rgba(0, 229, 195, 0.30),
      0 0 32px rgba(0, 229, 195, 0.15),
      0 4px 14px rgba(0, 0, 0, 0.22),
      inset 0 1px 1px rgba(255, 255, 255, 0.12);

    color: #00FFDB;
  }

  .card-cta:hover .cta-glow {
    opacity: 1;
  }

  .card-cta:hover .cta-arrow {
    transform: translateX(3px);
  }

  /* CTA Animated Underline */
  .card-cta::after {
    content: '';
    position: absolute;
    bottom: 4px;
    left: 20px;
    right: 40px;

    height: 2px;
    background: linear-gradient(90deg,
      #00E5C3 0%,
      #00CFFF 100%
    );
    border-radius: 1px;

    /* Micro-glow */
    box-shadow: 0 0 6px rgba(0, 229, 195, 0.40);

    transform: scaleX(0);
    transform-origin: left center;

    transition: transform 240ms var(--card-ease);
  }

  .card-cta:hover::after {
    transform: scaleX(1);
  }

  /* Focus State (Keyboard Accessibility) */
  .card-cta:focus-visible {
    outline: none;

    box-shadow:
      0 0 0 2px rgba(31, 36, 42, 1),
      0 0 0 4px #00E5C3,
      0 0 16px rgba(0, 229, 195, 0.40);
  }

  /* ========================================
     RESPONSIVE DESIGN
     ======================================== */

  @media (max-width: 768px) {
    :root {
      --card-padding: 20px;
      --card-gap: 14px;
      --card-title-size: 20px;
      --card-body-size: 15px;
    }

    .icon-aura-container {
      width: 76px;
      height: 76px;
    }

    .icon-wrapper {
      width: 64px;
      height: 64px;
    }

    :global(.card-icon) {
      width: 40px;
      height: 40px;
    }
  }

  /* ========================================
     ACCESSIBILITY
     ======================================== */

  /* Reduced Motion */
  @media (prefers-reduced-motion: reduce) {
    .service-card,
    .gradient-light,
    .icon-aura,
    .icon-wrapper,
    :global(.card-icon),
    .card-tag,
    .card-cta,
    .cta-arrow,
    .cta-glow {
      transition: none;
    }

    .service-card:hover,
    .service-card.pressed {
      transform: none;
    }
  }

  /* High Contrast Mode */
  @media (prefers-contrast: high) {
    .service-card {
      border: 2px solid #FFFFFF;
    }

    .card-title {
      color: #FFFFFF;
    }

    .card-tag,
    .card-cta {
      border-width: 2px;
    }
  }
</style>
