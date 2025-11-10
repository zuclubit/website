<script>
  import { fade, fly } from 'svelte/transition';
  import { onMount, onDestroy } from 'svelte';
  import PremiumLogo from './components/PremiumLogo.svelte';
  import PremiumButton from './components/PremiumButton.svelte';
  import NavItem from './components/NavItem.svelte';
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

  // GSAP + ScrollTrigger + Lenis smooth scroll
  import { gsap } from 'gsap';
  import { ScrollTrigger } from 'gsap/ScrollTrigger';
  import Lenis from 'lenis';
  import 'lenis/dist/lenis.css';
  import SplitType from 'split-type';

  import logo from '../img/logo-zuclubit.png';
  import ContactForm from './components/sections/ContactForm.svelte';

  // Register GSAP plugins
  if (typeof window !== 'undefined') {
    gsap.registerPlugin(ScrollTrigger);
  }

  let mobileMenuOpen = false;
  let activeService = null;
  let activeSection = 'home'; // Track active section for navbar

  // Hero animation state
  let heroVisible = false;
  let headlineLines = [];
  let dockInView = false;
  let lenis; // Lenis smooth scroll instance

  // Split headline into lines for staggered animation
  const headlineText = "Technology That Evolves With Purpose";

  // Check motion preferences
  const prefersReducedMotion = typeof window !== 'undefined'
    ? window.matchMedia('(prefers-reduced-motion: reduce)').matches
    : false;

  onMount(() => {
    // Split headline into words and create lines (mobile-friendly breakpoints)
    const words = headlineText.split(' ');

    // Adaptive line breaking: mobile (2-3 words/line), desktop (4-5 words/line)
    const isMobile = window.innerWidth < 768;
    const wordsPerLine = isMobile ? 2 : 4;

    for (let i = 0; i < words.length; i += wordsPerLine) {
      headlineLines.push(words.slice(i, i + wordsPerLine).join(' '));
    }

    // Initialize dock as visible immediately
    dockInView = true;

    // ========================================
    // GSAP ScrollTrigger + Lenis Smooth Scroll
    // ========================================

    if (!prefersReducedMotion) {
      // Initialize Lenis smooth scroll
      lenis = new Lenis({
        duration: 1.2,
        easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)), // easeOutExpo
        orientation: 'vertical',
        gestureOrientation: 'vertical',
        smoothWheel: true,
        wheelMultiplier: 1,
        smoothTouch: false,
        touchMultiplier: 2,
        infinite: false,
      });

      // Connect Lenis to GSAP ScrollTrigger
      lenis.on('scroll', ScrollTrigger.update);

      gsap.ticker.add((time) => {
        lenis.raf(time * 1000);
      });

      gsap.ticker.lagSmoothing(0);

      // Wait for DOM to be ready
      setTimeout(() => {
        const ctaGroup = document.querySelector('.hero-cta-group');

        if (ctaGroup) {
          // Hero Entry: CTA reveals with opacity + Y(10→0) + blur(3→0) (~300ms)
          gsap.fromTo(ctaGroup,
            {
              // FROM state
              opacity: 0,
              y: 10,
              filter: 'blur(3px)',
            },
            {
              // TO state
              opacity: 1,
              y: 0,
              filter: 'blur(0px)',
              duration: 0.3,
              delay: 0.15,
              ease: 'power2.out',
              onComplete: () => {
                heroVisible = true;
              },
            }
          );

          // Scroll-Down: CTA fade/slide-out (reversible on scroll up)
          gsap.fromTo(ctaGroup,
            {
              // FROM: Visible state (cuando está arriba)
              opacity: 1,
              y: 0,
            },
            {
              // TO: Hidden state (cuando hace scroll down)
              opacity: 0,
              y: 25,
              scrollTrigger: {
                trigger: '.hero',
                start: '30% top',      // Empieza a desaparecer a 30vh
                end: '50% top',        // Completamente invisible a 50vh
                scrub: 1,              // Smooth scrub - reversible
                markers: false,
              },
            }
          );
        } else {
          // Fallback if element not found
          heroVisible = true;
        }

        // SplitType: Per-word animation for CTA label (optional enhancement)
        const ctaButton = document.querySelector('.btn-hero-primary');
        if (ctaButton) {
          // Find the text node (first child that's not the icon)
          const textNode = Array.from(ctaButton.childNodes).find(
            node => node.nodeType === Node.TEXT_NODE && node.textContent.trim()
          );

          if (textNode && textNode.textContent.trim()) {
            // Wrap text in span for SplitType
            const tempSpan = document.createElement('span');
            tempSpan.textContent = textNode.textContent.trim();
            tempSpan.style.display = 'inline-block';
            textNode.replaceWith(tempSpan);

            // Apply SplitType
            try {
              const split = new SplitType(tempSpan, { types: 'words' });

              // Animate words
              gsap.from(split.words, {
                opacity: 0,
                y: 8,
                duration: 0.4,
                stagger: 0.05,
                delay: 0.3,
                ease: 'power2.out',
              });
            } catch (e) {
              console.warn('SplitType animation failed:', e);
            }
          }
        }
      }, 50);  // Small delay to ensure DOM is ready

      // Parallax: Background scrub
      gsap.to('.hero-bg', {
        y: 200,
        scrollTrigger: {
          trigger: '.hero',
          start: 'top top',
          end: 'bottom top',
          scrub: 1.5,
        },
      });

      // Navbar Sticky Scroll Behavior: A partir de 24px → altura 64px, opacidad 88%
      const navbar = document.querySelector('.navbar');
      if (navbar) {
        ScrollTrigger.create({
          trigger: 'body',
          start: '24px top',  /* Scroll trigger a partir de 24px */
          end: '25px top',
          onEnter: () => navbar.classList.add('scrolled'),
          onLeaveBack: () => navbar.classList.remove('scrolled'),
        });
      }

      // Intersection Observer for dock lift and glow
      const dock = document.querySelector('.mobile-floating-nav');
      if (dock) {
        const dockObserver = new IntersectionObserver(
          (entries) => {
            entries.forEach((entry) => {
              dockInView = entry.isIntersecting;
            });
          },
          { threshold: 0.1, rootMargin: '50px' }
        );

        dockObserver.observe(dock);
      }
    } else {
      // Reduced motion: Simple reveal
      setTimeout(() => {
        heroVisible = true;
      }, 100);
    }

    // ========================================
    // Scroll Spy: Active Section Detection
    // ========================================

    // IntersectionObserver for active section detection
    const sections = document.querySelectorAll('section[id]');
    const navbarHeight = document.querySelector('.navbar')?.offsetHeight || 80;

    const sectionObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          // Only update if section is entering viewport (intersecting)
          if (entry.isIntersecting) {
            activeSection = entry.target.id;
          }
        });
      },
      {
        // Trigger when section is 30% visible from top
        // Account for navbar height with negative rootMargin
        rootMargin: `-${navbarHeight}px 0px -50% 0px`,
        threshold: 0,
      }
    );

    // Observe all sections
    sections.forEach((section) => {
      sectionObserver.observe(section);
    });
  });

  onDestroy(() => {
    // Cleanup Lenis instance
    if (lenis) {
      lenis.destroy();
    }
  });

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
    { value: '99.9%', label: 'System Uptime SLA', icon: CheckCircle2 },
    { value: '40%', label: 'Avg. Cost Reduction', icon: TrendingUp },
    { value: '24/7', label: 'Support Coverage', icon: Shield },
  ];

  // Mobile menu state
  // (Contact form logic is now in ContactForm.svelte component)

  function toggleMobileMenu() {
    mobileMenuOpen = !mobileMenuOpen;

    // Lock body scroll when menu is open
    if (typeof document !== 'undefined') {
      if (mobileMenuOpen) {
        document.body.style.overflow = 'hidden';

        // Focus trap: focus first item in mobile panel
        setTimeout(() => {
          const firstItem = document.querySelector('.mobile-nav-item');
          if (firstItem) firstItem.focus();
        }, 300);
      } else {
        document.body.style.overflow = '';
      }
    }
  }

  // Escape key to close mobile menu
  if (typeof window !== 'undefined') {
    window.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && mobileMenuOpen) {
        toggleMobileMenu();
      }
    });
  }
