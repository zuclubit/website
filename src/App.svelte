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
    Check
  } from 'lucide-svelte';

  // Services data
  const services = [
    {
      icon: Building2,
      title: 'Architecture & Design',
      description: 'Software, data, infrastructure, integration, and security architecture for enterprise systems.',
      tags: ['Microservices', 'Cloud Native', 'Event-Driven'],
    },
    {
      icon: Settings,
      title: 'DevOps & Operations',
      description: 'DevOps, SecOps, MLOps, DataOps, FinOps, and AIOps implementation with continuous delivery.',
      tags: ['CI/CD', 'IaC', 'Automation'],
    },
    {
      icon: Brain,
      title: 'AI & Machine Learning',
      description: 'Artificial intelligence, machine learning, data science, and predictive analytics solutions.',
      tags: ['Deep Learning', 'NLP', 'Computer Vision'],
    },
    {
      icon: Cloud,
      title: 'Cloud Computing',
      description: 'Multi-cloud, hybrid cloud, edge computing architecture and migration services.',
      tags: ['AWS', 'Azure', 'GCP'],
    },
    {
      icon: Shield,
      title: 'Cybersecurity',
      description: 'Security audits, penetration testing, compliance, and threat detection systems.',
      tags: ['Zero Trust', 'SIEM', 'SOC'],
    },
    {
      icon: TrendingUp,
      title: 'Digital Transformation',
      description: 'IT consulting, process automation, business intelligence, and enterprise modernization.',
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
      category: 'Data',
      items: ['Data Architecture', 'Big Data', 'Data Warehousing', 'Real-time Analytics'],
    },
    {
      category: 'IoT & Innovation',
      items: ['IoT Platforms', 'AR/VR', 'Robotics', 'Blockchain'],
    },
  ];

  // Success metrics
  const metrics = [
    { value: '100+', label: 'Enterprise Clients' },
    { value: '99.9%', label: 'System Uptime' },
    { value: '40%', label: 'Avg. Cost Reduction' },
    { value: '24/7', label: 'Support Coverage' },
  ];

  // Contact form
  let formData = {
    name: '',
    email: '',
    company: '',
    service: 'architecture',
    message: '',
  };

  let formStatus = null;

  async function handleSubmit(e) {
    e.preventDefault();
    formStatus = 'sending';

    // Simulate submission
    setTimeout(() => {
      formStatus = 'success';
      formData = { name: '', email: '', company: '', service: 'architecture', message: '' };
      setTimeout(() => {
        formStatus = null;
      }, 5000);
    }, 1500);
  }
</script>

<!-- Hero Section -->
<section class="hero">
  <div class="container">
    <div class="hero-content" in:fade={{ duration: 800 }}>
      <div class="brand-container">
        <h1 class="brand">ZUCLUBIT</h1>
        <p class="tagline">The Living Code</p>
      </div>
      <h2 class="headline">Enterprise Technology Solutions That Transform Business</h2>
      <p class="subheadline">
        We architect, implement, and optimize cutting-edge technology ecosystems. From AI-powered automation
        to cloud-native infrastructure, we deliver measurable results for enterprises worldwide.
      </p>
      <div class="cta-group">
        <a href="#contact" class="btn btn-primary">Get Started →</a>
        <a href="#services" class="btn btn-outline">Explore Services</a>
      </div>
      <div class="trust-indicators" in:fade={{ delay: 400, duration: 800 }}>
        <span><Check size={16} class="inline-icon" /> ISO 27001 Certified</span>
        <span><Check size={16} class="inline-icon" /> 99.9% SLA</span>
        <span><Check size={16} class="inline-icon" /> 24/7 Support</span>
      </div>
    </div>
  </div>
</section>

