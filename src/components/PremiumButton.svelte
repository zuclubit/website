<!--
  PremiumButton Component - Glass-Metal Triple-Layer CTA

  Botón CTA premium con estética glass-metal de triple capa siguiendo
  arquitectura limpia y principios SOLID.

  Características:
  - Triple-layer: shell brillante + difusor mate + núcleo luminoso
  - Backdrop-filter premium 16-20px
  - Rimlight turquesa direccional 225°
  - 5 estados: reposo, hover, active, focus, disabled
  - Animaciones premium con cubic-bezier
  - WCAG AA compliant (contraste ≥4.5:1)

  @component
  @example
  <PremiumButton variant="primary" size="md" on:click={handleClick}>
    Contact Us
  </PremiumButton>
-->

<script>
  /**
   * Variante del botón
   * @type {"primary" | "secondary" | "ghost"}
   */
  export let variant = 'primary';

  /**
   * Tamaño del botón
   * @type {"sm" | "md" | "lg"}
   */
  export let size = 'md';

  /**
   * Estado disabled
   * @type {boolean}
   */
  export let disabled = false;

  /**
   * URL de destino (si es enlace)
   * @type {string | null}
   */
  export let href = null;

  /**
   * Target del enlace
   * @type {"_self" | "_blank" | "_parent" | "_top"}
   */
  export let target = '_self';

  /**
   * Tipo de botón (si no es enlace)
   * @type {"button" | "submit" | "reset"}
   */
  export let type = 'button';

  /**
   * Clases CSS adicionales
   * @type {string}
   */
  let className = '';
  export { className as class };

  /**
   * ARIA label para accesibilidad
   * @type {string}
   */
  export let ariaLabel = '';

  // Validación de props
  $: validVariant = ['primary', 'secondary', 'ghost'].includes(variant) ? variant : 'primary';
  $: validSize = ['sm', 'md', 'lg'].includes(size) ? size : 'md';
  $: isExternal = href && (href.startsWith('http') || href.startsWith('//'));

  // Clases dinámicas
  $: classes = `
    premium-button
    variant-${validVariant}
    size-${validSize}
    ${disabled ? 'disabled' : ''}
    ${className}
  `.trim().replace(/\s+/g, ' ');
</script>

