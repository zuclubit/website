<!--
  PremiumLogo Component

  Componente reutilizable para el logo con tratamiento premium:
  - 7 capas de rendering (border gradient, outer glow, inner bevel, backdrop-filter, etc.)
  - Gradient background turquesa animado
  - Specular highlight premium
  - Hover state con scale y elevation

  @component
  @example
  <PremiumLogo
    size="50px"
    alt="Zuclubit Logo"
    ariaLabel="Zuclubit Home"
  />
-->

<script>
  import logo from '../../img/logo-zuclubit.png';

  /**
   * Tamaño del logo (width y height)
   * @type {string}
   * @default "50px"
   */
  export let size = '50px';

  /**
   * Texto alternativo para accesibilidad
   * @type {string}
   * @default "Zuclubit"
   */
  export let alt = 'Zuclubit';

  /**
   * Label ARIA para el enlace parent (si se usa)
   * @type {string}
   * @default ""
   */
  export let ariaLabel = '';

  /**
   * URL de destino del enlace
   * @type {string | null}
   * @default null (sin enlace)
   */
  export let href = null;

  /**
   * Clases CSS adicionales
   * @type {string}
   * @default ""
   */
  let className = '';
  export { className as class };

  // Validación de props
  $: validSize = size || '50px';
  $: validAlt = alt || 'Zuclubit';
</script>

