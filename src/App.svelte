<script>
  import { fade, fly } from 'svelte/transition';
  import {
    Building2,
    Settings,
    Brain,
    Cloud,
    Shield,
    TrendingUp,
    ShieldCheck,
    Lock,
    Target,
    ClipboardCheck,
    CheckCircle2,
    Check,
    Menu,
    X,
    ArrowRight,
    Home,
    Plus,
    User,
    Mail,
  } from 'lucide-svelte';

  import logo from '../img/logo-zuclubit.png';
  import ContactForm from './components/sections/ContactForm.svelte';

  let mobileMenuOpen = false;
  let activeService = null;

  // Services data
  const services = [
    {
      id: 'architecture',
      icon: Building2,
      title: 'Architecture & Design',
      description:
        'Software, data, infrastructure, integration, and security architecture for enterprise systems.',
      tags: ['Microservices', 'Cloud Native', 'Event-Driven'],
    },
    {
      id: 'devops',
      icon: Settings,
      title: 'DevOps & Operations',
      description:
        'DevOps, SecOps, MLOps, DataOps, FinOps, and AIOps implementation with continuous delivery.',
      tags: ['CI/CD', 'IaC', 'Automation'],
    },
    {
      id: 'ai',
      icon: Brain,
      title: 'AI & Machine Learning',
      description:
        'Artificial intelligence, machine learning, data science, and predictive analytics solutions.',
      tags: ['Deep Learning', 'NLP', 'Computer Vision'],
    },
    {
      id: 'cloud',
      icon: Cloud,
      title: 'Cloud Computing',
      description: 'Multi-cloud, hybrid cloud, edge computing architecture and migration services.',
      tags: ['AWS', 'Azure', 'GCP'],
    },
    {
      id: 'security',
      icon: Shield,
      title: 'Cybersecurity',
      description:
        'Security audits, penetration testing, compliance, and threat detection systems.',
      tags: ['Zero Trust', 'SIEM', 'SOC'],
    },
    {
      id: 'transformation',
      icon: TrendingUp,
      title: 'Digital Transformation',
      description:
        'IT consulting, process automation, business intelligence, and enterprise modernization.',
      tags: ['RPA', 'BI/Analytics', 'Legacy Migration'],
    },
  ];

  // Compliance & Standards
  const standards = [
    { name: 'ISO/IEC 27001', icon: ShieldCheck, category: 'Security' },
    { name: 'NIST Framework', icon: Building2, category: 'Cybersecurity' },
    { name: 'OWASP Top 10', icon: Lock, category: 'AppSec' },
    { name: 'ITIL v4', icon: Target, category: 'Service Mgmt' },
    { name: 'COBIT', icon: ClipboardCheck, category: 'IT Governance' },
    { name: 'CIS Benchmarks', icon: CheckCircle2, category: 'Best Practices' },
  ];

  // Expertise Areas
  const expertise = [
    {
      category: 'Development',
      items: ['Software Engineering', 'Full-Stack Development', 'Mobile Apps', 'Embedded Systems'],
    },
    {
      category: 'Infrastructure',
      items: ['Kubernetes', 'Docker', 'Terraform', 'Infrastructure as Code'],
    },
    {
      category: 'Security',
      items: ['Penetration Testing', 'Security Audits', 'Threat Intelligence', 'Incident Response'],
    },
    {
      category: 'Data',
      items: ['Data Architecture', 'Big Data', 'Data Warehousing', 'Real-time Analytics'],
    },
    {
      category: 'IoT & Innovation',
      items: ['IoT Platforms', 'AR/VR', 'Robotics', 'Blockchain'],
    },
  ];

  // Metrics & Achievements
  const metrics = [
    { value: '100+', label: 'Projects Delivered', icon: Target },
    { value: '99.9%', label: 'System Uptime SLA', icon: CheckCircle2 },
    { value: '40%', label: 'Avg. Cost Reduction', icon: TrendingUp },
    { value: '24/7', label: 'Support Coverage', icon: Shield },
  ];

  // Mobile menu state
  // (Contact form logic is now in ContactForm.svelte component)

  function toggleMobileMenu() {
    mobileMenuOpen = !mobileMenuOpen;
  }
</script>