{#if href && !disabled}
  <a
    {href}
    {target}
    class={classes}
    aria-label={ariaLabel}
    rel={isExternal ? 'noopener noreferrer' : undefined}
  >
    <!-- Difusor Mate Interior (Capa 2) -->
    <span class="button-diffuser" aria-hidden="true"></span>

    <!-- Núcleo Luminoso (Capa 3) -->
    <span class="button-core" aria-hidden="true"></span>

    <!-- Contenido -->
    <span class="button-content">
      <slot />
    </span>
  </a>
{:else}
  <button
    {type}
    {disabled}
    class={classes}
    aria-label={ariaLabel}
    on:click
    on:mouseenter
    on:mouseleave
    on:focus
    on:blur
  >
    <!-- Difusor Mate Interior (Capa 2) -->
    <span class="button-diffuser" aria-hidden="true"></span>

    <!-- Núcleo Luminoso (Capa 3) -->
    <span class="button-core" aria-hidden="true"></span>

    <!-- Contenido -->
    <span class="button-content">
      <slot />
    </span>
  </button>
{/if}

<style>
  /* ========================================
     Base Button - Shell Exterior (Capa 1)
     ======================================== */
  .premium-button {
    /* Reset */
    margin: 0;
    border: none;
    cursor: pointer;
    text-decoration: none;
    -webkit-tap-highlight-color: transparent;

    /* Layout */
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    vertical-align: middle;

    /* Geometría: pastilla 18-22px radius */
    border-radius: 20px;

    /* Shell Exterior Brillante con Inner-Bevel Premium */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.82) 0%,
      rgba(26, 31, 36, 0.82) 50%,
      rgba(18, 22, 27, 0.82) 100%
    );

    /* Backdrop-filter premium: 16-20px blur */
    backdrop-filter: blur(18px) saturate(140%);
    -webkit-backdrop-filter: blur(18px) saturate(140%);

    /* Inner-bevel: 1.2px #A0A5BE @18% */
    border: 1.2px solid rgba(160, 165, 190, 0.18);

    /* Shell + Iluminación */
    box-shadow:
      /* Specular Strip Suave (top, 6-10% intensidad) */
      inset 0 1px 1.5px 0 rgba(255, 255, 255, 0.08),

      /* Rimlight Turquesa Direccional 225° */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.12),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.08),

      /* Outer Elevation */
      0 4px 12px rgba(0, 0, 0, 0.12),
      0 1px 3px rgba(0, 0, 0, 0.08),

      /* Viñeta Interna Sutil */
      inset 0 0 20px rgba(0, 0, 0, 0.06);

    /* Tipografía Premium: Inter/SF Semibold 600-700 */
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-weight: 600;
    line-height: 1.2;
    text-align: center;
    white-space: nowrap;

    /* Color texto reposo: #C7D1F6 */
    color: #C7D1F6;

    /* Animación: hover-in 120-160ms */
    transition:
      transform 140ms cubic-bezier(0.22, 0.61, 0.36, 1),
      box-shadow 140ms cubic-bezier(0.22, 0.61, 0.36, 1),
      background 140ms cubic-bezier(0.22, 0.61, 0.36, 1),
      color 140ms cubic-bezier(0.22, 0.61, 0.36, 1),
      border-color 140ms cubic-bezier(0.22, 0.61, 0.36, 1);

    /* User interaction */
    user-select: none;
    -webkit-user-select: none;
  }

  /* ========================================
     Tamaños (Size Variants)
     ======================================== */

  /* Small: 16px, padding 16x24 */
  .premium-button.size-sm {
    font-size: 16px;
    padding: 16px 24px;
    letter-spacing: -0.003em; /* -0.3% */
    min-height: 44px; /* Touch target WCAG */
  }

  /* Medium: 17px, padding 19x30 */
  .premium-button.size-md {
    font-size: 17px;
    padding: 19px 30px;
    letter-spacing: -0.004em; /* -0.4% */
    min-height: 48px;
  }

  /* Large: 18px, padding 20x32 */
  .premium-button.size-lg {
    font-size: 18px;
    padding: 20px 32px;
    letter-spacing: -0.005em; /* -0.5% */
    min-height: 52px;
  }

  /* ========================================
     Difusor Mate Interior (Capa 2)
     ======================================== */
  .button-diffuser {
    position: absolute;
    inset: 0;
    border-radius: inherit;
    background: radial-gradient(
      ellipse at 50% 0%,
      rgba(199, 209, 246, 0.06) 0%,
      rgba(199, 209, 246, 0.03) 50%,
      rgba(0, 229, 195, 0.02) 100%
    );
    pointer-events: none;
    z-index: 0;

    /* Difusor aumenta en active: 8-12% */
    transition: opacity 140ms cubic-bezier(0.22, 0.61, 0.36, 1);
  }

  /* ========================================
     Núcleo Luminoso con Glow Controlado (Capa 3)
     ======================================== */
  .button-core {
    position: absolute;
    inset: 0;
    border-radius: inherit;
    background: radial-gradient(
      ellipse at 50% 50%,
      rgba(0, 229, 195, 0.04) 0%,
      transparent 70%
    );
    pointer-events: none;
    z-index: 1;

    /* Glow contenido en reposo */
    box-shadow: 0 0 16px rgba(0, 229, 195, 0.04);

    /* Breathing Animation (opcional, 1.6-2.2s) */
    animation: core-breathing 2s ease-in-out infinite;
    transition: opacity 140ms cubic-bezier(0.22, 0.61, 0.36, 1);
  }

  @keyframes core-breathing {
    0%, 100% {
      opacity: 1;
      transform: scale(1);
    }
    50% {
      opacity: 0.92; /* Amplitud 8% */
      transform: scale(1.02);
    }
  }

  /* ========================================
     Contenido (z-index encima de capas)
     ======================================== */
  .button-content {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;

    /* Trazo interno blanco 10-12% para legibilidad */
    text-shadow: 0 0 12px rgba(255, 255, 255, 0.1);
  }

  /* ========================================
     Estado: Hover
     ======================================== */
  .premium-button:hover:not(.disabled) {
    /* Texto → #EAF1FC */
    color: #EAF1FC;

    /* Elevar +1 nivel: sombra 0 8-12px 24-32px @12-16% */
    box-shadow:
      /* Specular superior más marcado */
      inset 0 1px 2px 0 rgba(255, 255, 255, 0.12),

      /* Rimlight turquesa +10-15% intensidad */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.22),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.15),

      /* Outer elevation aumentado */
      0 10px 28px rgba(0, 0, 0, 0.14),
      0 4px 12px rgba(0, 0, 0, 0.1),

      /* Viñeta */
      inset 0 0 20px rgba(0, 0, 0, 0.06);

    /* Transform: elevación sutil */
    transform: translateY(-1px);
  }

  /* Núcleo más intenso en hover */
  .premium-button:hover:not(.disabled) .button-core {
    opacity: 1.2;
    box-shadow: 0 0 24px rgba(0, 229, 195, 0.08);
  }

  /* ========================================
     Estado: Active/Pressed
     ======================================== */
  .premium-button:active:not(.disabled) {
    /* Compresión óptica 1-2px */
    transform: translateY(1px) scale(0.98);

    /* Subrayado/halo inferior: 2-3px #00E5C3 */
    box-shadow:
      /* Halo inferior con soft spread */
      0 2.5px 6px rgba(0, 229, 195, 0.4),
      inset 0 -2.5px 4px rgba(0, 229, 195, 0.2),

      /* Specular reducido */
      inset 0 1px 1px 0 rgba(255, 255, 255, 0.06),

      /* Rimlight presente */
      inset -1px -1px 2px rgba(0, 229, 195, 0.18),

      /* Viñeta */
      inset 0 0 20px rgba(0, 0, 0, 0.08);

    /* Animación: pressed 80-120ms */
    transition-duration: 100ms;
  }

  /* Difusor aumenta 8-12% */
  .premium-button:active:not(.disabled) .button-diffuser {
    opacity: 1.1;
  }

  /* ========================================
     Estado: Focus
     ======================================== */
  .premium-button:focus-visible {
    outline: none;

    /* Anillo 2px #00E5C3 + 1px #EAF1FC */
    box-shadow:
      /* Inner ring: 1px #EAF1FC */
      0 0 0 2px #EAF1FC,
      /* Outer ring: 2px #00E5C3 */
      0 0 0 4px #00E5C3,
      /* Soft glow */
      0 0 16px rgba(0, 229, 195, 0.4),

      /* Mantener otras sombras */
      inset 0 1px 1.5px 0 rgba(255, 255, 255, 0.08),
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.12),
      0 4px 12px rgba(0, 0, 0, 0.12);
  }

  /* ========================================
     Estado: Disabled
     ======================================== */
  .premium-button.disabled {
    cursor: not-allowed;
    opacity: 0.5;

    /* Texto #A0A5BE */
    color: #A0A5BE;

    /* Desaturar realces */
    filter: saturate(0.4);

    /* Sin rimlight */
    box-shadow:
      inset 0 1px 1px 0 rgba(255, 255, 255, 0.04),
      0 2px 6px rgba(0, 0, 0, 0.08),
      inset 0 0 20px rgba(0, 0, 0, 0.06);
  }

  .premium-button.disabled .button-core {
    opacity: 0;
    animation: none;
  }

  /* ========================================
     Variante: Primary (default con acento)
     ======================================== */
  .premium-button.variant-primary {
    /* Ya configurado en base */
  }

  .premium-button.variant-primary:hover:not(.disabled) {
    /* Background más luminoso */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.88) 0%,
      rgba(26, 31, 36, 0.88) 50%,
      rgba(18, 22, 27, 0.88) 100%
    );
  }

  /* ========================================
     Variante: Secondary (menos prominente)
     ======================================== */
  .premium-button.variant-secondary {
    background: linear-gradient(168deg,
      rgba(45, 51, 60, 0.7) 0%,
      rgba(31, 36, 42, 0.7) 100%
    );

    border-color: rgba(160, 165, 190, 0.12);
  }

  .premium-button.variant-secondary:hover:not(.disabled) {
    background: linear-gradient(168deg,
      rgba(45, 51, 60, 0.85) 0%,
      rgba(31, 36, 42, 0.85) 100%
    );
  }

  /* ========================================
     Variante: Ghost (solo outline)
     ======================================== */
  .premium-button.variant-ghost {
    background: transparent;
    backdrop-filter: none;
    -webkit-backdrop-filter: none;
    border-color: rgba(160, 165, 190, 0.3);

    box-shadow:
      inset 0 0 0 1px rgba(160, 165, 190, 0.2),
      0 2px 6px rgba(0, 0, 0, 0.06);
  }

  .premium-button.variant-ghost:hover:not(.disabled) {
    background: rgba(31, 36, 42, 0.4);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border-color: rgba(0, 229, 195, 0.4);
  }

  /* ========================================
     Responsive: Mobile Performance
     ======================================== */
  @media (max-width: 768px) {
    .premium-button {
      /* Backdrop-filter reducido en móviles */
      backdrop-filter: blur(14px) saturate(120%);
      -webkit-backdrop-filter: blur(14px) saturate(120%);
    }

    /* Desactivar breathing en mobile */
    .button-core {
      animation: none;
    }
  }

  /* ========================================
     Prefers-Reduced-Motion
     ======================================== */
  @media (prefers-reduced-motion: reduce) {
    .premium-button,
    .button-diffuser,
    .button-core {
      transition: none !important;
      animation: none !important;
    }

    .premium-button:hover:not(.disabled),
    .premium-button:active:not(.disabled) {
      transform: none !important;
    }
  }

  /* ========================================
     High Contrast Mode
     ======================================== */
  @media (prefers-contrast: high) {
    .premium-button {
      border-width: 2px;
      border-color: currentColor;
    }
  }

  /* ========================================
     Dark Mode Adjustments
     ======================================== */
  @media (prefers-color-scheme: light) {
    .premium-button {
      background: linear-gradient(168deg,
        rgba(255, 255, 255, 0.9) 0%,
        rgba(240, 240, 245, 0.9) 100%
      );
      color: #1F242A;
      border-color: rgba(31, 36, 42, 0.15);
    }

    .premium-button:hover:not(.disabled) {
      color: #12161B;
    }
  }
</style>