{#if href}
  <a
    {href}
    class="premium-logo-link {className}"
    aria-label={ariaLabel || validAlt}
  >
    <img
      src={logo}
      alt={validAlt}
      class="premium-logo"
      style="--logo-size: {validSize}"
    />
  </a>
{:else}
  <img
    src={logo}
    alt={validAlt}
    class="premium-logo {className}"
    style="--logo-size: {validSize}"
  />
{/if}

<style>
  /* Link wrapper (opcional) */
  .premium-logo-link {
    display: flex;
    align-items: center;
    text-decoration: none;
    flex-shrink: 0; /* Evita que el logo se encoja en flex container */
  }

  /* Premium Logo - 100% Homologado al Footer */
  .premium-logo {
    /* Dimensiones configurables via CSS variable */
    width: var(--logo-size, 50px);
    height: var(--logo-size, 50px);
    object-fit: contain;
    border-radius: 50%;
    padding: 3px;
    position: relative;
    display: block; /* Asegurar que se muestre correctamente */
    flex-shrink: 0; /* Evita que el logo se encoja */

    /* Gradient background turquesa premium */
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.15) 0%, rgba(0, 229, 195, 0.15) 100%);

    /* Backdrop-filter premium (vidrio frosted) */
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);

    /* Box-shadow premium multi-capa */
    box-shadow:
      /* Outer glow turquesa - Capa 1 (32px blur) */
      0 8px 32px rgba(0, 207, 255, 0.25),
      /* Outer glow turquesa - Capa 2 (8px blur) */
      0 2px 8px rgba(0, 229, 195, 0.2),
      /* Inner bevel - Top highlight */
      inset 0 1px 2px rgba(255, 255, 255, 0.1),
      /* Inner bevel - Bottom shadow */
      inset 0 -1px 2px rgba(0, 0, 0, 0.1);

    /* Transition premium con cubic-bezier */
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);

    /* Border handling para ::before gradient */
    border: 1px solid transparent;
    background-clip: padding-box;
  }

  /* Border gradient turquesa animado (z-index -1) */
  .premium-logo::before {
    content: '';
    position: absolute;
    top: -1px;
    left: -1px;
    right: -1px;
    bottom: -1px;
    border-radius: 50%;

    /* Gradient turquesa con punto medio verde */
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 50%, #00cfff 100%);

    z-index: -1;
    opacity: 0.6;
    transition: opacity 0.4s ease;
  }

  /* Specular highlight premium (luz natural) */
  .premium-logo::after {
    content: '';
    position: absolute;
    top: 10%;
    left: 10%;
    width: 30%;
    height: 30%;
    border-radius: 50%;

    /* Radial gradient blanco con blur */
    background: radial-gradient(
      circle at center,
      rgba(255, 255, 255, 0.3) 0%,
      transparent 70%
    );

    filter: blur(4px);
    pointer-events: none; /* No interfiere con clicks */
  }

  /* Hover state premium - Intensificación de todos los efectos */
  .premium-logo:hover {
    /* Gradient background más intenso (15% → 25%) */
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.25) 0%, rgba(0, 229, 195, 0.25) 100%);

    /* Box-shadow aumentado */
    box-shadow:
      /* Outer glow expandido (32px → 48px, 25% → 35%) */
      0 12px 48px rgba(0, 207, 255, 0.35),
      /* Outer glow secundario (8px → 16px, 20% → 30%) */
      0 4px 16px rgba(0, 229, 195, 0.3),
      /* Inner bevel aumentado (2px → 4px, 10% → 15%) */
      inset 0 2px 4px rgba(255, 255, 255, 0.15),
      inset 0 -2px 4px rgba(0, 0, 0, 0.15);

    /* Transform: scale 5% + elevación -2px */
    transform: scale(1.05) translateY(-2px);

    /* Backdrop-filter aumentado (20px → 25px, 180% → 200%) */
    backdrop-filter: blur(25px) saturate(200%);
    -webkit-backdrop-filter: blur(25px) saturate(200%);
  }

  /* Border gradient más intenso en hover (0.6 → 0.9) */
  .premium-logo:hover::before {
    opacity: 0.9;
  }

  /* Soporte para enlaces: aplicar hover al img cuando hover en link */
  .premium-logo-link:hover .premium-logo {
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.25) 0%, rgba(0, 229, 195, 0.25) 100%);
    box-shadow:
      0 12px 48px rgba(0, 207, 255, 0.35),
      0 4px 16px rgba(0, 229, 195, 0.3),
      inset 0 2px 4px rgba(255, 255, 255, 0.15),
      inset 0 -2px 4px rgba(0, 0, 0, 0.15);
    transform: scale(1.05) translateY(-2px);
    backdrop-filter: blur(25px) saturate(200%);
    -webkit-backdrop-filter: blur(25px) saturate(200%);
  }

  .premium-logo-link:hover .premium-logo::before {
    opacity: 0.9;
  }

  /* Focus state para accesibilidad */
  .premium-logo:focus,
  .premium-logo-link:focus {
    outline: 2px solid #00E5C3;
    outline-offset: 2px;
  }

  /* Responsive: Reducir efectos en móviles para performance */
  @media (max-width: 768px) {
    .premium-logo {
      /* Backdrop-filter reducido en móviles */
      backdrop-filter: blur(15px) saturate(160%);
      -webkit-backdrop-filter: blur(15px) saturate(160%);
    }

    .premium-logo:hover {
      /* Hover menos intenso en móviles (touch devices) */
      backdrop-filter: blur(18px) saturate(180%);
      -webkit-backdrop-filter: blur(18px) saturate(180%);
    }
  }

  /* Prefers-reduced-motion: Desactivar animaciones */
  @media (prefers-reduced-motion: reduce) {
    .premium-logo,
    .premium-logo::before,
    .premium-logo::after {
      transition: none;
      animation: none;
    }

    .premium-logo:hover {
      transform: none; /* No scale ni translateY */
    }
  }

  /* Dark mode: Ajustar opacidades si es necesario */
  @media (prefers-color-scheme: light) {
    .premium-logo {
      /* Aumentar contraste en light mode */
      box-shadow:
        0 8px 32px rgba(0, 207, 255, 0.3),
        0 2px 8px rgba(0, 229, 195, 0.25),
        inset 0 1px 2px rgba(255, 255, 255, 0.15),
        inset 0 -1px 2px rgba(0, 0, 0, 0.15);
    }
  }
</style>