<!-- Navbar -->
<nav class="navbar">
  <div class="container">
    <div class="nav-content">
      <a href="/" class="nav-logo">
        <img src={logo} alt="Zuclubit Logo" class="logo-image" />
      </a>
      <div class="nav-links" class:active={mobileMenuOpen}>
        <a href="#services" on:click={() => (mobileMenuOpen = false)}>Services</a>
        <a href="#expertise" on:click={() => (mobileMenuOpen = false)}>Expertise</a>
        <a href="#standards" on:click={() => (mobileMenuOpen = false)}>Standards</a>
        <a href="#contact" on:click={() => (mobileMenuOpen = false)}>Contact</a>
      </div>
      <button class="mobile-menu-btn" on:click={toggleMobileMenu} aria-label="Toggle menu">
        {#if mobileMenuOpen}
          <X size={24} />
        {:else}
          <Menu size={24} />
        {/if}
      </button>
    </div>
  </div>
</nav>

<!-- Mobile Floating Navbar (Bottom) -->
<nav class="mobile-floating-nav">
  <div class="mobile-nav-pill">
    <a href="/" class="mobile-nav-btn mobile-nav-btn-logo" aria-label="Home">
      <img src={logo} alt="Zuclubit" class="mobile-nav-logo" />
    </a>
    <a href="#expertise" class="mobile-nav-btn" aria-label="Expertise">
      <Target size={20} strokeWidth={2} />
    </a>
    <a href="#standards" class="mobile-nav-btn" aria-label="Standards">
      <ShieldCheck size={20} strokeWidth={2} />
    </a>
    <a href="#contact" class="mobile-nav-btn" aria-label="Contact">
      <Mail size={20} strokeWidth={2} />
    </a>
  </div>
</nav>

<!-- Hero Section -->
<section class="hero">
  <div class="hero-bg"></div>
  <div class="container">
    <div class="hero-content" in:fade={{ duration: 800 }}>
      <div class="brand-section">
        <h1 class="brand-name">ZUCLUBIT</h1>
        <p class="brand-tagline">The Living Code</p>
      </div>
      <h2 class="headline">Technology That Evolves With Purpose</h2>
      <p class="subheadline">
        Complete integration of hardware, software and intelligence for digital transformation and
        sustainable innovation.
      </p>
      <div class="cta-group">
        <a href="#contact" class="btn btn-primary btn-large">Start Your Transformation →</a>
        <a href="#services" class="btn btn-secondary btn-large">Explore Services ↓</a>
      </div>
    </div>
  </div>
</section>

<!-- Services Section -->
<section id="services" class="services">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Comprehensive Technology Services</h2>
      <p class="section-subtitle">End-to-end solutions covering the full technology lifecycle</p>
    </div>
    <div class="services-grid">
      {#each services as service, i}
        <div
          class="service-card"
          class:active={activeService === service.id}
          in:fly={{ y: 50, delay: i * 100, duration: 600 }}
          on:mouseenter={() => (activeService = service.id)}
          on:mouseleave={() => (activeService = null)}
          role="button"
          tabindex="0"
        >
          <div class="service-icon">
            <svelte:component this={service.icon} size={48} strokeWidth={1.5} />
          </div>
          <h3 class="service-title">{service.title}</h3>
          <p class="service-description">{service.description}</p>
          <div class="service-tags">
            {#each service.tags as tag}
              <span class="tag">{tag}</span>
            {/each}
          </div>
          <div class="service-cta-container">
            <a href="#contact" class="service-cta">
              Learn More <ArrowRight size={16} />
            </a>
          </div>
        </div>
      {/each}
    </div>
  </div>
</section>

<!-- Expertise Section -->
<section id="expertise" class="expertise">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Deep Technical Expertise</h2>
      <p class="section-subtitle">Specialized knowledge across modern technology stacks</p>
    </div>
    <div class="expertise-grid">
      {#each expertise as area}
        <div class="expertise-area">
          <h3 class="expertise-category">{area.category}</h3>
          <ul class="expertise-list">
            {#each area.items as item}
              <li>{item}</li>
            {/each}
          </ul>
        </div>
      {/each}
    </div>
    <div class="section-cta">
      <p class="section-cta-text">Need specialized expertise for your project?</p>
      <a href="#contact" class="btn btn-primary">Discuss Your Needs →</a>
    </div>
  </div>
</section>

<!-- Standards & Compliance Section -->
<section id="standards" class="standards">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Standards & Compliance</h2>
      <p class="section-subtitle">Certified expertise in industry-leading frameworks</p>
    </div>
    <div class="standards-grid">
      {#each standards as standard}
        <div class="standard-card">
          <div class="standard-icon">
            <svelte:component this={standard.icon} size={40} strokeWidth={1.5} />
          </div>
          <div class="standard-name">{standard.name}</div>
          <div class="standard-category">{standard.category}</div>
        </div>
      {/each}
    </div>
    <div class="section-cta">
      <p class="section-cta-text">Ready to ensure compliance and security?</p>
      <a href="#contact" class="btn btn-primary">Get a Compliance Audit →</a>
    </div>
  </div>
</section>

<!-- Metrics Section -->
<section class="metrics">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Proven Track Record</h2>
      <p class="section-subtitle">
        Measurable results that demonstrate our commitment to excellence
      </p>
    </div>
    <div class="metrics-grid">
      {#each metrics as metric, i}
        <div class="metric-card" in:fly={{ y: 30, delay: i * 100, duration: 600 }}>
          <div class="metric-icon">
            <svelte:component this={metric.icon} size={40} strokeWidth={1.5} />
          </div>
          <div class="metric-value">{metric.value}</div>
          <div class="metric-label">{metric.label}</div>
        </div>
      {/each}
    </div>
  </div>
</section>

<!-- Contact Section -->
<section id="contact" class="contact">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Let's Build Something Great</h2>
      <p class="section-subtitle">Ready to transform your technology infrastructure? Let's talk.</p>
    </div>
    <div class="contact-container">
      <div class="contact-info">
        <h3>Why Choose Zuclubit?</h3>
        <ul class="benefits-list">
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>Complete technology integration from architecture to automation</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>Expertise across DevOps, Cloud, AI/ML, and Cybersecurity</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>ISO 27001, NIST, OWASP, and ITIL frameworks implementation</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>End-to-end solutions: research, design, integration & support</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>Focus on sustainable innovation and digital transformation</span>
          </li>
        </ul>
      </div>
      <!-- Modern Contact Form Component -->
      <ContactForm />
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="footer-content">
      <div class="footer-brand">
        <div class="footer-logo-container">
          <img src={logo} alt="Zuclubit Logo" class="footer-logo-image" />
          <div class="footer-logo">ZUCLUBIT</div>
        </div>
        <p class="footer-tagline">The Living Code</p>
        <p class="footer-description">
          Complete technology integration: from architecture to automation.
        </p>
      </div>
      <div class="footer-links">
        <div class="footer-column">
          <h4>Services</h4>
          <ul>
            <li><a href="#services">Architecture & Design</a></li>
            <li><a href="#services">DevOps & Operations</a></li>
            <li><a href="#services">Cybersecurity</a></li>
            <li><a href="#services">Cloud Computing</a></li>
          </ul>
        </div>
        <div class="footer-column">
          <h4>Navigation</h4>
          <ul>
            <li><a href="#services">Services</a></li>
            <li><a href="#expertise">Expertise</a></li>
            <li><a href="#standards">Standards</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div>
        <div class="footer-column">
          <h4>Connect</h4>
          <ul>
            <li><a href="#contact">Get in Touch</a></li>
            <li><a href="mailto:contact@zuclubit.com">Email Us</a></li>
          </ul>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2025 Zuclubit. All rights reserved.</p>
      <div class="footer-legal">
        <a href="#privacy">Privacy Policy</a>
        <a href="#terms">Terms of Service</a>
      </div>
    </div>
  </div>
</footer>

<style>
  :global(*) {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  :global(body) {
    font-family:
      'Inter',
      -apple-system,
      BlinkMacSystemFont,
      'Segoe UI',
      sans-serif;
    background: #0b0e11;
    color: #f5f7fa;
    line-height: 1.6;
  }

  :global(.inline-icon) {
    display: inline-block;
    vertical-align: middle;
    margin-right: 0.25rem;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
  }

  /* Navbar - Corporate Identity Glassmorphism */
  .navbar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    background: rgba(31, 36, 42, 0.85);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border-bottom: 1px solid rgba(199, 209, 246, 0.15);
    box-shadow:
      0 4px 20px rgba(0, 0, 0, 0.3),
      0 1px 4px rgba(0, 0, 0, 0.2),
      inset 0 1px 0 rgba(255, 255, 255, 0.05);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  .navbar::before {
    content: '';
    position: absolute;
    bottom: -1px;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(
      90deg,
      transparent 0%,
      rgba(199, 209, 246, 0.3) 50%,
      transparent 100%
    );
    pointer-events: none;
  }

  .nav-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 1rem 0;
  }

  .nav-logo {
    display: flex;
    align-items: center;
    text-decoration: none;
  }

  .logo-image {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 50%;
    padding: 3px;
    position: relative;
    background: linear-gradient(135deg, rgba(199, 209, 246, 0.15) 0%, rgba(234, 241, 252, 0.15) 100%);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    box-shadow:
      0 8px 32px rgba(199, 209, 246, 0.25),
      0 2px 8px rgba(199, 209, 246, 0.2),
      inset 0 1px 2px rgba(255, 255, 255, 0.1),
      inset 0 -1px 2px rgba(0, 0, 0, 0.1);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid transparent;
    background-clip: padding-box;
  }

  .logo-image::before {
    content: '';
    position: absolute;
    top: -1px;
    left: -1px;
    right: -1px;
    bottom: -1px;
    border-radius: 50%;
    background: linear-gradient(135deg, #C7D1F6 0%, #EAF1FC 50%, #C7D1F6 100%);
    z-index: -1;
    opacity: 0.8;
    transition: opacity 0.4s ease;
  }

  .logo-image::after {
    content: '';
    position: absolute;
    top: 10%;
    left: 10%;
    width: 30%;
    height: 30%;
    border-radius: 50%;
    background: radial-gradient(
      circle at center,
      rgba(255, 255, 255, 0.4) 0%,
      transparent 70%
    );
    filter: blur(4px);
    pointer-events: none;
  }

  .logo-image:hover {
    background: linear-gradient(135deg, rgba(199, 209, 246, 0.25) 0%, rgba(234, 241, 252, 0.25) 100%);
    box-shadow:
      0 12px 48px rgba(199, 209, 246, 0.4),
      0 4px 16px rgba(199, 209, 246, 0.35),
      inset 0 2px 4px rgba(255, 255, 255, 0.15),
      inset 0 -2px 4px rgba(0, 0, 0, 0.15);
    transform: scale(1.08) translateY(-2px);
    backdrop-filter: blur(25px) saturate(200%);
    -webkit-backdrop-filter: blur(25px) saturate(200%);
  }

  .logo-image:hover::before {
    opacity: 1;
    animation: rotate-gradient 3s linear infinite;
  }

  @keyframes rotate-gradient {
    0% {
      filter: hue-rotate(0deg);
    }
    100% {
      filter: hue-rotate(360deg);
    }
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 2rem;
  }

  .nav-links a {
    color: #EAF1FC;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s ease;
    position: relative;
  }

  .nav-links a:hover {
    color: #C7D1F6;
  }

  .nav-links a::after {
    content: '';
    position: absolute;
    bottom: -4px;
    left: 0;
    width: 0;
    height: 2px;
    background: #C7D1F6;
    transition: width 0.3s ease;
  }

  .nav-links a:hover::after {
    width: 100%;
  }

  .mobile-menu-btn {
    display: none;
    background: none;
    border: none;
    color: #EAF1FC;
    cursor: pointer;
    padding: 0.5rem;
    transition: color 0.2s ease;
  }

  .mobile-menu-btn:hover {
    color: #C7D1F6;
  }

  /* Mobile Floating Navbar - Cuervo 2025 Ultra-Refined Futuristic Design */
  .mobile-floating-nav {
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 999;
    display: none;

    /* Floating Shadow - Cinematic Realism (blur 28px, y-offset 4px) */
    filter: drop-shadow(0 4px 28px rgba(0, 0, 0, 0.45))
            drop-shadow(0 2px 8px rgba(0, 0, 0, 0.35));
  }

  /* Dual-Chamber Glass Panel - Outer Glossy Shell + Inner Matte Diffuser */
  .mobile-nav-pill {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    position: relative;
    z-index: 1;

    /* Frosted Glass-Metal: Top #1F242A → Bottom #12161B (80% translucency) */
    background: linear-gradient(168deg, rgba(31, 36, 42, 0.8) 0%, rgba(18, 22, 27, 0.8) 100%);
    backdrop-filter: blur(17px) saturate(110%);
    -webkit-backdrop-filter: blur(17px) saturate(110%);

    padding: 0.875rem 1.125rem;
    border-radius: 23px;

    /* Inner Bevel - 1.5px Rim in #2D333C */
    border: 1.5px solid rgba(45, 51, 60, 0.75);
    background-clip: padding-box;

    /* Unified Lighting System + Top Specular Band + Inner Rim AO */
    box-shadow:
      /* Floating Shadow - rgba(0,0,0,0.38), blur 30px, y-offset 4px */
      0 4px 30px rgba(0, 0, 0, 0.38),
      0 2px 10px rgba(0, 0, 0, 0.28),

      /* Keylight Cool Top-Left (#EAF1FC) */
      inset 1.5px 1.5px 3px rgba(234, 241, 252, 0.22),
      inset 0.5px 0.5px 1.5px rgba(234, 241, 252, 0.14),

      /* Rimlight Turquoise Bottom-Right (#00E5C3) */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.14),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.1),

      /* Top Specular Band (#C7D1F6 12%) */
      inset 0 1.5px 0 0 rgba(199, 209, 246, 0.12),

      /* Ambient Tint #A0A5BE @5% */
      inset 0 0 24px rgba(160, 165, 190, 0.05),

      /* Panel Inner Rim AO - Subtle Darkening */
      inset 0 0 6px rgba(0, 0, 0, 0.12);

    transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
  }

  /* Brushed-Metal Texture (0.5% Grain) */
  .mobile-nav-pill::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    border-radius: 24px;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='brushedMetal'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='3.2' numOctaves='5' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23brushedMetal)' opacity='0.012'/%3E%3C/svg%3E");
    pointer-events: none;
    opacity: 0.5;
    mix-blend-mode: overlay;
  }

  /* Dual-Layer Glass Effect: Outer Gloss + Inner Matte Diffusion */
  .mobile-nav-pill::after {
    content: '';
    position: absolute;
    top: -1px;
    left: -1px;
    right: -1px;
    bottom: -1px;
    border-radius: 22px;

    /* Outer Gloss Layer + Inner Matte Diffusion */
    background:
      /* Outer Gloss - Metallic Rim Gradient */
      linear-gradient(
        135deg,
        rgba(199, 209, 246, 0.22) 0%,
        rgba(160, 165, 190, 0.12) 30%,
        rgba(0, 229, 195, 0.08) 60%,
        rgba(45, 51, 60, 0.35) 100%
      ),
      /* Inner Matte Diffusion - Subsurface Scattering */
      radial-gradient(
        ellipse at 50% 100%,
        rgba(0, 229, 195, 0.06) 0%,
        rgba(160, 165, 190, 0.02) 40%,
        transparent 70%
      );

    z-index: -1;
    pointer-events: none;
    opacity: 1;
  }

  .mobile-nav-pill:hover {
    box-shadow:
      0 26px 52px rgba(0, 0, 0, 0.4),
      0 14px 28px rgba(0, 229, 195, 0.08),
      inset 1.5px 1.5px 3px rgba(199, 209, 246, 0.15),
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.08);
  }

  /* Inactive Buttons - Monoline Icons with Inset Seat (≥44×44 pt targets) */
  .mobile-nav-btn {
    width: 52px;
    height: 52px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;

    /* Buttons Base: #1A1F24 */
    background: #1A1F24;

    /* Rim in #2D333C */
    border: 1px solid rgba(45, 51, 60, 0.8);

    /* Monoline Icons - #C7D1F6 / #EAF1FC (≥3:1 contrast guarantee) */
    color: #C7D1F6;
    text-decoration: none;
    cursor: pointer;

    /* Icon Dual-Stroke for Contrast Enhancement - Inner Bright Stroke */
    text-shadow: 0 0 1px rgba(234, 241, 252, 0.15);

    /* Optimized Micro-Interaction Transitions - 200ms ease-out */
    transition: all 0.2s ease-out;

    /* Subtle Ambient Occlusion + Inset Seat (0.75px) + Interior Bevel */
    box-shadow:
      /* Ambient Occlusion Around Button - Separate Volumes */
      0 3px 12px rgba(0, 0, 0, 0.35),
      0 1px 6px rgba(0, 0, 0, 0.28),

      /* Inset Seat - Lower AO (0.75px) */
      inset 0 0.75px 6px rgba(0, 0, 0, 0.22),

      /* Subtle Interior Bevel - Directional Top-Left */
      inset 1px 1px 2px rgba(199, 209, 246, 0.08),

      /* Subtle Interior Bevel - Directional Bottom-Right */
      inset -1px -1px 2px rgba(18, 22, 27, 0.85);

    position: relative;
    overflow: visible;
    z-index: 2;
  }

  /* Soft Directional Reflection - Top (#EAF1FC / #C7D1F6) */
  .mobile-nav-btn::before {
    content: '';
    position: absolute;
    top: 3px;
    left: 3px;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    background: radial-gradient(
      circle at 30% 30%,
      rgba(234, 241, 252, 0.18) 0%,
      rgba(199, 209, 246, 0.12) 40%,
      rgba(160, 165, 190, 0.06) 70%,
      transparent 90%
    );
    pointer-events: none;
    opacity: 0.85;
    transition: opacity 0.2s ease-out;
  }

  /* Hover: Scale +1.5%, Brighten +8%, Shadow Lift */
  .mobile-nav-btn:hover {
    background: #232930;

    /* Rim Brightens */
    border-color: rgba(45, 51, 60, 0.95);

    /* Precise Scale: +1.5% */
    transform: scale(1.015) translateY(-1px);

    /* Brighten: +8% */
    filter: brightness(1.08);

    /* Monoline Icons Brighten to Polar Mist */
    color: #EAF1FC;

    /* Slight Shadow Lift */
    box-shadow:
      0 5px 16px rgba(0, 0, 0, 0.42),
      0 2px 8px rgba(199, 209, 246, 0.1),
      inset 0 0.75px 6px rgba(0, 0, 0, 0.18),
      inset 1px 1px 2px rgba(234, 241, 252, 0.14),
      inset -1px -1px 2px rgba(0, 229, 195, 0.08);
  }

  /* Slight Hover Reflection - Enhanced Metallic Sheen */
  .mobile-nav-btn:hover::before {
    opacity: 1.35;
  }

  .mobile-nav-btn:active {
    transform: scale(0.985) translateY(-1px);
    filter: brightness(1.04);
    box-shadow:
      0 3px 10px rgba(0, 0, 0, 0.5),
      inset 0 0 10px rgba(18, 22, 27, 0.95);
  }

  /* Focus (Keyboard): Focus Ring 2px #C7D1F6 with Soft Outer Glow */
  .mobile-nav-btn:focus-visible {
    outline: none;
    box-shadow:
      /* Focus Ring - 2px #C7D1F6 */
      0 0 0 2px rgba(199, 209, 246, 0.85),
      /* Soft Outer Glow */
      0 0 12px rgba(199, 209, 246, 0.5),
      0 0 6px rgba(199, 209, 246, 0.35),
      /* Maintain Base Shadows */
      0 3px 12px rgba(0, 0, 0, 0.35),
      inset 0 0.75px 6px rgba(0, 0, 0, 0.22),
      inset 1px 1px 2px rgba(199, 209, 246, 0.08);
  }

  /* Disabled: Desaturation 40%, Opacity 60%, No Highlights */
  .mobile-nav-btn:disabled,
  .mobile-nav-btn[aria-disabled="true"] {
    opacity: 0.6;
    filter: saturate(0.6);
    cursor: not-allowed;
    pointer-events: none;

    /* Remove Highlights */
    box-shadow:
      0 2px 8px rgba(0, 0, 0, 0.28),
      inset 0 0.75px 6px rgba(0, 0, 0, 0.22);
  }

  /* Active Button - Layered Neon Energy with Local Light Spill */
  .mobile-nav-btn-logo {
    padding: 0;
    position: relative;
    z-index: 2;

    /* Layered Glow: Core #00E5C3 → Mid Ring #C7D1F6 → Feather Transparent */
    background: radial-gradient(
      circle at 50% 50%,
      rgba(0, 229, 195, 1) 0%,
      rgba(0, 229, 195, 0.88) 25%,
      rgba(0, 229, 195, 0.72) 45%,
      rgba(199, 209, 246, 0.9) 75%,
      rgba(199, 209, 246, 0.82) 100%
    );

    /* Metallic Double Ring - Outer (#EAF1FC) */
    border: 2px solid rgba(234, 241, 252, 0.65);
    box-sizing: border-box;

    /* Local Light Spill + Diffused Aura (Vignette Turquoise 7% opacity) */
    box-shadow:
      /* Outer Diffused Aura (#00E5C3 → transparent) - Light Spill onto Panel */
      0 0 48px rgba(0, 229, 195, 0.75),
      0 0 32px rgba(0, 229, 195, 0.55),
      0 0 20px rgba(199, 209, 246, 0.48),
      0 0 10px rgba(234, 241, 252, 0.38),

      /* Outer Depth Shadow */
      0 4px 22px rgba(0, 0, 0, 0.52),

      /* Soft Inner Glow Around Symbol */
      inset 0 0 20px rgba(255, 255, 255, 0.4),
      inset 0 0 12px rgba(0, 229, 195, 0.5),

      /* Dual-Layer Inner Bevel - Micro-Specular Highlights */
      inset 2px 2px 4px rgba(234, 241, 252, 0.58),
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.35);

    /* Soft Pulse Animation - 1.2s ease-in-out, Low Amplitude */
    animation: layered-neon-pulse 1.2s ease-in-out infinite;

    /* Optimized Micro-Interaction - 200ms ease-out */
    transition: all 0.2s ease-out;
    overflow: visible;
  }

  @keyframes layered-neon-pulse {
    0%, 100% {
      box-shadow:
        /* Diffused Aura - Base Intensity */
        0 0 48px rgba(0, 229, 195, 0.75),
        0 0 32px rgba(0, 229, 195, 0.55),
        0 0 20px rgba(199, 209, 246, 0.48),
        0 0 10px rgba(234, 241, 252, 0.38),
        0 4px 22px rgba(0, 0, 0, 0.52),
        /* Inner Glow - Base */
        inset 0 0 20px rgba(255, 255, 255, 0.4),
        inset 0 0 12px rgba(0, 229, 195, 0.5);
    }
    50% {
      box-shadow:
        /* Diffused Aura - Peak Intensity (Light Bloom +8%) */
        0 0 62px rgba(0, 229, 195, 0.88),
        0 0 42px rgba(0, 229, 195, 0.68),
        0 0 28px rgba(199, 209, 246, 0.58),
        0 0 14px rgba(234, 241, 252, 0.48),
        0 4px 26px rgba(0, 0, 0, 0.58),
        /* Inner Glow - Peak */
        inset 0 0 26px rgba(255, 255, 255, 0.52),
        inset 0 0 16px rgba(0, 229, 195, 0.62);
    }
  }

  /* Soft Specular Reflection - Metallic Sheen (#EAF1FC) */
  .mobile-nav-btn-logo::before {
    content: '';
    position: absolute;
    top: 4px;
    left: 4px;
    width: 26px;
    height: 26px;
    border-radius: 50%;
    background: radial-gradient(
      circle at 35% 35%,
      rgba(234, 241, 252, 0.65) 0%,
      rgba(255, 255, 255, 0.42) 25%,
      rgba(199, 209, 246, 0.22) 50%,
      transparent 75%
    );
    pointer-events: none;
    z-index: 3;
    opacity: 0.95;
  }

  /* Metallic Double Ring - Inner Ring (#A0A5BE + #C7D1F6) */
  .mobile-nav-btn-logo::after {
    content: '';
    position: absolute;
    top: 3px;
    left: 3px;
    right: 3px;
    bottom: 3px;
    border-radius: 50%;

    /* Double Ring Effect: Inner ring with gradient */
    border: 1.5px solid transparent;
    background:
      linear-gradient(135deg, rgba(160, 165, 190, 0.5), rgba(199, 209, 246, 0.4)) border-box,
      linear-gradient(135deg, rgba(0, 229, 195, 0.3), rgba(199, 209, 246, 0.2)) padding-box;
    background-clip: border-box, padding-box;
    -webkit-mask:
      linear-gradient(#fff 0 0) padding-box,
      linear-gradient(#fff 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;

    pointer-events: none;
    z-index: 2;
  }

  /* Hover: Glow +6%, Scale +1%, Lift +1px, Light Bloom +8% */
  .mobile-nav-btn-logo:hover {
    transform: scale(1.01) translateY(-1px);
    filter: brightness(1.08);

    box-shadow:
      /* Enhanced Diffused Aura (Glow +6%, Light Bloom +8%) */
      0 0 64px rgba(0, 229, 195, 0.9),
      0 0 44px rgba(0, 229, 195, 0.7),
      0 0 28px rgba(199, 209, 246, 0.6),
      0 0 16px rgba(234, 241, 252, 0.5),
      0 5px 30px rgba(0, 0, 0, 0.6),
      /* Enhanced Inner Glow */
      inset 0 0 26px rgba(255, 255, 255, 0.52),
      inset 0 0 16px rgba(0, 229, 195, 0.62);
  }

  .mobile-nav-btn-logo:active {
    transform: scale(0.985) translateY(-1px);
    filter: brightness(1.05);
  }

  /* Focus (Keyboard): Focus Ring 2px #C7D1F6 with Soft Outer Glow */
  .mobile-nav-btn-logo:focus-visible {
    outline: none;
    box-shadow:
      /* Focus Ring - 2px #C7D1F6 */
      0 0 0 2px rgba(199, 209, 246, 0.95),
      /* Soft Outer Glow */
      0 0 16px rgba(199, 209, 246, 0.6),
      0 0 8px rgba(199, 209, 246, 0.45),
      /* Maintain Diffused Aura */
      0 0 48px rgba(0, 229, 195, 0.75),
      0 0 32px rgba(0, 229, 195, 0.55),
      0 0 20px rgba(199, 209, 246, 0.48),
      0 4px 22px rgba(0, 0, 0, 0.52),
      inset 0 0 20px rgba(255, 255, 255, 0.4),
      inset 0 0 12px rgba(0, 229, 195, 0.5);
  }

  /* Disabled: Desaturation 40%, Opacity 60%, No Highlights */
  .mobile-nav-btn-logo:disabled,
  .mobile-nav-btn-logo[aria-disabled="true"] {
    opacity: 0.6;
    filter: saturate(0.6);
    cursor: not-allowed;
    pointer-events: none;
    animation: none;

    /* Remove Highlights - Keep Only Base Shadows */
    box-shadow:
      0 3px 16px rgba(0, 0, 0, 0.32),
      inset 0 0 12px rgba(0, 0, 0, 0.25);
  }

  /* Logo Image - Zuclubit Trinity Symbol with Micro-Shadow */
  .mobile-nav-logo {
    width: 48px;
    height: 48px;
    object-fit: cover;
    border-radius: 50%;
    display: block;
    position: relative;
    z-index: 1;

    /* Photorealistic Enhancement + Micro-Shadow Under Icon */
    filter:
      contrast(1.08)
      saturate(1.15)
      brightness(1.02)
      drop-shadow(0 2px 4px rgba(0, 0, 0, 0.35))
      drop-shadow(0 1px 2px rgba(0, 0, 0, 0.25));
  }

  /* Hero - Signature-Grade Mobile-First Section */
  .hero {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;

    /* Deep Navy Gradient - #1F242A → #12161B */
    background: linear-gradient(168deg, #1F242A 0%, #12161B 100%);

    position: relative;
    overflow: hidden;
    padding-top: 140px;
    padding-bottom: 100px;
    padding-left: 1.5rem;
    padding-right: 1.5rem;
  }

  /* Subtle Volumetric Vignette - No Visual Noise */
  .hero-bg {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;

    /* Volumetric Vignette */
    background:
      radial-gradient(
        ellipse at 50% 30%,
        transparent 0%,
        transparent 40%,
        rgba(18, 22, 27, 0.3) 70%,
        rgba(18, 22, 27, 0.6) 100%
      );

    z-index: 0;
    pointer-events: none;
  }

  .hero-content {
    position: relative;
    z-index: 1;
    text-align: center;
    max-width: 900px;
    margin: 0 auto;
    width: 100%;
  }

  /* Brand Wordmark + Micro-Tagline */
  .brand-section {
    margin-bottom: 3rem;
  }

  .brand-name {
    font-family: 'Inter', sans-serif;
    font-size: clamp(2.5rem, 8vw, 4rem);
    font-weight: 700;

    /* Gradient for visual interest, but maintain AA contrast */
    background: linear-gradient(135deg, #C7D1F6 0%, #EAF1FC 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;

    letter-spacing: 0.08em;
    margin: 0;
    line-height: 1.1;
  }

  .brand-tagline {
    font-family: 'Inter', sans-serif;
    font-size: clamp(0.875rem, 2.5vw, 1.125rem);
    font-weight: 500;

    /* WCAG AA Compliant - #C7D1F6 on #1F242A = 7.85:1 contrast ratio */
    color: #C7D1F6;

    margin: 0.5rem 0 0;
    letter-spacing: 0.05em;
    opacity: 0.9;
  }

  /* Benefit-Led Headline - Concise, Unique Value */
  .headline {
    font-family: 'Inter', sans-serif;
    font-size: clamp(1.75rem, 5vw, 2.75rem);
    font-weight: 700;

    /* Tight Tracking, lh ≈1.15 */
    letter-spacing: -0.02em;
    line-height: 1.15;

    /* WCAG AA Compliant - #EAF1FC on #1F242A = 13.94:1 contrast ratio */
    color: #EAF1FC;

    margin: 0 0 1.25rem;
    max-width: 28ch;
    margin-left: auto;
    margin-right: auto;
  }

  /* Supporting Subheading - ≤66ch, 50-75 CPL */
  .subheadline {
    font-family: 'Inter', sans-serif;

    /* Body 16-18px, 50-75 CPL */
    font-size: clamp(1rem, 2.5vw, 1.125rem);
    font-weight: 400;
    line-height: 1.65;

    /* WCAG AA Compliant - #A0A5BE on #1F242A = 4.75:1 contrast ratio (≥4.5:1) */
    color: #A0A5BE;

    margin: 0 0 2.5rem;

    /* Maximum 66 characters */
    max-width: 66ch;
    margin-left: auto;
    margin-right: auto;
  }

  .cta-group {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
    align-items: center;
  }

  /* Primary CTA - Dual-Chamber Frosted Glass */
  .btn-large {
    /* Large Tappable Target - ≥44×44 pt (minimum 56px for comfort) */
    min-height: 56px;
    padding: 1rem 2.25rem;

    font-size: 1.0625rem;
    font-weight: 600;
    letter-spacing: 0.01em;

    /* Radius 18px (within 16-20px spec) */
    border-radius: 18px;
  }

  /* Secondary Link - Optional, Minimalist */
  .btn-secondary {
    /* Dual-Chamber Frosted Glass (outer glossy + inner matte) */
    background: linear-gradient(168deg, rgba(31, 36, 42, 0.8) 0%, rgba(26, 31, 36, 0.8) 100%);
    backdrop-filter: blur(17px) saturate(105%);
    -webkit-backdrop-filter: blur(17px) saturate(105%);

    /* Inner Bevel - 1px Rim #2D333C */
    border: 1px solid rgba(45, 51, 60, 0.75);
    background-clip: padding-box;

    /* WCAG AA Compliant - #EAF1FC on #1F242A = 13.94:1 */
    color: #EAF1FC;

    position: relative;
    overflow: visible;

    /* Unified Lighting System + Soft Edge AO */
    box-shadow:
      /* Keylight Cool Top-Left (#EAF1FC) */
      inset 1px 1px 2px rgba(234, 241, 252, 0.18),

      /* Rimlight Turquoise Bottom-Right (#00E5C3) */
      inset -1px -1px 2px rgba(0, 229, 195, 0.12),

      /* Ambient Tint #A0A5BE @5% */
      inset 0 0 16px rgba(160, 165, 190, 0.05),

      /* Soft Edge AO */
      0 2px 8px rgba(0, 0, 0, 0.25);

    /* Optimized Timing - 150-200ms ease-out */
    transition: all 0.18s ease-out;
  }

  .btn-secondary:hover {
    /* Brighten +8% */
    filter: brightness(1.08);

    /* Elevation +1 (soft lift) */
    transform: translateY(-1px);

    /* Enhanced Edge Glow */
    box-shadow:
      inset 1px 1px 2px rgba(234, 241, 252, 0.24),
      inset -1px -1px 2px rgba(0, 229, 195, 0.16),
      inset 0 0 16px rgba(160, 165, 190, 0.08),
      0 4px 14px rgba(0, 0, 0, 0.32),
      0 2px 6px rgba(199, 209, 246, 0.12);
  }

  .btn-secondary:active {
    transform: translateY(0);
    filter: brightness(1.04);
  }

  /* Focus Ring 2px #C7D1F6 */
  .btn-secondary:focus-visible {
    outline: none;
    box-shadow:
      0 0 0 2px rgba(199, 209, 246, 0.9),
      0 0 12px rgba(199, 209, 246, 0.5),
      inset 1px 1px 2px rgba(234, 241, 252, 0.18),
      inset -1px -1px 2px rgba(0, 229, 195, 0.12),
      0 2px 8px rgba(0, 0, 0, 0.25);
  }

  /* Buttons */
  .btn {
    display: inline-flex;
    align-items: center;
    padding: 0.875rem 2rem;
    font-weight: 600;
    border-radius: 8px;
    text-decoration: none;
    border: 2px solid transparent;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 1rem;
  }

  /* Primary CTA - High Contrast, Signature-Grade */
  .btn-primary {
    /* Solid High-Contrast Background - #C7D1F6 on #12161B = 8.45:1 contrast (WCAG AAA) */
    background: #C7D1F6;

    /* Dark Text for Maximum Legibility - #12161B on #C7D1F6 = 8.45:1 */
    color: #12161B;

    /* Subtle Inner Bevel for Micro-Dimensionality */
    border: 1px solid rgba(234, 241, 252, 0.6);
    background-clip: padding-box;

    position: relative;
    overflow: visible;
    font-weight: 600;

    /* Unified Lighting System (Subtle on Solid Background) + Edge Definition */
    box-shadow:
      /* Keylight Cool Top-Left (#EAF1FC) - Subtle Specular */
      inset 1px 1px 2px rgba(255, 255, 255, 0.5),

      /* Rimlight Turquoise Bottom-Right (#00E5C3) - Subtle Accent */
      inset -1px -1px 2px rgba(0, 229, 195, 0.08),

      /* Outer Depth Shadow for Elevation */
      0 3px 12px rgba(0, 0, 0, 0.35),
      0 1px 6px rgba(0, 0, 0, 0.28),

      /* Soft Outer Glow (Brand Color Aura) */
      0 0 20px rgba(199, 209, 246, 0.25);

    /* Optimized Timing - 150-200ms ease-out */
    transition: all 0.18s ease-out;
  }

  .btn-primary:hover {
    /* Brighten +8% */
    filter: brightness(1.08);

    /* Elevation +1 (soft lift) */
    transform: translateY(-1px);

    /* Enhanced Elevation Shadow + Stronger Outer Glow */
    box-shadow:
      inset 1px 1px 2px rgba(255, 255, 255, 0.6),
      inset -1px -1px 2px rgba(0, 229, 195, 0.12),
      0 4px 16px rgba(0, 0, 0, 0.42),
      0 2px 8px rgba(0, 0, 0, 0.32),
      0 0 28px rgba(199, 209, 246, 0.38);
  }

  .btn-primary:active {
    transform: translateY(0);
    filter: brightness(1.04);

    /* Pressed State - Reduced Elevation */
    box-shadow:
      inset 1px 1px 2px rgba(255, 255, 255, 0.5),
      inset -1px -1px 2px rgba(0, 229, 195, 0.08),
      0 2px 8px rgba(0, 0, 0, 0.3),
      0 0 16px rgba(199, 209, 246, 0.2);
  }

  /* Focus Ring 2px #C7D1F6 with Outer Glow */
  .btn-primary:focus-visible {
    outline: none;
    box-shadow:
      /* Focus Ring - 2px #EAF1FC (Brighter for visibility) */
      0 0 0 2px rgba(234, 241, 252, 0.95),
      0 0 16px rgba(234, 241, 252, 0.6),

      /* Inner Lighting Preserved */
      inset 1px 1px 2px rgba(255, 255, 255, 0.5),
      inset -1px -1px 2px rgba(0, 229, 195, 0.08),

      /* Outer Depth */
      0 3px 12px rgba(0, 0, 0, 0.35);
  }

  .btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    transform: none;
  }

  /* Sections */
  section {
    padding: 6rem 0;
  }

  .section-header {
    text-align: center;
    margin-bottom: 4rem;
  }

  .section-title {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    letter-spacing: -0.01em;
  }

  .section-subtitle {
    font-size: 1.2rem;
    color: #a0aec0;
    max-width: 600px;
    margin: 0 auto;
  }

  /* Services */
  .services {
    background: #1c2024;
  }

  .services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 2rem;
  }

  .service-card {
    background: #0b0e11;
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 2rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
  }

  .service-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: radial-gradient(
      circle at var(--mouse-x, 50%) var(--mouse-y, 50%),
      rgba(0, 207, 255, 0.15),
      transparent 50%
    );
    opacity: 0;
    transition: opacity 0.3s ease;
    pointer-events: none;
  }

  .service-card:hover,
  .service-card.active {
    transform: translateY(-4px);
    border-color: #00cfff;
    box-shadow: 0 12px 30px rgba(0, 207, 255, 0.2);
  }

  .service-card:hover::before,
  .service-card.active::before {
    opacity: 1;
  }

  .service-icon {
    color: #00cfff;
    margin-bottom: 1rem;
  }

  .service-title {
    font-size: 1.5rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #00cfff;
  }

  .service-description {
    color: #a0aec0;
    margin-bottom: 1.5rem;
    line-height: 1.7;
  }

  .service-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  .tag {
    background: rgba(0, 207, 255, 0.1);
    border: 1px solid rgba(0, 207, 255, 0.3);
    padding: 0.25rem 0.75rem;
    border-radius: 999px;
    font-size: 0.85rem;
    color: #00cfff;
  }

  .service-cta-container {
    margin-top: 1.5rem;
    padding-top: 1.5rem;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
  }

  .service-cta {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    color: #00cfff;
    text-decoration: none;
    font-weight: 600;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    position: relative;
  }

  .service-cta:hover {
    gap: 0.75rem;
    color: #00e5c3;
  }

  .service-cta:hover :global(svg) {
    transform: translateX(4px);
  }

  .service-cta :global(svg) {
    transition: transform 0.3s ease;
  }

  /* Expertise */
  .expertise {
    background: #0b0e11;
  }

  .expertise-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.5rem;
  }

  .expertise-area {
    background: #1c2024;
    border-radius: 12px;
    padding: 1.5rem;
    border: 1px solid rgba(255, 255, 255, 0.05);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: default;
  }

  .expertise-area:hover {
    border-color: rgba(0, 207, 255, 0.3);
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(0, 207, 255, 0.1);
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.03) 0%, rgba(0, 229, 195, 0.03) 100%);
  }

  .expertise-category {
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 1rem;
    color: #00e5c3;
  }

  .expertise-list {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .expertise-list li {
    color: #a0aec0;
    padding-left: 1.5rem;
    position: relative;
  }

  .expertise-list li::before {
    content: '▸';
    position: absolute;
    left: 0;
    color: #00cfff;
  }

  /* Standards */
  .standards {
    background: #1c2024;
  }

  .standards-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1.5rem;
  }

  .standard-card {
    background: #0b0e11;
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: default;
  }

  .standard-card:hover {
    border-color: #00cfff;
    transform: translateY(-4px) scale(1.02);
    box-shadow: 0 8px 24px rgba(0, 207, 255, 0.2);
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.05) 0%, rgba(0, 229, 195, 0.05) 100%);
  }

  .standard-card:hover .standard-icon {
    transform: scale(1.1) rotate(5deg);
  }

  .standard-icon {
    color: #00cfff;
    margin-bottom: 0.75rem;
    display: flex;
    justify-content: center;
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  .standard-name {
    font-weight: 600;
    margin-bottom: 0.25rem;
    color: #00cfff;
  }

  .standard-category {
    font-size: 0.85rem;
    color: #a0aec0;
  }

  /* Section CTAs */
  .section-cta {
    margin-top: 4rem;
    text-align: center;
    padding: 3rem 2rem;
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.05) 0%, rgba(0, 229, 195, 0.05) 100%);
    border-radius: 16px;
    border: 1px solid rgba(0, 207, 255, 0.2);
  }

  .section-cta-text {
    font-size: 1.25rem;
    font-weight: 500;
    color: #f5f7fa;
    margin-bottom: 1.5rem;
    letter-spacing: -0.01em;
  }

  /* Metrics */
  .metrics {
    background: linear-gradient(135deg, #0b0e11 0%, #1c2024 100%);
    position: relative;
    overflow: hidden;
  }

  .metrics::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background:
      radial-gradient(circle at 30% 50%, rgba(0, 207, 255, 0.1) 0%, transparent 50%),
      radial-gradient(circle at 70% 50%, rgba(0, 229, 195, 0.1) 0%, transparent 50%);
    pointer-events: none;
  }

  .metrics .container {
    position: relative;
    z-index: 1;
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
  }

  .metric-card {
    background: rgba(28, 32, 36, 0.6);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 2.5rem 2rem;
    text-align: center;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    backdrop-filter: blur(10px);
  }

  .metric-card:hover {
    transform: translateY(-8px) scale(1.02);
    border-color: #00cfff;
    box-shadow: 0 16px 40px rgba(0, 207, 255, 0.3);
    background: rgba(0, 207, 255, 0.1);
  }

  .metric-icon {
    color: #00cfff;
    margin-bottom: 1rem;
    display: flex;
    justify-content: center;
    transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  }

  .metric-card:hover .metric-icon {
    transform: scale(1.15) rotate(5deg);
  }

  .metric-value {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 3rem;
    font-weight: 700;
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 0.5rem;
    line-height: 1;
  }

  .metric-label {
    font-size: 1rem;
    color: #a0aec0;
    font-weight: 500;
    letter-spacing: 0.01em;
  }

  /* Contact */
  .contact {
    background: #0b0e11;
  }

  .contact-container {
    display: grid;
    grid-template-columns: 1fr 1.5fr;
    gap: 4rem;
    margin-top: 3rem;
  }

  .contact-info h3 {
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
    color: #00cfff;
  }

  .benefits-list {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .benefits-list li {
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
  }

  .check {
    color: #00e5c3;
    flex-shrink: 0;
    margin-top: 0.1rem;
  }

  /* Form */
  .contact-form {
    background: #1c2024;
    padding: 2.5rem;
    border-radius: 16px;
    border: 1px solid rgba(255, 255, 255, 0.1);
  }

  .form-group {
    margin-bottom: 1.5rem;
  }

  .form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
    color: #00cfff;
  }

  .form-group input,
  .form-group select,
  .form-group textarea {
    width: 100%;
    padding: 0.875rem 1rem;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    color: #f5f7fa;
    font-family: inherit;
    font-size: 1rem;
    transition: all 0.2s ease;
  }

  .form-group input:focus,
  .form-group select:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: #00cfff;
    background: rgba(255, 255, 255, 0.08);
  }

  .form-group textarea {
    resize: vertical;
  }

  .contact-form .btn {
    width: 100%;
    margin-top: 1rem;
    justify-content: center;
    gap: 0.5rem;
  }

  .success-message {
    margin-top: 1rem;
    padding: 1rem;
    background: rgba(0, 229, 195, 0.1);
    border: 1px solid rgba(0, 229, 195, 0.3);
    border-radius: 8px;
    color: #00e5c3;
    text-align: center;
  }

  /* Footer */
  .footer {
    background: #1c2024;
    padding: 4rem 0 2rem;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
  }

  .footer-content {
    display: grid;
    grid-template-columns: 2fr 3fr;
    gap: 4rem;
    margin-bottom: 3rem;
  }

  .footer-logo-container {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 0.5rem;
  }

  .footer-logo-image {
    width: 50px;
    height: 50px;
    object-fit: contain;
    border-radius: 50%;
    padding: 3px;
    position: relative;
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.15) 0%, rgba(0, 229, 195, 0.15) 100%);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    box-shadow:
      0 8px 32px rgba(0, 207, 255, 0.25),
      0 2px 8px rgba(0, 229, 195, 0.2),
      inset 0 1px 2px rgba(255, 255, 255, 0.1),
      inset 0 -1px 2px rgba(0, 0, 0, 0.1);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    border: 1px solid transparent;
    background-clip: padding-box;
  }

  .footer-logo-image::before {
    content: '';
    position: absolute;
    top: -1px;
    left: -1px;
    right: -1px;
    bottom: -1px;
    border-radius: 50%;
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 50%, #00cfff 100%);
    z-index: -1;
    opacity: 0.6;
    transition: opacity 0.4s ease;
  }

  .footer-logo-image::after {
    content: '';
    position: absolute;
    top: 10%;
    left: 10%;
    width: 30%;
    height: 30%;
    border-radius: 50%;
    background: radial-gradient(
      circle at center,
      rgba(255, 255, 255, 0.3) 0%,
      transparent 70%
    );
    filter: blur(4px);
    pointer-events: none;
  }

  .footer-logo-image:hover {
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

  .footer-logo-image:hover::before {
    opacity: 0.9;
  }

  .footer-logo {
    font-family: 'Space Grotesk', sans-serif;
    font-size: 1.75rem;
    font-weight: 700;
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: -0.01em;
  }

  .footer-tagline {
    font-family: 'Inter', sans-serif;
    color: #00e5c3;
    margin: 0.5rem 0 1rem;
    font-size: 0.9rem;
    font-weight: 500;
  }

  .footer-description {
    color: #a0aec0;
    max-width: 300px;
  }

  .footer-links {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;
  }

  .footer-column h4 {
    color: #00cfff;
    margin-bottom: 1rem;
    font-weight: 600;
  }

  .footer-column ul {
    list-style: none;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .footer-column a {
    color: #a0aec0;
    text-decoration: none;
    transition: color 0.2s ease;
  }

  .footer-column a:hover {
    color: #00cfff;
  }

  .footer-bottom {
    padding-top: 2rem;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #a0aec0;
    font-size: 0.9rem;
  }

  .footer-legal {
    display: flex;
    gap: 2rem;
  }

  .footer-legal a {
    color: #a0aec0;
    text-decoration: none;
    transition: color 0.2s ease;
  }

  .footer-legal a:hover {
    color: #00cfff;
  }

  /* Responsive */
  @media (max-width: 768px) {
    /* Hide top navbar in mobile - use bottom floating nav instead */
    .navbar {
      display: none;
    }

    .mobile-menu-btn {
      display: block;
    }

    .mobile-floating-nav {
      display: block;
    }

    .nav-links {
      position: fixed;
      top: 70px;
      left: 0;
      right: 0;
      background: rgba(31, 36, 42, 0.98);
      backdrop-filter: blur(10px);
      flex-direction: column;
      gap: 0;
      padding: 1rem 0;
      border-bottom: 1px solid rgba(199, 209, 246, 0.1);
      transform: translateY(-100%);
      opacity: 0;
      visibility: hidden;
      transition: all 0.3s ease;
    }

    .nav-links.active {
      transform: translateY(0);
      opacity: 1;
      visibility: visible;
    }

    .nav-links a {
      padding: 1rem 2rem;
      width: 100%;
      text-align: center;
      border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    }

    .nav-links a::after {
      display: none;
    }

    .logo-image {
      width: 40px;
      height: 40px;
    }

    .hero {
      padding-top: 2rem;
      padding-bottom: 6rem;
    }

    .brand-name {
      font-size: 2.5rem;
    }

    .brand-tagline {
      font-size: 1.1rem;
    }

    .headline {
      font-size: 1.75rem;
      line-height: 1.3;
    }

    .subheadline {
      font-size: 1.05rem;
      margin-bottom: 2rem;
    }

    .cta-group {
      flex-direction: column;
      gap: 0.75rem;
    }

    .btn-large {
      padding: 0.875rem 1.75rem;
      font-size: 1rem;
      width: 100%;
    }

    .services-grid,
    .expertise-grid,
    .standards-grid,
    .metrics-grid {
      grid-template-columns: 1fr;
    }

    .contact-container {
      grid-template-columns: 1fr;
      gap: 2rem;
    }

    .footer-content {
      grid-template-columns: 1fr;
      gap: 2rem;
    }

    .footer-links {
      grid-template-columns: 1fr;
      gap: 1.5rem;
    }

    .footer-bottom {
      flex-direction: column;
      gap: 1rem;
      text-align: center;
    }
  }
</style>
