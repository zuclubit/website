<script>
  /**
   * ProfileCard.svelte
   * Ultra-Refined Luminous Glass-Profile Card — Cuervo 2025 Futuristic Design
   *
   * Dual-chamber frosted glass aesthetic harmonized with Zuclubit glass-metal system.
   * Embodies AI precision merged with human elegance.
   *
   * @component
   */

  import { onMount } from 'svelte';

  // Props API
  export let avatar = '';              // Avatar image URL
  export let name = '';                // Person name (20-22px bold)
  export let role = '';                // Role/subtitle (15-16px regular)
  export let skills = [];              // Array of 2 skill tags
  export let rating = '5.0';           // Rating score
  export let earned = '$25K+';         // Total earned
  export let rate = '$80/hr';          // Hourly rate
  export let ctaText = 'Get in Touch'; // Primary CTA
  export let ctaHref = '#contact';     // CTA link
  export let theme = 'dark';           // 'light' | 'dark'
  export let onBookmark = null;        // Bookmark callback

  let isHovering = false;
  let isActive = false;

  // Handle bookmark action
  function handleBookmark(e) {
    e.preventDefault();
    if (onBookmark) {
      onBookmark();
    }
  }
</script>

<!-- Profile Card Container -->
<article
  class="profile-card"
  class:theme-light={theme === 'light'}
  class:theme-dark={theme === 'dark'}
  class:hovering={isHovering}
  on:mouseenter={() => (isHovering = true)}
  on:mouseleave={() => (isHovering = false)}