<!-- Services Section -->
<section id="services" class="services">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Comprehensive Technology Services</h2>
      <p class="section-subtitle">
        End-to-end solutions covering the full technology lifecycle
      </p>
    </div>
    <div class="services-grid">
      {#each services as service, i}
        <div class="service-card" in:fly={{ y: 50, delay: i * 100, duration: 600 }}>
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
        </div>
      {/each}
    </div>
  </div>
</section>

<!-- Expertise Section -->
<section class="expertise">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Deep Technical Expertise</h2>
      <p class="section-subtitle">
        Specialized knowledge across modern technology stacks
      </p>
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
  </div>
</section>

<!-- Standards & Compliance Section -->
<section class="standards">
  <div class="container">
    <div class="section-header">
      <h2 class="section-title">Standards & Compliance</h2>
      <p class="section-subtitle">
        Certified expertise in industry-leading frameworks
      </p>
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
  </div>
</section>

<!-- Metrics Section -->
<section class="metrics">
  <div class="container">
    <div class="metrics-grid">
      {#each metrics as metric}
        <div class="metric-item">
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
      <p class="section-subtitle">
        Ready to transform your technology infrastructure? Let's talk.
      </p>
    </div>
    <div class="contact-container">
      <div class="contact-info">
        <h3>Why Choose Zuclubit?</h3>
        <ul class="benefits-list">
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>Proven track record with 100+ enterprise clients</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>Certified experts in 20+ technologies</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>Guaranteed 99.9% uptime SLA</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>24/7 technical support and monitoring</span>
          </li>
          <li>
            <span class="check"><CheckCircle2 size={20} /></span>
            <span>ISO 27001 & NIST compliant processes</span>
          </li>
        </ul>
      </div>
      <form class="contact-form" on:submit={handleSubmit}>
        <div class="form-group">
          <label for="name">Full Name *</label>
          <input type="text" id="name" bind:value={formData.name} required placeholder="John Doe" />
        </div>
        <div class="form-group">
          <label for="email">Business Email *</label>
          <input type="email" id="email" bind:value={formData.email} required placeholder="john@company.com" />
        </div>
        <div class="form-group">
          <label for="company">Company *</label>
          <input type="text" id="company" bind:value={formData.company} required placeholder="Your Company" />
        </div>
        <div class="form-group">
          <label for="service">Service Interest *</label>
          <select id="service" bind:value={formData.service} required>
            <option value="architecture">Architecture & Design</option>
            <option value="devops">DevOps & Operations</option>
            <option value="ai">AI & Machine Learning</option>
            <option value="cloud">Cloud Computing</option>
            <option value="security">Cybersecurity</option>
            <option value="transformation">Digital Transformation</option>
            <option value="consulting">General Consulting</option>
          </select>
        </div>
        <div class="form-group">
          <label for="message">Tell us about your project (optional)</label>
          <textarea id="message" bind:value={formData.message} rows="4" placeholder="Brief description of your needs..."></textarea>
        </div>
        <button type="submit" class="btn btn-primary" disabled={formStatus === 'sending'}>
          {#if formStatus === 'sending'}
            Sending...
          {:else if formStatus === 'success'}
            <Check size={20} class="inline-icon" /> Message Sent
          {:else}
            Request Consultation
          {/if}
        </button>
        {#if formStatus === 'success'}
          <p class="success-message" transition:fade>
            Thank you! We'll contact you within 24 hours.
          </p>
        {/if}
      </form>
    </div>
  </div>
</section>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="footer-content">
      <div class="footer-brand">
        <div class="footer-logo">ZUCLUBIT</div>
        <p class="footer-tagline">The Living Code</p>
        <p class="footer-description">
          Enterprise technology solutions that drive digital transformation.
        </p>
      </div>
      <div class="footer-links">
        <div class="footer-column">
          <h4>Services</h4>
          <ul>
            <li><a href="#services">Architecture</a></li>
            <li><a href="#services">DevOps</a></li>
            <li><a href="#services">AI & ML</a></li>
            <li><a href="#services">Cloud</a></li>
          </ul>
        </div>
        <div class="footer-column">
          <h4>Company</h4>
          <ul>
            <li><a href="#about">About Us</a></li>
            <li><a href="#contact">Contact</a></li>
            <li><a href="#careers">Careers</a></li>
          </ul>
        </div>
        <div class="footer-column">
          <h4>Resources</h4>
          <ul>
            <li><a href="#blog">Blog</a></li>
            <li><a href="#case-studies">Case Studies</a></li>
            <li><a href="#docs">Documentation</a></li>
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
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
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

  /* Hero */
  .hero {
    min-height: 100vh;
    display: flex;
    align-items: center;
    background: linear-gradient(135deg, #0b0e11 0%, #1c2024 100%);
    position: relative;
    overflow: hidden;
  }

  .hero::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -50%;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle, rgba(0, 207, 255, 0.15) 0%, transparent 70%);
    animation: pulse 8s ease-in-out infinite;
  }

  @keyframes pulse {
    0%, 100% { transform: scale(1); opacity: 0.5; }
    50% { transform: scale(1.1); opacity: 0.8; }
  }

  .hero-content {
    position: relative;
    z-index: 1;
    text-align: center;
    max-width: 900px;
    margin: 0 auto;
  }

  .brand-container {
    margin-bottom: 2rem;
  }

  .brand {
    font-family: 'Orbitron', monospace;
    font-size: 4rem;
    font-weight: 700;
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    letter-spacing: 0.1em;
  }

  .tagline {
    font-family: 'Orbitron', monospace;
    font-size: 1.2rem;
    color: #00e5c3;
    margin-top: 0.5rem;
    letter-spacing: 0.05em;
  }

  .headline {
    font-size: 3rem;
    font-weight: 700;
    margin: 2rem 0 1.5rem;
    line-height: 1.2;
  }

  .subheadline {
    font-size: 1.25rem;
    color: #a0aec0;
    margin-bottom: 2.5rem;
    line-height: 1.7;
  }

  .cta-group {
    display: flex;
    gap: 1rem;
    justify-content: center;
    margin-bottom: 2rem;
  }

  .trust-indicators {
    display: flex;
    gap: 2rem;
    justify-content: center;
    font-size: 0.9rem;
    color: #00e5c3;
    align-items: center;
  }

  .trust-indicators span {
    display: flex;
    align-items: center;
    gap: 0.5rem;
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
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    color: #0b0e11;
  }

  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0, 207, 255, 0.4);
  }

  .btn-outline {
    background: transparent;
    border-color: rgba(255, 255, 255, 0.3);
    color: #f5f7fa;
  }

  .btn-outline:hover {
    background: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.5);
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
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
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
    transition: all 0.3s ease;
  }

  .service-card:hover {
    transform: translateY(-4px);
    border-color: #00cfff;
    box-shadow: 0 12px 30px rgba(0, 207, 255, 0.2);
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

  /* Expertise */
  .expertise {
    background: #0b0e11;
  }

  .expertise-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
  }

  .expertise-area {
    background: #1c2024;
    border-radius: 12px;
    padding: 1.5rem;
    border: 1px solid rgba(255, 255, 255, 0.05);
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
    transition: all 0.3s ease;
  }

  .standard-card:hover {
    border-color: #00cfff;
    transform: translateY(-2px);
  }

  .standard-icon {
    color: #00cfff;
    margin-bottom: 0.75rem;
    display: flex;
    justify-content: center;
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

  /* Metrics */
  .metrics {
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    color: #0b0e11;
    padding: 4rem 0;
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
    text-align: center;
  }

  .metric-value {
    font-size: 3rem;
    font-weight: 700;
    font-family: 'Orbitron', monospace;
  }

  .metric-label {
    font-size: 1rem;
    font-weight: 500;
    margin-top: 0.5rem;
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

  .footer-logo {
    font-family: 'Orbitron', monospace;
    font-size: 1.75rem;
    font-weight: 700;
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }

  .footer-tagline {
    font-family: 'Orbitron', monospace;
    color: #00e5c3;
    margin: 0.5rem 0 1rem;
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
    .brand {
      font-size: 2.5rem;
    }

    .headline {
      font-size: 2rem;
    }

    .subheadline {
      font-size: 1.1rem;
    }

    .cta-group {
      flex-direction: column;
    }

    .trust-indicators {
      flex-direction: column;
      gap: 0.5rem;
    }

    .services-grid,
    .expertise-grid,
    .standards-grid {
      grid-template-columns: 1fr;
    }

    .metrics-grid {
      grid-template-columns: repeat(2, 1fr);
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