</script>

<!-- Navbar: Signature-Grade Glass-Metal Cuervo 2025 -->
<nav class="navbar" aria-label="Main navigation">
  <!-- Inner matte diffuser layer -->
  <div class="navbar-diffuser" aria-hidden="true"></div>

  <!-- Main container -->
  <div class="navbar-container">
    <!-- Left: Brand Logo -->
    <PremiumLogo
      size="46px"
      alt="Zuclubit"
      ariaLabel="Zuclubit Home"
      href="/"
    />

    <!-- Right: Desktop Nav Items -->
    <div class="navbar-items">
      <NavItem href="/" label="Home" isActive={activeSection === 'home'} />
      <NavItem href="#services" label="Services" isActive={activeSection === 'services'} />
      <NavItem href="#expertise" label="Expertise" isActive={activeSection === 'expertise'} />
      <NavItem href="#standards" label="Standards" isActive={activeSection === 'standards'} />
      <PremiumButton
        href="#contact"
        variant="primary"
        size="md"
        ariaLabel="Contact us"
      >
        Contact
      </PremiumButton>
    </div>

    <!-- Mobile: Hamburger Button -->
    <button
      class="mobile-menu-button"
      on:click={toggleMobileMenu}
      class:open={mobileMenuOpen}
      aria-label="Toggle menu"
      aria-expanded={mobileMenuOpen}
    >
      <span class="hamburger-line"></span>
      <span class="hamburger-line"></span>
      <span class="hamburger-line"></span>
    </button>
  </div>
</nav>

<!-- Mobile Menu Panel -->
<div class="mobile-menu-panel" class:open={mobileMenuOpen} role="dialog" aria-modal="true">
  <nav class="mobile-nav" aria-label="Mobile navigation">
    <a href="/" class="mobile-nav-item" class:active={activeSection === 'home'} on:click={toggleMobileMenu}>Home</a>
    <a href="#services" class="mobile-nav-item" class:active={activeSection === 'services'} on:click={toggleMobileMenu}>Services</a>
    <a href="#expertise" class="mobile-nav-item" class:active={activeSection === 'expertise'} on:click={toggleMobileMenu}>Expertise</a>
    <a href="#standards" class="mobile-nav-item" class:active={activeSection === 'standards'} on:click={toggleMobileMenu}>Standards</a>
    <a href="#contact" class="mobile-nav-item" class:active={activeSection === 'contact'} on:click={toggleMobileMenu}>Contact</a>
  </nav>
</div>