>
  <!-- Specular Reflection Line (Top-Left) -->
  <div class="specular-line" aria-hidden="true"></div>

  <!-- Inner Matte Diffuser Layer -->
  <div class="card-diffuser" aria-hidden="true"></div>

  <!-- Card Content -->
  <div class="card-content">

    <!-- Top Section: Avatar + Bookmark -->
    <div class="card-header">
      <!-- Circular Avatar with Glass Rimlight -->
      <div class="avatar-container">
        <div class="avatar-rimlight" aria-hidden="true"></div>
        <img src={avatar} alt={`${name} avatar`} class="avatar-image" />
      </div>

      <!-- Bookmark/Share Action (Glass Bubble) -->
      <button
        class="action-bubble"
        aria-label="Bookmark profile"
        on:click={handleBookmark}
      >
        <svg
          width="18"
          height="18"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z" />
        </svg>
      </button>
    </div>

    <!-- Name + Role -->
    <div class="identity-section">
      <h3 class="profile-name">{name}</h3>
      <p class="profile-role">{role}</p>
    </div>

    <!-- Skill Tags (Pill-Style Frosted Glass) -->
    {#if skills.length > 0}
      <div class="skills-container">
        {#each skills.slice(0, 2) as skill}
          <span class="skill-tag">{skill}</span>
        {/each}
      </div>
    {/if}

    <!-- Statistics Blocks (Rating / Earned / Rate) -->
    <div class="stats-grid">
      <div class="stat-block">
        <div class="stat-value">{rating}</div>
        <div class="stat-label">Rating</div>
      </div>
      <div class="stat-divider" aria-hidden="true"></div>
      <div class="stat-block">
        <div class="stat-value">{earned}</div>
        <div class="stat-label">Earned</div>
      </div>
      <div class="stat-divider" aria-hidden="true"></div>
      <div class="stat-block">
        <div class="stat-value">{rate}</div>
        <div class="stat-label">Rate</div>
      </div>
    </div>

    <!-- Primary CTA Button (Glass Capsule) -->
    <a
      href={ctaHref}
      class="cta-button"
      on:mousedown={() => (isActive = true)}
      on:mouseup={() => (isActive = false)}
      on:mouseleave={() => (isActive = false)}
    >
      {ctaText}
    </a>

  </div>
</article>

<style>
  /* ========================================
     PROFILE CARD — ULTRA-REFINED GLASS
     Cuervo 2025 Futuristic Design Language
     ======================================== */

  /* Design Tokens — Luminous Glass System */
  :root {
    /* Dual-Chamber Glass Material */
    --card-blur: 20px;           /* 16-20px frosted glass */
    --card-opacity: 0.80;        /* 78-82% opacity */
    --card-sat: 115%;            /* Saturation boost */

    /* Border & Glow */
    --card-border: 1px solid rgba(255, 255, 255, 0.12);
    --card-glow: rgba(199, 209, 246, 0.08);  /* #C7D1F6 inner glow */
    --card-radius: 24px;         /* 20-26px range */

    /* Typography Premium */
    --name-size: 21px;           /* 20-22px bold */
    --role-size: 15px;           /* 15-16px regular */
    --tag-size: 14px;            /* 14px semibold */
    --stat-value-size: 20px;     /* 18-20px bold */
    --stat-label-size: 13px;     /* 12-13px regular */

    /* Spacing */
    --card-padding: 28px;
    --section-gap: 20px;

    /* Motion */
    --card-ease: cubic-bezier(0.2, 0.8, 0.2, 1);
    --card-duration: 300ms;
  }

  /* Main Card Container — Dual-Chamber Frosted Glass */
  .profile-card {
    position: relative;
    overflow: hidden;

    /* Flexible container */
    display: flex;
    flex-direction: column;

    /* Dimensions */
    width: 100%;
    max-width: 380px;
    padding: var(--card-padding);

    /* Border */
    border: var(--card-border);
    border-radius: var(--card-radius);

    /* Translucent Upper Shell with Backdrop Filter */
    backdrop-filter: blur(var(--card-blur)) saturate(var(--card-sat));
    -webkit-backdrop-filter: blur(var(--card-blur)) saturate(var(--card-sat));

    /* Shadow: Cinematic Depth */
    box-shadow:
      /* Main elevation shadow */
      0 8px 28px rgba(0, 0, 0, 0.12),
      0 4px 12px rgba(0, 0, 0, 0.08),

      /* Inner glow (#C7D1F6) */
      inset 0 0 0 1px var(--card-glow),

      /* Ambient occlusion underside */
      inset 0 -2px 4px rgba(0, 0, 0, 0.06);

    /* Smooth transitions */
    transition:
      transform var(--card-duration) var(--card-ease),
      box-shadow var(--card-duration) var(--card-ease),
      border-color var(--card-duration) var(--card-ease);

    /* GPU acceleration */
    will-change: transform, box-shadow;
  }

  /* Theme: Dark Mode (Default) */
  .profile-card.theme-dark {
    /* Base gradient: #1F242A → #2D333C */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.82) 0%,
      rgba(45, 51, 60, 0.82) 100%
    );
  }

  /* Theme: Light Mode */
  .profile-card.theme-light {
    /* Base gradient: #EAF1FC → #C7E8F3 */
    background: linear-gradient(168deg,
      rgba(234, 241, 252, 0.85) 0%,
      rgba(199, 232, 243, 0.85) 100%
    );

    /* Light mode border */
    border-color: rgba(255, 255, 255, 0.35);

    /* Light mode shadow (reduced) */
    box-shadow:
      0 8px 28px rgba(0, 0, 0, 0.08),
      0 4px 12px rgba(0, 0, 0, 0.04),
      inset 0 0 0 1px rgba(199, 209, 246, 0.15),
      inset 0 -2px 4px rgba(0, 0, 0, 0.03);
  }

  /* Hover State — Subtle Turquoise Rimlight + Scale */
  .profile-card:hover {
    transform: scale(1.02);

    /* Enhanced elevation */
    box-shadow:
      /* Main shadow increased */
      0 12px 38px rgba(0, 0, 0, 0.16),
      0 6px 16px rgba(0, 0, 0, 0.12),

      /* Turquoise rimlight #00E5C3 */
      0 0 0 1px rgba(0, 229, 195, 0.20),
      0 0 16px rgba(0, 229, 195, 0.12),

      /* Inner glow enhanced */
      inset 0 0 0 1px rgba(199, 209, 246, 0.15),

      /* AO */
      inset 0 -2px 4px rgba(0, 0, 0, 0.08);
  }

  .profile-card.theme-light:hover {
    /* Light mode hover: subtle rimlight */
    box-shadow:
      0 12px 38px rgba(0, 0, 0, 0.10),
      0 6px 16px rgba(0, 0, 0, 0.06),
      0 0 0 1px rgba(0, 229, 195, 0.30),
      0 0 20px rgba(0, 229, 195, 0.15),
      inset 0 0 0 1px rgba(199, 209, 246, 0.25),
      inset 0 -2px 4px rgba(0, 0, 0, 0.04);
  }

  /* Specular Reflection Line (Top-Left Metal-Glass Effect) */
  .specular-line {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;

    height: 2px;

    /* Soft reflection gradient */
    background: linear-gradient(90deg,
      transparent 0%,
      rgba(255, 255, 255, 0.25) 30%,
      rgba(255, 255, 255, 0.15) 60%,
      transparent 100%
    );

    border-radius: var(--card-radius) var(--card-radius) 0 0;
    pointer-events: none;
    z-index: 2;
  }

  /* Inner Matte Diffuser Layer */
  .card-diffuser {
    position: absolute;
    inset: 0;

    /* Radial gradient diffuser with turquoise tint */
    background: radial-gradient(
      ellipse at 50% 0%,
      rgba(199, 209, 246, 0.04) 0%,
      rgba(199, 209, 246, 0.02) 50%,
      rgba(0, 229, 195, 0.02) 100%
    );

    border-radius: var(--card-radius);
    pointer-events: none;
    z-index: 0;
  }

  .profile-card.theme-light .card-diffuser {
    /* Light mode: softer diffuser */
    background: radial-gradient(
      ellipse at 50% 0%,
      rgba(199, 209, 246, 0.08) 0%,
      rgba(199, 232, 243, 0.04) 50%,
      rgba(0, 229, 195, 0.02) 100%
    );
  }

  /* Card Content Container */
  .card-content {
    position: relative;
    z-index: 1;

    display: flex;
    flex-direction: column;
    gap: var(--section-gap);
  }

  /* ========================================
     HEADER: Avatar + Bookmark
     ======================================== */

  .card-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
  }

  /* Avatar Container (Circular with Glass Rimlight) */
  .avatar-container {
    position: relative;
    width: 84px;
    height: 84px;
  }

  /* Avatar Rimlight (Turquoise Glow) */
  .avatar-rimlight {
    position: absolute;
    inset: -4px;

    /* Circular gradient border */
    background: conic-gradient(
      from 180deg,
      rgba(0, 229, 195, 0.4) 0deg,
      rgba(0, 207, 255, 0.3) 90deg,
      rgba(0, 229, 195, 0.4) 180deg,
      rgba(0, 207, 255, 0.3) 270deg,
      rgba(0, 229, 195, 0.4) 360deg
    );

    border-radius: 50%;
    opacity: 0.6;

    /* Glow effect */
    filter: blur(6px);

    transition: opacity var(--card-duration) var(--card-ease);
  }

  .profile-card:hover .avatar-rimlight {
    opacity: 1;
    filter: blur(8px);
  }

  /* Avatar Image */
  .avatar-image {
    position: relative;
    z-index: 1;

    width: 84px;
    height: 84px;

    object-fit: cover;
    border-radius: 50%;

    /* Inner glass border */
    border: 2px solid rgba(255, 255, 255, 0.15);

    /* Subtle shadow */
    box-shadow:
      0 4px 12px rgba(0, 0, 0, 0.15),
      inset 0 0 0 1px rgba(255, 255, 255, 0.08);
  }

  .profile-card.theme-light .avatar-image {
    border-color: rgba(255, 255, 255, 0.45);
  }

  /* Action Bubble (Bookmark/Share) */
  .action-bubble {
    display: flex;
    align-items: center;
    justify-content: center;

    width: 42px;
    height: 42px;

    /* Raised glass bubble */
    background: rgba(31, 36, 42, 0.60);
    backdrop-filter: blur(12px) saturate(120%);
    -webkit-backdrop-filter: blur(12px) saturate(120%);

    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 50%;

    /* Icon color */
    color: #C7D1F6;

    /* Bubble shadow */
    box-shadow:
      0 4px 12px rgba(0, 0, 0, 0.12),
      inset 0 1px 2px rgba(255, 255, 255, 0.08);

    cursor: pointer;
    transition: all var(--card-duration) var(--card-ease);
  }

  .profile-card.theme-light .action-bubble {
    background: rgba(234, 241, 252, 0.70);
    color: #1F242A;
    border-color: rgba(255, 255, 255, 0.35);
  }

  .action-bubble:hover {
    background: rgba(31, 36, 42, 0.80);
    color: #EAF1FC;

    /* Turquoise glow */
    box-shadow:
      0 0 8px rgba(0, 229, 195, 0.30),
      0 4px 16px rgba(0, 0, 0, 0.16),
      inset 0 1px 2px rgba(255, 255, 255, 0.12);

    transform: scale(1.05);
  }

  .profile-card.theme-light .action-bubble:hover {
    background: rgba(234, 241, 252, 0.90);
    color: #00E5C3;
    border-color: rgba(0, 229, 195, 0.40);
  }

  .action-bubble:active {
    transform: scale(0.95);
  }

  /* ========================================
     IDENTITY: Name + Role
     ======================================== */

  .identity-section {
    display: flex;
    flex-direction: column;
    gap: 6px;
  }

  /* Name (Bold, High Contrast) */
  .profile-name {
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: var(--name-size);
    font-weight: 700;
    letter-spacing: -0.015em;
    line-height: 1.2;

    color: #EAF1FC;  /* High contrast */
    margin: 0;
  }

  .profile-card.theme-light .profile-name {
    color: #1A1F24;  /* Dark text on light */
  }

  /* Role (Light Weight, Desaturated) */
  .profile-role {
    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: var(--role-size);
    font-weight: 400;
    letter-spacing: -0.005em;
    line-height: 1.4;

    color: #A0A5BE;  /* Desaturated */
    margin: 0;
  }

  .profile-card.theme-light .profile-role {
    color: #797E95;  /* Muted on light */
  }

  /* ========================================
     SKILL TAGS (Pill-Style Frosted Glass)
     ======================================== */

  .skills-container {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .skill-tag {
    display: inline-flex;
    align-items: center;

    padding: 7px 14px;

    /* Pill-style frosted glass */
    background: rgba(31, 36, 42, 0.65);
    backdrop-filter: blur(10px) saturate(120%);
    -webkit-backdrop-filter: blur(10px) saturate(120%);

    /* Frosted border */
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-radius: 14px;

    /* Typography */
    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: var(--tag-size);
    font-weight: 600;
    letter-spacing: 0.005em;

    color: #C7D1F6;

    /* Soft shadow */
    box-shadow:
      0 2px 6px rgba(0, 0, 0, 0.10),
      inset 0 1px 1px rgba(255, 255, 255, 0.08);

    transition: all 200ms var(--card-ease);
  }

  .profile-card.theme-light .skill-tag {
    background: rgba(234, 241, 252, 0.75);
    color: #1F242A;
    border-color: rgba(255, 255, 255, 0.40);
  }

  .skill-tag:hover {
    background: rgba(31, 36, 42, 0.80);
    border-color: rgba(0, 229, 195, 0.35);
    color: #EAF1FC;

    /* Turquoise glow */
    box-shadow:
      0 0 8px rgba(0, 229, 195, 0.25),
      0 2px 8px rgba(0, 0, 0, 0.14),
      inset 0 1px 1px rgba(255, 255, 255, 0.12);
  }

  .profile-card.theme-light .skill-tag:hover {
    background: rgba(234, 241, 252, 0.95);
    color: #00E5C3;
    border-color: rgba(0, 229, 195, 0.50);
  }

  /* ========================================
     STATISTICS BLOCKS (Rating / Earned / Rate)
     ======================================== */

  .stats-grid {
    display: grid;
    grid-template-columns: 1fr auto 1fr auto 1fr;
    align-items: center;
    gap: 16px;

    padding: 18px 0;
  }

  .stat-block {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
  }

  /* Stat Value (Bold, Prominent) */
  .stat-value {
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: var(--stat-value-size);
    font-weight: 700;
    letter-spacing: -0.01em;

    color: #EAF1FC;
  }

  .profile-card.theme-light .stat-value {
    color: #1A1F24;
  }

  /* Stat Label (Small, Desaturated) */
  .stat-label {
    font-family: Inter, 'SF Pro Text', -apple-system, system-ui, sans-serif;
    font-size: var(--stat-label-size);
    font-weight: 500;
    letter-spacing: 0.01em;
    text-transform: uppercase;

    color: #797E95;
  }

  .profile-card.theme-light .stat-label {
    color: #A0A5BE;
  }

  /* Stat Divider (Faint Translucent) */
  .stat-divider {
    width: 1px;
    height: 40px;

    background: linear-gradient(180deg,
      transparent 0%,
      rgba(255, 255, 255, 0.12) 50%,
      transparent 100%
    );
  }

  .profile-card.theme-light .stat-divider {
    background: linear-gradient(180deg,
      transparent 0%,
      rgba(0, 0, 0, 0.10) 50%,
      transparent 100%
    );
  }

  /* ========================================
     PRIMARY CTA BUTTON (Glass Capsule)
     ======================================== */

  .cta-button {
    display: flex;
    align-items: center;
    justify-content: center;

    padding: 15px 28px;

    /* Glass capsule with inner luminous rim */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.80) 0%,
      rgba(18, 22, 27, 0.80) 100%
    );
    backdrop-filter: blur(18px) saturate(120%);
    -webkit-backdrop-filter: blur(18px) saturate(120%);

    /* Inner luminous rim */
    border: 1px solid rgba(199, 209, 246, 0.20);
    border-radius: 16px;

    /* Typography */
    font-family: Inter, 'SF Pro Display', -apple-system, system-ui, sans-serif;
    font-size: 16px;
    font-weight: 600;
    letter-spacing: -0.003em;

    color: #EAF1FC;
    text-decoration: none;

    /* Soft shadow + inner glow */
    box-shadow:
      /* Elevation */
      0 4px 12px rgba(0, 0, 0, 0.16),
      0 2px 6px rgba(0, 0, 0, 0.12),

      /* Inner luminous rim */
      inset 0 0 0 1px rgba(199, 209, 246, 0.08),

      /* Specular highlight top */
      inset 0 1px 2px rgba(255, 255, 255, 0.10);

    cursor: pointer;
    transition: all 250ms var(--card-ease);
  }

  .profile-card.theme-light .cta-button {
    background: linear-gradient(168deg,
      rgba(234, 241, 252, 0.85) 0%,
      rgba(199, 232, 243, 0.85) 100%
    );
    color: #1F242A;
    border-color: rgba(255, 255, 255, 0.40);
  }

  /* Hover: Expansion + Turquoise Rimlight */
  .cta-button:hover {
    /* Soft expansion */
    transform: scale(1.03);

    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.90) 0%,
      rgba(18, 22, 27, 0.90) 100%
    );

    /* Turquoise rimlight */
    border-color: rgba(0, 229, 195, 0.40);

    /* Enhanced glow */
    box-shadow:
      /* Turquoise perimeter glow */
      0 0 16px rgba(0, 229, 195, 0.20),
      0 0 32px rgba(0, 229, 195, 0.10),

      /* Elevation increased */
      0 6px 18px rgba(0, 0, 0, 0.20),
      0 3px 9px rgba(0, 0, 0, 0.16),

      /* Inner rim brightened */
      inset 0 0 0 1px rgba(199, 209, 246, 0.15),
      inset 0 1px 2px rgba(255, 255, 255, 0.15);
  }

  .profile-card.theme-light .cta-button:hover {
    background: linear-gradient(168deg,
      rgba(234, 241, 252, 0.95) 0%,
      rgba(199, 232, 243, 0.95) 100%
    );
    color: #00E5C3;
    border-color: rgba(0, 229, 195, 0.60);
  }

  /* Active: Compress + Internal Glow Pulse */
  .cta-button:active {
    transform: scale(0.985);

    /* Internal glow pulse effect */
    box-shadow:
      /* Reduced elevation */
      0 2px 8px rgba(0, 0, 0, 0.14),

      /* Pulsing inner glow */
      inset 0 0 16px rgba(0, 229, 195, 0.25),
      inset 0 0 0 1px rgba(0, 229, 195, 0.30);
  }

  /* Focus State (Keyboard) */
  .cta-button:focus-visible {
    outline: none;

    /* Turquoise focus ring */
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
      --card-padding: 22px;
      --section-gap: 16px;
      --name-size: 19px;
      --role-size: 14px;
      --stat-value-size: 18px;
    }

    .profile-card {
      max-width: 100%;
    }

    .avatar-container,
    .avatar-image {
      width: 72px;
      height: 72px;
    }

    .avatar-rimlight {
      inset: -3px;
    }

    .action-bubble {
      width: 38px;
      height: 38px;
    }

    .stats-grid {
      gap: 12px;
      padding: 14px 0;
    }

    .stat-divider {
      height: 32px;
    }

    .cta-button {
      padding: 13px 24px;
      font-size: 15px;
    }
  }

  /* ========================================
     ACCESSIBILITY
     ======================================== */

  /* Reduced Motion */
  @media (prefers-reduced-motion: reduce) {
    .profile-card,
    .avatar-rimlight,
    .action-bubble,
    .skill-tag,
    .cta-button {
      transition: none;
    }

    .profile-card:hover {
      transform: none;
    }

    .cta-button:hover {
      transform: none;
    }

    .action-bubble:hover {
      transform: none;
    }
  }

  /* High Contrast Mode */
  @media (prefers-contrast: high) {
    .profile-card {
      border: 2px solid #FFFFFF;
    }

    .profile-name,
    .stat-value {
      color: #FFFFFF;
    }

    .skill-tag,
    .cta-button {
      border-width: 2px;
    }
  }
</style>
