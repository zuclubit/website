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
  <!-- Expandable Menu -->
  {#if mobileMenuOpen}
    <div class="mobile-menu-expand" transition:fly={{ y: 20, duration: 300 }}>
      <div class="mobile-menu-items">
        <a href="#services" class="mobile-menu-item" on:click={toggleMobileMenu}>
          <div class="mobile-menu-item-content">
            <span>Services</span>
          </div>
        </a>
        <a href="#expertise" class="mobile-menu-item" on:click={toggleMobileMenu}>
          <div class="mobile-menu-item-content">
            <span>Expertise</span>
          </div>
        </a>
        <a href="#standards" class="mobile-menu-item" on:click={toggleMobileMenu}>
          <div class="mobile-menu-item-content">
            <span>Standards</span>
          </div>
        </a>
        <a href="#contact" class="mobile-menu-item" on:click={toggleMobileMenu}>
          <div class="mobile-menu-item-content">
            <span>Contact</span>
          </div>
        </a>
      </div>
    </div>
  {/if}

  <!-- Navigation Pill -->
  <div class="mobile-nav-pill">
    <a href="/" class="mobile-nav-btn" aria-label="Home">
      <Home size={20} strokeWidth={2} />
    </a>
    <button class="mobile-nav-btn mobile-nav-btn-primary" on:click={toggleMobileMenu} aria-label="Menu">
      {#if mobileMenuOpen}
        <X size={20} strokeWidth={2} />
      {:else}
        <Plus size={20} strokeWidth={2} />
      {/if}
    </button>
    <a href="#contact" class="mobile-nav-btn" aria-label="Contact">
      <User size={20} strokeWidth={2} />
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

  /* Mobile Floating Navbar - Glassmorphism Pill Design */
  .mobile-floating-nav {
    position: fixed;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    z-index: 999;
    display: none;
  }

  .mobile-nav-pill {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    background: rgba(31, 36, 42, 0.85);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    padding: 0.75rem 1.25rem;
    border-radius: 999px;
    border: 1px solid rgba(199, 209, 246, 0.15);
    box-shadow:
      0 10px 40px rgba(0, 0, 0, 0.4),
      0 4px 12px rgba(0, 0, 0, 0.3),
      inset 0 1px 2px rgba(255, 255, 255, 0.05);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }

  .mobile-nav-pill:hover {
    box-shadow:
      0 12px 48px rgba(0, 0, 0, 0.5),
      0 6px 16px rgba(199, 209, 246, 0.2),
      inset 0 1px 2px rgba(255, 255, 255, 0.08);
  }

  .mobile-nav-btn {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(45, 51, 60, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.05);
    color: #EAF1FC;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow:
      0 4px 12px rgba(0, 0, 0, 0.3),
      inset 0 1px 2px rgba(255, 255, 255, 0.05);
    position: relative;
    overflow: hidden;
  }

  .mobile-nav-btn::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(199, 209, 246, 0.15);
    transform: translate(-50%, -50%);
    transition:
      width 0.4s ease,
      height 0.4s ease;
  }

  .mobile-nav-btn:active::before {
    width: 100%;
    height: 100%;
  }

  .mobile-nav-btn:hover {
    background: rgba(45, 51, 60, 1);
    border-color: rgba(199, 209, 246, 0.2);
    transform: translateY(-2px);
    box-shadow:
      0 6px 16px rgba(0, 0, 0, 0.4),
      inset 0 1px 2px rgba(255, 255, 255, 0.08);
  }

  .mobile-nav-btn:active {
    transform: translateY(0);
  }

  .mobile-nav-btn-primary {
    background: linear-gradient(135deg, #C7D1F6 0%, #EAF1FC 100%);
    color: #12161B;
    border-color: transparent;
    box-shadow:
      0 6px 20px rgba(199, 209, 246, 0.4),
      0 2px 8px rgba(199, 209, 246, 0.3),
      inset 0 1px 2px rgba(255, 255, 255, 0.3);
    position: relative;
    z-index: 1;
  }

  .mobile-nav-btn-primary::after {
    content: '';
    position: absolute;
    top: 15%;
    left: 15%;
    width: 30%;
    height: 30%;
    border-radius: 50%;
    background: radial-gradient(
      circle at center,
      rgba(255, 255, 255, 0.6) 0%,
      transparent 70%
    );
    filter: blur(4px);
    pointer-events: none;
  }

  .mobile-nav-btn-primary:hover {
    background: linear-gradient(135deg, #EAF1FC 0%, #C7D1F6 100%);
    transform: translateY(-4px) scale(1.05);
    box-shadow:
      0 8px 28px rgba(199, 209, 246, 0.5),
      0 4px 12px rgba(199, 209, 246, 0.4),
      inset 0 1px 2px rgba(255, 255, 255, 0.4);
  }

  .mobile-nav-btn-primary:active {
    transform: translateY(-2px) scale(1.02);
  }

  /* Mobile Menu Expand - Glassmorphism */
  .mobile-menu-expand {
    position: absolute;
    bottom: 90px;
    left: 50%;
    transform: translateX(-50%);
    width: 280px;
    background: rgba(31, 36, 42, 0.9);
    backdrop-filter: blur(20px) saturate(180%);
    -webkit-backdrop-filter: blur(20px) saturate(180%);
    border-radius: 20px;
    border: 1px solid rgba(199, 209, 246, 0.15);
    box-shadow:
      0 12px 48px rgba(0, 0, 0, 0.5),
      0 4px 16px rgba(0, 0, 0, 0.4),
      inset 0 1px 2px rgba(255, 255, 255, 0.05);
    overflow: hidden;
  }

  .mobile-menu-items {
    display: flex;
    flex-direction: column;
    padding: 0.5rem;
    gap: 0.25rem;
  }

  .mobile-menu-item {
    display: block;
    text-decoration: none;
    color: #EAF1FC;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border-radius: 12px;
    overflow: hidden;
  }

  .mobile-menu-item-content {
    padding: 1rem 1.25rem;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(45, 51, 60, 0.5);
    border: 1px solid rgba(199, 209, 246, 0.08);
    border-radius: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
  }

  .mobile-menu-item-content::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(
      90deg,
      transparent,
      rgba(199, 209, 246, 0.1),
      transparent
    );
    transition: left 0.5s ease;
  }

  .mobile-menu-item:active .mobile-menu-item-content::before {
    left: 100%;
  }

  .mobile-menu-item-content span {
    font-family: 'Inter', sans-serif;
    font-size: 1rem;
    font-weight: 500;
    letter-spacing: 0.02em;
  }

  .mobile-menu-item:hover .mobile-menu-item-content {
    background: rgba(199, 209, 246, 0.15);
    border-color: rgba(199, 209, 246, 0.25);
    transform: scale(1.02);
    box-shadow: 0 4px 12px rgba(199, 209, 246, 0.2);
  }

  .mobile-menu-item:active .mobile-menu-item-content {
    transform: scale(0.98);
  }

  /* Hero - Corporate Identity Palette */
  .hero {
    min-height: 100vh;
    display: flex;
    align-items: center;
    background: linear-gradient(135deg, #1F242A 0%, #2D333C 100%);
    position: relative;
    overflow: hidden;
    padding-top: 120px;
    padding-bottom: 4rem;
  }

  .hero-bg {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background:
      radial-gradient(circle at 20% 50%, rgba(199, 209, 246, 0.12) 0%, transparent 50%),
      radial-gradient(circle at 80% 50%, rgba(199, 209, 246, 0.08) 0%, transparent 50%);
    animation: pulse 8s ease-in-out infinite;
    z-index: 0;
  }

  @keyframes pulse {
    0%,
    100% {
      transform: scale(1);
      opacity: 0.6;
    }
    50% {
      transform: scale(1.05);
      opacity: 1;
    }
  }

  .hero-content {
    position: relative;
    z-index: 1;
    text-align: center;
    max-width: 900px;
    margin: 0 auto;
  }

  .brand-section {
    margin-bottom: 2.5rem;
  }

  .brand-name {
    font-family: 'Inter', sans-serif;
    font-size: 4rem;
    font-weight: 700;
    background: linear-gradient(135deg, #C7D1F6 0%, #EAF1FC 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: 0.1em;
    margin: 0;
    line-height: 1;
  }

  .brand-tagline {
    font-family: 'Inter', sans-serif;
    font-size: 1.5rem;
    font-weight: 500;
    color: #C7D1F6;
    margin: 0.75rem 0 0;
    letter-spacing: 0.05em;
  }

  .headline {
    font-family: 'Inter', sans-serif;
    font-size: 2.5rem;
    font-weight: 600;
    line-height: 1.3;
    color: #EAF1FC;
    margin: 0 0 1.5rem;
    letter-spacing: -0.01em;
  }

  .subheadline {
    font-family: 'Inter', sans-serif;
    font-size: 1.2rem;
    font-weight: 400;
    line-height: 1.7;
    color: #A0A5BE;
    margin: 0 0 2.5rem;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
  }

  .cta-group {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
  }

  .btn-large {
    padding: 1rem 2rem;
    font-size: 1.05rem;
    font-weight: 600;
  }

  .btn-secondary {
    background: transparent;
    border: 2px solid #A0A5BE;
    color: #EAF1FC;
    position: relative;
    overflow: hidden;
  }

  .btn-secondary::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(199, 209, 246, 0.15);
    transform: translate(-50%, -50%);
    transition:
      width 0.6s ease,
      height 0.6s ease;
  }

  .btn-secondary:hover::before {
    width: 300px;
    height: 300px;
  }

  .btn-secondary:hover {
    background: rgba(199, 209, 246, 0.1);
    border-color: #C7D1F6;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 8px 20px rgba(199, 209, 246, 0.25);
  }

  .btn-secondary:active {
    transform: translateY(-1px) scale(1);
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

  .btn-primary {
    background: #C7D1F6;
    color: #12161B;
    position: relative;
    overflow: hidden;
    font-weight: 600;
  }

  .btn-primary::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(234, 241, 252, 0.4);
    transform: translate(-50%, -50%);
    transition:
      width 0.6s ease,
      height 0.6s ease;
  }

  .btn-primary:hover::before {
    width: 300px;
    height: 300px;
  }

  .btn-primary:hover {
    background: #EAF1FC;
    transform: translateY(-2px) scale(1.02);
    box-shadow: 0 8px 20px rgba(199, 209, 246, 0.4);
  }

  .btn-primary:active {
    transform: translateY(-1px) scale(1);
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