<!-- Mobile Menu Backdrop -->
<div
  class="mobile-menu-backdrop"
  class:visible={mobileMenuOpen}
  on:click={toggleMobileMenu}
  on:keydown={(e) => e.key === 'Escape' && toggleMobileMenu()}
  aria-hidden="true"
  role="presentation"
></div>

<!-- Mobile Floating Navbar (Bottom) -->
<nav class="mobile-floating-nav" class:in-view={dockInView}>
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
<section id="home" class="hero">
  <div class="hero-bg"></div>
  <div class="container hero-container">
    <div class="hero-content">
      <!-- Eyebrow/Tagline: Small and Subtle -->
      <p class="hero-eyebrow" class:visible={heroVisible}>The Living Code</p>

      <!-- Benefit-Driven H1: Split-Line Animation -->
      <h1 class="hero-headline">
        {#each headlineLines as line, i}
          <span class="headline-line" class:visible={heroVisible} style="--line-index: {i}">
            {line}
          </span>
        {/each}
      </h1>

      <!-- Lead Paragraph: ≤66ch -->
      <p class="hero-lead" class:visible={heroVisible}>
        Complete integration of hardware, software and intelligence for digital transformation and
        sustainable innovation.
      </p>

      <!-- Primary CTA: Large Tappable Target, High Contrast -->
      <div class="hero-cta-group" class:visible={heroVisible}>
        <a href="#contact" class="btn-hero btn-hero-primary">
          Start Your Transformation
          <ArrowRight size={20} strokeWidth={2} />
        </a>
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
          <PremiumLogo
            size="50px"
            alt="Zuclubit Logo"
          />
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
  /* ========================================
     NAVBAR — SIGNATURE-GRADE CUERVO 2025
     ======================================== */

  /* Navbar Design Tokens - Triple-Layer Glass Premium */
  :root {
    /* Dimensiones */
    --navbar-height: clamp(72px, 8vw, 80px);
    --navbar-height-scrolled: 64px;  /* Modo scroll: fixed 64px a partir de 24px */
    --navbar-px: clamp(32px, 5vw, 40px);
    --navbar-item-gap: 36px;  /* 32-40px */

    /* Material Glass Premium */
    --navbar-blur: 19px;           /* 18-20px backdrop-blur */
    --navbar-blur-scrolled: 20px;
    --navbar-opacity: 0.82;        /* 80-85% opacity */
    --navbar-opacity-scrolled: 0.88;
    --navbar-sat: 110%;
    --navbar-sat-scrolled: 115%;

    /* Border radius (esquinas como dock) */
    --navbar-radius: 22px;  /* 20-24px */

    /* Logo medallón circular */
    --navbar-logo-size: 46px;  /* 44-48px con bevel y halo */

    /* Typography Premium */
    --navbar-font-size: 19px;  /* 18-20px */
    --navbar-font-weight: 600;  /* Semibold 600-700 */
    --navbar-tracking: -0.004em;  /* -0.4% (-0.3% to -0.5%) */
    --navbar-lh: 1.2;

    /* Active State Pill Translúcida */
    --pill-bg: rgba(45, 51, 60, 0.40);  /* #2D333C @40% */
    --pill-radius: 19px;  /* 18-20px */
    --underline-height: 3.5px;  /* 3-4px con bloom */

    /* Timing */
    --nav-t-fast: 180ms;
    --nav-t-med: 200ms;
    --nav-t-large: 240ms;
    --nav-t-panel: 300ms;
    --ease-out: cubic-bezier(0.2, 0.8, 0.2, 1);
  }

  /* Main Navbar Container - Triple-Layer Glass */
  .navbar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;

    height: var(--navbar-height);

    /* Shell brillante exterior (Capa 1) - 82% opacity */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.82) 0%,
      rgba(18, 22, 27, 0.82) 100%
    );
    backdrop-filter: blur(var(--navbar-blur)) saturate(var(--navbar-sat));
    -webkit-backdrop-filter: blur(var(--navbar-blur)) saturate(var(--navbar-sat));

    /* Inner-bevel premium: 1.2px #A0A5BE @18% */
    border: 1.2px solid rgba(160, 165, 190, 0.18);
    border-bottom-width: 1px;
    border-bottom-color: rgba(45, 51, 60, 0.85);

    /* Triple-Layer Lighting System + Glow Perimetral Controlado */
    box-shadow:
      /* Glow Perimetral Turquoise (controlado, sin sobre-exposición) */
      0 0 12px rgba(0, 229, 195, 0.08),
      0 0 24px rgba(0, 229, 195, 0.04),

      /* Outer Elevation Shadow */
      0 2px 8px rgba(0, 0, 0, 0.18),
      0 1px 3px rgba(0, 0, 0, 0.12),

      /* Micro-Specular Top (Capa 3) */
      inset 0 1px 1px 0 rgba(255, 255, 255, 0.15),

      /* Keylight Cool Top-Left 45° - Dual Layer (#EAF1FC 10-14%) */
      inset 1.5px 1.5px 3px rgba(234, 241, 252, 0.22),
      inset 0.5px 0.5px 1.5px rgba(234, 241, 252, 0.14),

      /* Rimlight Turquoise Direccional 225° (#00E5C3) */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.14),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.1),

      /* Ambient Tint (#A0A5BE @5%) */
      inset 0 0 24px rgba(160, 165, 190, 0.05),

      /* Bottom Divider Specular (AO) */
      inset 0 -1px 0 rgba(255, 255, 255, 0.08),

      /* Ambient Occlusion - Inner Edges */
      inset 0 0 6px rgba(0, 0, 0, 0.12);

    transition:
      height var(--nav-t-large) var(--ease-out),
      backdrop-filter var(--nav-t-large) var(--ease-out),
      opacity var(--nav-t-large) var(--ease-out),
      border-bottom var(--nav-t-large) var(--ease-out);
  }

  /* Scrolled state (a partir de 24px) */
  .navbar.scrolled {
    height: var(--navbar-height-scrolled);
    backdrop-filter: blur(var(--navbar-blur-scrolled)) saturate(var(--navbar-sat-scrolled));
    -webkit-backdrop-filter: blur(var(--navbar-blur-scrolled)) saturate(var(--navbar-sat-scrolled));

    /* Opacidad 88%, borde 1px visible */
    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.88) 0%,
      rgba(18, 22, 27, 0.88) 100%
    );
    border-bottom-color: rgba(45, 51, 60, 1);  /* Borde visible en scroll */
  }

  /* Difusor Mate Interior (Capa 2) - Triple-Layer */
  .navbar-diffuser {
    position: absolute;
    inset: 0;
    /* Difusor mate más pronunciado con tinte frío */
    background: radial-gradient(
      ellipse at 50% 0%,
      rgba(199, 209, 246, 0.08) 0%,
      rgba(199, 209, 246, 0.04) 50%,
      rgba(0, 229, 195, 0.02) 100%
    );
    pointer-events: none;
    z-index: 0;
  }

  /* Inner Container (Flex Layout) */
  .navbar-container {
    position: relative;
    z-index: 1;

    height: 100%;
    padding: 0 var(--navbar-px);

    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  /* Nav Items Container (Right) */
  .navbar-items {
    display: flex;
    align-items: center;
    gap: var(--navbar-item-gap);
  }

  /* Individual Nav Item - Premium Typography */
  /* GLOBAL: Necesario para que se aplique a NavItem component */
  :global(.nav-item) {
    position: relative;

    padding: 14px 18px;
    min-height: 44px;
    min-width: 44px;

    display: inline-flex;
    align-items: center;
    justify-content: center;

    /* Typography Premium: Inter/SF Semibold 600-700, 18-20px */
    font-family: Inter, SF Pro Display, -apple-system, system-ui, sans-serif;
    font-size: var(--navbar-font-size);  /* 19px */
    font-weight: var(--navbar-font-weight);  /* 600 */
    letter-spacing: var(--navbar-tracking);  /* -0.4% */
    line-height: var(--navbar-lh);  /* 1.2 */

    /* Color: reposo #C7D1F6 (alto contraste AA) */
    color: #C7D1F6;
    text-decoration: none;
    white-space: nowrap;

    opacity: 0.9;

    transition:
      opacity var(--nav-t-med) var(--ease-out),
      filter var(--nav-t-med) var(--ease-out),
      background var(--nav-t-med) var(--ease-out),
      transform var(--nav-t-med) var(--ease-out);
  }

  /* Hover State - Incremento de specular y elevación */
  :global(.nav-item:hover) {
    opacity: 1;
    color: #EAF1FC;  /* Texto activo en hover */
    filter: brightness(1.07);

    /* Elevación: y-offset 2px, blur 8px */
    transform: translateY(-2px);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
  }

  /* Underline Animation - 3.5px con bloom controlado */
  :global(.nav-item::after) {
    content: '';
    position: absolute;
    bottom: 8px;
    left: 18px;
    right: 18px;

    height: var(--underline-height);  /* 3.5px (3-4px) */
    background: rgba(0, 229, 195, 0.6);
    border-radius: 2px;

    /* Bloom controlado (sin sobre-exposición) */
    box-shadow: 0 0 6px rgba(0, 229, 195, 0.4);

    transform: scaleX(0);
    transform-origin: left center;

    transition: transform var(--nav-t-fast) var(--ease-out);
  }

  :global(.nav-item:hover::after) {
    transform: scaleX(1);
  }

  /* Active/Current State - Pill Translúcida + Underline */
  :global(.nav-item.active) {
    opacity: 1;
    color: #EAF1FC;  /* Texto activo #EAF1FC */

    /* Pill translúcida: radius 18-20px, fondo #2D333C @40% */
    background: var(--pill-bg);
    border-radius: var(--pill-radius);

    /* Elevación +1 */
    transform: translateY(-1px);
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.12);
  }

  :global(.nav-item.active::after) {
    /* Underline 3-4px #00E5C3 con bloom */
    background: #00E5C3;
    box-shadow: 0 0 8px rgba(0, 229, 195, 0.5);
    transform: scaleX(1);
    opacity: 1;
  }

  /* Focus State (Keyboard) - Anillo 2px #00E5C3 + 1px #EAF1FC */
  :global(.nav-item:focus-visible) {
    outline: none;
    border-radius: var(--pill-radius);

    /* Anillo compuesto: contraste 3:1 no-text */
    box-shadow:
      /* Inner ring: 1px #EAF1FC */
      0 0 0 1px #EAF1FC,

      /* Outer ring: 2px #00E5C3 */
      0 0 0 3px #00E5C3,

      /* Soft glow */
      0 0 12px rgba(0, 229, 195, 0.4);
  }

  /* Tablet Responsive (≤1024px) */
  @media (max-width: 1024px) {
    :root {
      --navbar-item-gap: 26px;  /* 24-28px range - reduced from 36px */
      --navbar-px: clamp(24px, 4vw, 32px);  /* Reduce padding slightly */
    }

    :global(.nav-item) {
      font-size: 18px;  /* Slightly smaller on tablet */
      padding: 12px 16px;
      letter-spacing: -0.003em;  /* -0.3% */
    }
  }

  /* Mobile: Hide Desktop Nav */
  @media (max-width: 767px) {
    .navbar-items {
      display: none;
    }
  }

  /* Mobile: Hamburger Button */
  .mobile-menu-button {
    display: none;
    width: 48px;
    height: 48px;

    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.8) 0%,
      rgba(18, 22, 27, 0.8) 100%
    );
    backdrop-filter: blur(var(--navbar-blur)) saturate(var(--navbar-sat));

    border: 1px solid rgba(45, 51, 60, 0.85);
    border-radius: 12px;

    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 6px;

    cursor: pointer;
    transition: opacity var(--nav-t-med) var(--ease-out);
  }

  .mobile-menu-button:hover {
    opacity: 0.9;
  }

  @media (max-width: 767px) {
    .mobile-menu-button {
      display: flex;
    }
  }

  .hamburger-line {
    width: 24px;
    height: 2px;
    background: #EAF1FC;
    border-radius: 1px;
    transition:
      transform var(--nav-t-med) var(--ease-out),
      opacity var(--nav-t-med) var(--ease-out);
  }

  /* Open State: X Animation */
  .mobile-menu-button.open .hamburger-line:nth-child(1) {
    transform: translateY(8px) rotate(45deg);
  }

  .mobile-menu-button.open .hamburger-line:nth-child(2) {
    opacity: 0;
  }

  .mobile-menu-button.open .hamburger-line:nth-child(3) {
    transform: translateY(-8px) rotate(-45deg);
  }

  /* Mobile Panel - Full-Height Side Panel */
  .mobile-menu-panel {
    position: fixed;
    top: 0;
    right: 0;
    width: 280px;
    height: 100vh;
    z-index: 1001;

    background: linear-gradient(168deg,
      rgba(31, 36, 42, 0.95) 0%,
      rgba(18, 22, 27, 0.95) 100%
    );
    /* Mobile blur: 16-18px (using 17px) */
    backdrop-filter: blur(17px) saturate(115%);
    -webkit-backdrop-filter: blur(17px) saturate(115%);

    border-left: 1px solid rgba(45, 51, 60, 0.85);

    padding: 80px 24px 24px;
    overflow-y: auto;

    transform: translateX(100%);
    transition: transform var(--nav-t-panel) var(--ease-out);
  }

  .mobile-menu-panel.open {
    transform: translateX(0);
  }

  /* Mobile Nav Items - Stacked with 20-24px Gap */
  .mobile-nav {
    display: flex;
    flex-direction: column;
    gap: 22px;  /* 20-24px vertical gap */
  }

  .mobile-nav-item {
    display: block;
    padding: 16px 20px;

    font-family: Inter, -apple-system, system-ui, sans-serif;
    font-size: 18px;  /* 16-18px (using 18px for mobile) */
    font-weight: 600;
    letter-spacing: -0.003em;  /* -0.3% tracking */
    line-height: 1.25;  /* 1.2-1.3 range */
    color: #EAF1FC;
    text-decoration: none;

    border-radius: 12px;

    transition: background var(--nav-t-fast) var(--ease-out);
  }

  .mobile-nav-item:hover,
  .mobile-nav-item.active {
    background: rgba(0, 229, 195, 0.12);
  }

  /* Backdrop Overlay */
  .mobile-menu-backdrop {
    position: fixed;
    inset: 0;
    z-index: 999;

    background: rgba(18, 22, 27, 0.6);
    backdrop-filter: blur(4px);

    opacity: 0;
    pointer-events: none;

    transition: opacity var(--nav-t-panel) var(--ease-out);
  }

  .mobile-menu-backdrop.visible {
    opacity: 1;
    pointer-events: auto;
  }

  /* Reduced Motion - Opacity Only (120-160ms) */
  @media (prefers-reduced-motion: reduce) {
    .navbar,
    :global(.nav-item),
    :global(.nav-item::after),
    .mobile-menu-button,
    .hamburger-line,
    .mobile-menu-panel,
    .mobile-menu-backdrop {
      transition-property: opacity !important;
      transition-duration: 140ms !important;  /* 120-160ms range */
    }

    /* Disable transform animations, use opacity instead */
    :global(.nav-item::after) {
      transform: scaleX(1);
      opacity: 0;
    }

    :global(.nav-item:hover::after),
    :global(.nav-item.active::after) {
      opacity: 1;
    }

    /* Disable hamburger X animation */
    .mobile-menu-button.open .hamburger-line:nth-child(1),
    .mobile-menu-button.open .hamburger-line:nth-child(3) {
      transform: none;
    }
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

    /* Visible by default, smooth transitions for enhancements */
    opacity: 1;
    transition: transform 350ms ease-out, filter 350ms ease-out;
  }

  /* Dock In-View: Subtle Lift and Glow (only if motion not reduced) */
  .mobile-floating-nav.in-view {
    transform: translateX(-50%) translateY(-2px);  /* Subtle lift */

    /* Enhanced Glow - Turquoise Rimlight Accent */
    filter:
      drop-shadow(0 6px 32px rgba(0, 0, 0, 0.48))
      drop-shadow(0 3px 12px rgba(0, 0, 0, 0.38))
      drop-shadow(0 0 20px rgba(0, 229, 195, 0.15));  /* Turquoise glow */
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

  /* ========================================
     HERO - Signature-Grade Mobile-First
     ======================================== */

  .hero {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;

    /* Deep Navy Gradient - #1F242A → #12161B */
    background: linear-gradient(168deg, #1F242A 0%, #12161B 100%);

    position: relative;
    overflow: hidden;

    /* Safe-Area Spacing: Top (navbar clearance), Bottom (dock clearance + 32px buffer) */
    padding-top: 140px;
    padding-bottom: calc(100px + 32px); /* Bottom dock height + safe buffer */
    padding-left: 5vw;
    padding-right: 5vw;
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

  /* Hero Container: Max Width Constraint */
  .hero-container {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
  }

  /* Hero Content: Centered Stack with Vertical Rhythm */
  .hero-content {
    position: relative;
    z-index: 1;
    text-align: center;

    /* Max text width: 680-720px on desktop; ~90% width on mobile */
    max-width: min(700px, 90vw);
    width: 100%;
    margin: 0 auto;

    /* Consistent Vertical Rhythm - Stack Gap */
    display: flex;
    flex-direction: column;
    gap: clamp(16px, 3.5vw, 32px);
  }

  /* Eyebrow/Tagline: Small and Subtle with Positive Tracking */
  .hero-eyebrow {
    font-family: 'Inter', sans-serif;
    font-size: clamp(11px, 2.2vw, 13px);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.02em;  /* Positive tracking +0.02em */

    /* WCAG AA Compliant - #797E95 on #1F242A = 4.51:1 contrast */
    color: #797E95;

    margin: 0;
    line-height: 1.4;

    /* Fade-In Animation */
    opacity: 0;
    transform: translateY(8px);
    transition: opacity 220ms ease-out, transform 220ms ease-out;
  }

  .hero-eyebrow.visible {
    opacity: 1;
    transform: translateY(0);
  }

  /* Benefit-Driven H1: Tight Tracking, Fluid Scale, 2-3 Lines on Mobile */
  .hero-headline {
    font-family: 'Inter', sans-serif;

    /* Fluid Scale: clamp(30px, 6.2vw, 56px) */
    font-size: clamp(30px, 6.2vw, 56px);
    font-weight: 700;

    /* Tight Tracking, lh ≈1.18 */
    letter-spacing: -0.01em;
    line-height: 1.18;

    /* WCAG AA Compliant - #EAF1FC on #1F242A = 13.94:1 contrast */
    color: #EAF1FC;

    margin: 0;

    /* Stack for split-line animation */
    display: flex;
    flex-direction: column;
    gap: clamp(4px, 0.8vw, 8px);
  }

  /* Split-Line Animation: Fade In + Slide Up + Un-Blur */
  .headline-line {
    display: block;

    /* Initial State */
    opacity: 0;
    transform: translateY(10px);
    filter: blur(2px);

    /* Stagger Delay: 50ms per line */
    transition:
      opacity 260ms ease-out calc(var(--line-index) * 50ms),
      transform 260ms ease-out calc(var(--line-index) * 50ms),
      filter 260ms ease-out calc(var(--line-index) * 50ms);
  }

  .headline-line.visible {
    opacity: 1;
    transform: translateY(0);
    filter: blur(0);
  }

  /* Lead Paragraph: ≤66ch, Body 16-20px, lh 1.65-1.75 */
  .hero-lead {
    font-family: 'Inter', sans-serif;

    /* Fluid Scale: clamp(16px, 2.8vw, 20px) */
    font-size: clamp(16px, 2.8vw, 20px);
    font-weight: 400;
    line-height: 1.7;

    /* WCAG AA Compliant - #A0A5BE on #1F242A = 4.75:1 contrast */
    color: #A0A5BE;

    margin: 0;

    /* Maximum 66 characters */
    max-width: 66ch;

    /* Fade After H1: 240ms (within 220-260ms spec) */
    opacity: 0;
    transform: translateY(8px);
    transition: opacity 240ms ease-out 150ms, transform 240ms ease-out 150ms;
  }

  .hero-lead.visible {
    opacity: 1;
    transform: translateY(0);
  }

  /* CTA Group: Single Primary Button with Safe-Area Separation from Dock */
  .hero-cta-group {
    display: flex;
    justify-content: center;
    align-items: center;

    /* Separation from Bottom Dock: 24-32px + safe-area-inset-bottom */
    margin-bottom: max(28px, env(safe-area-inset-bottom, 0px));

    /* Visible by default - GSAP will handle animation */
    opacity: 1;
    transform: translateY(0);
    filter: blur(0);
  }

  /* Fallback for reduced motion: no animation needed */
  .hero-cta-group.visible {
    opacity: 1;
    transform: translateY(0);
    filter: blur(0);
  }

  /* ========================================
     CTA BUTTON - Signature-Grade Cuervo 2025
     ======================================== */

  /* CSS Custom Properties (Design Tokens) */
  :root {
    --cta-py: 19px;        /* Refined: 19px (was 18px) */
    --cta-px: 28px;
    --cta-radius: 20px;
    --cta-shadow: 0 8px 22px rgba(0, 0, 0, 0.25);
    --cta-focus: #C7D1F6;

    /* Duration Tokens - Refined Timing */
    --t-fast: 140ms;       /* Refined: pressed 140ms (was 120ms) */
    --t-med: 190ms;        /* Refined: hover 190ms (was 180ms) */
    --t-mount: 300ms;      /* Mount animation */
    --t-large: 320ms;

    /* Material Tokens - Glass-Metal Homologation */
    --glass-blur: 18px;    /* Refined: 18px (was 17px) */
    --glass-sat: 110%;
    --glow-turquoise: rgba(0, 229, 195, 0.12);  /* #00E5C3 @ 12% */
    --bevel-color: rgba(160, 165, 190, 0.85);   /* #A0A5BE @ 85% */
    --inner-diffuser: rgba(199, 209, 246, 0.06); /* Inner matte diffuser */

    /* Easing: Pleasant ease-out */
    --ease-out: cubic-bezier(0.2, 0.8, 0.2, 1);
  }

  /* Hero CTA Button: Signature-Grade Rounded Rectangle */
  .btn-hero {
    display: inline-flex;
    align-items: center;
    justify-content: center;

    /* Icon gap: 12-16px (using 14px) */
    gap: 14px;

    /* Tap Target ≥44×44pt: padding 18px vertical, 28px horizontal */
    min-height: 44px;
    padding: var(--cta-py) var(--cta-px);

    font-family: 'Inter', -apple-system, system-ui, sans-serif;
    font-size: 17px;
    font-weight: 600;

    /* Tight tracking: -0.3% ~ -0.5% (using -0.4%) */
    letter-spacing: -0.004em;

    /* Line-height ≈1.18 for multi-line support */
    line-height: 1.18;

    /* Text can wrap to 2 lines: 26-30ch per line */
    text-align: center;
    max-width: 30ch;  /* ~510px at 17px = ~30 characters per line */

    /* Rounded 18-20px (using 20px) */
    border-radius: var(--cta-radius);

    text-decoration: none;
    cursor: pointer;
    white-space: normal;  /* Allow line breaks */

    /* Smooth transitions: 180-200ms ease-out */
    transition:
      transform var(--t-med) var(--ease-out),
      filter var(--t-med) var(--ease-out),
      box-shadow var(--t-med) var(--ease-out);
  }

  /* Icon Arrow Styling with Optical Margin */
  .btn-hero :global(svg) {
    /* Icon size: 20-22px (using 21px) */
    width: 21px;
    height: 21px;

    /* Optical margin: 1-2px hacia derecha */
    margin-right: -2px;

    /* Icon inherits smooth transition */
    transition: transform var(--t-med) var(--ease-out);
  }

  /* Primary CTA: Glass-Metal Dual-Chamber - Homologated with Dock */
  .btn-hero-primary {
    /* Dual-Chamber Frosted Glass: Dark Gradient (Matching Dock) */
    /* Top #1F242A → Bottom #12161B @ 80% translucency */
    background: linear-gradient(168deg, rgba(31, 36, 42, 0.8) 0%, rgba(18, 22, 27, 0.8) 100%);
    backdrop-filter: blur(var(--glass-blur)) saturate(var(--glass-sat));
    -webkit-backdrop-filter: blur(var(--glass-blur)) saturate(var(--glass-sat));

    /* WCAG AA Contrast: #EAF1FC on dark glass = 13.94:1 */
    color: #EAF1FC;

    /* Inner Bevel: 1.2px rim in #A0A5BE (Refined from 1.5px) */
    border: 1.2px solid var(--bevel-color);
    background-clip: padding-box;

    position: relative;
    overflow: visible;

    /* Unified Scene Lighting: Top Specular + Keylight 45° + Turquoise Rimlight 225° + AO */
    box-shadow:
      /* Top Specular Reflection (NEW - adds crisp top edge) */
      inset 0 1px 2px rgba(255, 255, 255, 0.15),

      /* Keylight Cool Top-Left 45° (#EAF1FC 10-14%, using 12%) */
      inset 1.5px 1.5px 3px rgba(234, 241, 252, 0.12),
      inset 0.5px 0.5px 1.5px rgba(234, 241, 252, 0.08),

      /* Rimlight Turquoise Bottom-Right 225° (#00E5C3) */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.1),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.06),

      /* Subtle Ambient Occlusion (edges) */
      inset 0 0 8px rgba(0, 0, 0, 0.08),

      /* Outer Turquoise Glow: 10-12px @ 12-16% (#00E5C3) */
      0 0 10px var(--glow-turquoise),
      0 0 16px rgba(0, 229, 195, 0.08),

      /* Outer Depth Shadow for Base Elevation */
      0 8px 22px rgba(0, 0, 0, 0.25),
      0 3px 12px rgba(0, 0, 0, 0.28),
      0 1px 6px rgba(0, 0, 0, 0.22);
  }

  /* Inner Matte Diffuser Layer: Cool Tint for Dual-Chamber Effect */
  .btn-hero-primary::before {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: calc(var(--cta-radius) - 1.5px);

    /* Inner matte diffuser with cool tint (rgba(199,209,246,0.06)) */
    background: var(--inner-diffuser);

    /* Inner white stroke for contrast boost */
    box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.11);
    pointer-events: none;
  }

  /* Hover State: 190ms ease-out */
  .btn-hero-primary:hover {
    /* Brighten +8% */
    filter: brightness(1.08);

    /* Elevation +1 (soft lift) */
    transform: translateY(-1px);

    /* Enhanced Lighting + Glow Intensifies +20% */
    box-shadow:
      /* Enhanced Top Specular */
      inset 0 1px 2px rgba(255, 255, 255, 0.18),

      /* Enhanced Keylight */
      inset 1.5px 1.5px 3px rgba(234, 241, 252, 0.14),
      inset 0.5px 0.5px 1.5px rgba(234, 241, 252, 0.1),

      /* Enhanced Rimlight */
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.12),
      inset -0.5px -0.5px 1.5px rgba(0, 229, 195, 0.08),

      /* AO */
      inset 0 0 8px rgba(0, 0, 0, 0.08),

      /* Intensified Turquoise Glow +20% (from 12% to ~14.4%) */
      0 0 12px rgba(0, 229, 195, 0.144),
      0 0 18px rgba(0, 229, 195, 0.096),

      /* Elevated Depth Shadow */
      var(--cta-shadow),
      0 4px 12px rgba(0, 0, 0, 0.18);
  }

  /* Arrow Slides +3px on Hover */
  .btn-hero-primary:hover :global(svg) {
    transform: translateX(3px);
  }

  /* Pressed State: 140ms, scale(0.985) */
  .btn-hero-primary:active {
    /* Pressed scale 0.985 */
    transform: translateY(0) scale(0.985);
    filter: brightness(1.04);

    /* Transition override for faster pressed feedback */
    transition:
      transform var(--t-fast) var(--ease-out),
      filter var(--t-fast) var(--ease-out),
      box-shadow var(--t-fast) var(--ease-out);

    /* Pressed Shadow: Shorter, Base Level (no outer glow) */
    box-shadow:
      /* Top Specular (maintained) */
      inset 0 1px 2px rgba(255, 255, 255, 0.15),

      /* Base Inner Lighting */
      inset 1.5px 1.5px 3px rgba(234, 241, 252, 0.12),
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.1),
      inset 0 0 8px rgba(0, 0, 0, 0.08),

      /* Shorter Depth Shadow */
      0 2px 8px rgba(0, 0, 0, 0.22);
  }

  /* Focus State: 2px Ring #C7D1F6 + 2px Offset (Always Visible for Keyboard) */
  .btn-hero-primary:focus-visible {
    outline: none;

    /* Focus Ring + Turquoise Glow Preserved */
    box-shadow:
      /* Focus Ring - 2px #C7D1F6 with 2px offset */
      0 0 0 2px rgba(31, 36, 42, 1),  /* Background gap */
      0 0 0 4px var(--cta-focus),  /* Actual ring */
      0 0 16px rgba(199, 209, 246, 0.6),

      /* Top Specular Preserved */
      inset 0 1px 2px rgba(255, 255, 255, 0.15),

      /* Inner Lighting Preserved */
      inset 1.5px 1.5px 3px rgba(234, 241, 252, 0.12),
      inset -1.5px -1.5px 3px rgba(0, 229, 195, 0.1),
      inset 0 0 8px rgba(0, 0, 0, 0.08),

      /* Turquoise Glow Preserved */
      0 0 10px var(--glow-turquoise),
      0 0 16px rgba(0, 229, 195, 0.08),

      /* Outer Depth */
      0 8px 22px rgba(0, 0, 0, 0.25),
      0 3px 12px rgba(0, 0, 0, 0.28);
  }

  /* Disabled State: 60% Opacity, No Specular Highlights */
  .btn-hero-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    pointer-events: none;

    /* Remove Specular Highlights - Keep Only Base AO */
    box-shadow:
      inset 0 0 8px rgba(0, 0, 0, 0.12),
      0 2px 8px rgba(0, 0, 0, 0.18);

    /* Disable Hover/Active Effects */
    filter: none;
    transform: none;
  }

  /* ========================================
     MOTION PREFERENCES
     ======================================== */

  @media (prefers-reduced-motion: reduce) {
    .hero-eyebrow,
    .headline-line,
    .hero-lead,
    .hero-cta-group {
      /* Replace with Short Opacity Transitions */
      transition: opacity 150ms ease-out;
      opacity: 1;
      transform: none;
      filter: none;
    }

    /* CTA Button: Replace Transforms with Brief Opacity (160ms) */
    .btn-hero {
      transition: opacity 160ms ease-out, box-shadow 160ms ease-out;
    }

    .btn-hero-primary:hover,
    .btn-hero-primary:active {
      transform: none !important;
      filter: brightness(1.05);  /* Subtle brightness only */
    }

    .btn-hero-primary:hover :global(svg),
    .btn-hero-primary:active :global(svg) {
      transform: none !important;  /* No arrow nudge */
    }

    /* Disable CTA scroll-based fade & slide */
    .hero-cta-group {
      opacity: 1 !important;
      transform: translateY(0) !important;
      filter: none !important;  /* Disable blur effect */
    }

    /* Disable Heavy Motion: Parallax Background */
    .hero-bg {
      transform: none !important;
    }

    /* Disable Heavy Motion: Dock Lift and Glow */
    .mobile-floating-nav {
      transform: translateX(-50%) !important;
      transition: none;
    }

    .mobile-floating-nav.in-view {
      /* No lift or glow effects, keep base shadow */
      transform: translateX(-50%) !important;
      filter: drop-shadow(0 4px 28px rgba(0, 0, 0, 0.45))
              drop-shadow(0 2px 8px rgba(0, 0, 0, 0.35));
    }
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
