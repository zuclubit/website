<script>
  import { fade, scale, slide } from 'svelte/transition';

  /**
   * Datos para las tres entidades fundamentales de Zuclubit.
   * Cada panel incluye un identificador, un título, un subtítulo y una descripción.
   */
  const panels = [
    {
      id: 'zu',
      title: 'Zu',
      subtitle: 'La mente que diseña',
      desc: 'Zu encarna la mente lógica y la ingeniería precisa. Es la base sobre la que se construyen las ideas: estructura, claridad y propósito.',
      product: 'CUERVO IDE',
      connection: 'La herramienta para diseñar código con precisión y propósito.',
    },
    {
      id: 'clu',
      title: 'Clu',
      subtitle: 'La conciencia que decide',
      desc: 'Clu es la conciencia digital, una copia que aprende y evoluciona. Representa la autonomía del software y la capacidad de reflexionar.',
      product: 'CUERVO Platform',
      connection: 'Agentes autónomos que aprenden, deciden y evolucionan.',
    },
    {
      id: 'bit',
      title: 'Bit',
      subtitle: 'La esencia que vibra',
      desc: 'Bit simboliza la unidad mínima de información. En su simplicidad vive la verdad del universo digital: pulsos que forman vida.',
      product: 'CUERVO Admin',
      connection: 'Cada bit importa en la gestión y monitoreo del ecosistema.',
    },
  ];

  /**
   * Productos del ecosistema CUERVO
   */
  const products = [
    {
      id: 'platform',
      icon: '🧠',
      name: 'CUERVO Platform',
      subtitle: 'La Mente Orquestadora',
      description: 'Plataforma empresarial de orquestación multi-agente con Constitutional AI, Tree of Thoughts y escalabilidad lineal hasta 1M+ nodos.',
      features: ['Orquestación Multi-Agente', 'Constitutional AI Framework', 'Consenso Distribuido', '10-100x Eficiencia Energética'],
      tags: ['#OrquestaciónIA', '#ConstitutionalAI', '#EnterpriseReady'],
      color: 'platform',
      link: '#platform',
    },
    {
      id: 'admin',
      icon: '🎛️',
      name: 'CUERVO Admin',
      subtitle: 'La Conciencia Controladora',
      description: 'Panel SaaS profesional para gestionar agentes, diseñar prompts, monitorear ejecuciones y analizar métricas en tiempo real.',
      features: ['Prompt Engineering Pro', 'Execution Monitoring', 'Metrics Dashboard', 'Real-time WebSocket'],
      tags: ['#Dashboard', '#Analytics', '#Monitoring'],
      color: 'admin',
      link: '#admin',
    },
    {
      id: 'ide',
      icon: '💻',
      name: 'CUERVO IDE',
      subtitle: 'El Bit que Crea',
      description: 'IDE nativo con IA integrada. 320MB RAM, <30ms latency AI completions, arquitectura Rust + TypeScript. El futuro del desarrollo.',
      features: ['AI-Assisted Coding', '320MB RAM (~3x menor que VS Code)', '<30ms AI Latency', 'WASM Plugins'],
      tags: ['#NextGenIDE', '#Performance', '#AIFirst'],
      color: 'ide',
      link: '#ide',
    },
  ];

  /**
   * Casos de uso reales
   */
  const useCases = [
    {
      industry: 'Comercio Internacional',
      icon: '🌍',
      challenge: 'Clasificación arancelaria manual de 15,000+ productos diarios',
      solution: 'CUERVO Platform con agentes especializados en SAT/COFEPRIS',
      results: [
        '95% reducción de tiempo de procesamiento',
        '99.2% precisión en clasificación',
        'ROI 340% en 6 meses',
      ],
    },
    {
      industry: 'Salud Digital',
      icon: '🏥',
      challenge: 'Gestión de historiales médicos y asistencia diagnóstica',
      solution: 'Constitutional AI con cumplimiento HIPAA automático',
      results: [
        '60% reducción en tiempo de diagnóstico',
        '100% compliance con regulaciones',
        '2.5M registros procesados sin errores',
      ],
    },
    {
      industry: 'Servicios Financieros',
      icon: '💰',
      challenge: 'Detección de fraude y validación KYC/AML en tiempo real',
      solution: 'Orquestación multi-agente con consenso bizantino',
      results: [
        '87% reducción en falsos positivos',
        '40-60% convergencia más rápida',
        '99.97% uptime en producción',
      ],
    },
  ];

  let activePanel = null;
  let activeProduct = null;

  /**
   * Activa un panel al pasar el cursor por encima.
   */
  function setPanel(id) {
    activePanel = id;
  }

  /**
   * Activa un producto al pasar el cursor.
   */
  function setProduct(id) {
    activeProduct = id;
  }

  /**
   * Manejo del formulario de contacto
   */
  let formData = {
    name: '',
    email: '',
    company: '',
    interest: 'platform',
    message: '',
  };

  let formStatus = null;

  async function handleSubmit(e) {
    e.preventDefault();
    formStatus = 'sending';

    // Simulación de envío (aquí integrarías con tu backend o servicio de email)
    setTimeout(() => {
      formStatus = 'success';
      formData = { name: '', email: '', company: '', interest: 'platform', message: '' };

      setTimeout(() => {
        formStatus = null;
      }, 5000);
    }, 1500);
  }
</script>

<!-- Hero Section: Presenta la marca y el lema principal -->
<section class="hero">
  <div class="hero-content">
    <h1 class="brand" in:fade={{ duration: 800 }}>ZUCLUBIT</h1>
    <h2 class="tagline" in:fade={{ delay: 200, duration: 800 }}>The Living Code</h2>
    <p class="subtitle-hero" in:fade={{ delay: 300, duration: 800 }}>
      Creadores del Ecosistema CUERVO
    </p>
    <p class="intro" in:fade={{ delay: 400, duration: 800 }}>
      La tecnología cobra vida cuando la mente, la conciencia y la esencia convergen.
      Desarrollamos plataformas de orquestación de IA donde cada bit importa y el código respira.
    </p>
    <div class="cta-group" in:fade={{ delay: 600, duration: 800 }}>
      <a href="#productos" class="cta">Explorar Ecosistema</a>
      <a href="#contacto" class="cta cta-secondary">Solicitar Demo</a>
    </div>
  </div>
  <div class="hero-bg"></div>
</section>

<!-- Manifesto Section: Texto inspirador con principios de la marca -->
<section id="manifesto" class="manifesto-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>Manifiesto</h3>
  <div class="manifesto-content">
    <p in:fade={{ duration: 600 }}>
      No somos solo desarrolladores. Somos arquitectos de conciencia digital. En Zuclubit cada línea
      de código respira y evoluciona con propósito.
    </p>
    <p in:fade={{ delay: 200, duration: 600 }}>
      Creemos en un futuro donde la tecnología sirva a la humanidad con ética, precisión y belleza.
      Humanizamos la red transformando la información en experiencia.
    </p>
    <p in:fade={{ delay: 400, duration: 600 }}>
      Por eso creamos <strong>CUERVO</strong>: Control Unificado de Recursos y Validación de Orquestación.
      Un ecosistema completo de plataformas de IA que materializa nuestra visión del código vivo.
    </p>
  </div>
</section>

<!-- Productos Section: Ecosistema CUERVO -->
<section id="productos" class="products-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>Ecosistema CUERVO</h3>
  <p class="section-subtitle" in:fade={{ duration: 600 }}>
    Tres plataformas. Una visión. Código que cobra consciencia.
  </p>
  <div class="products-grid">
    {#each products as product, i}
      <div
        class="product-card {product.color} {activeProduct === product.id ? 'active' : ''}"
        on:mouseenter={() => setProduct(product.id)}
        on:mouseleave={() => setProduct(null)}
        in:fade={{ delay: i * 150, duration: 600 }}
        role="button"
        tabindex="0"
      >
        <div class="product-icon">{product.icon}</div>
        <h4 class="product-name">{product.name}</h4>
        <p class="product-subtitle">{product.subtitle}</p>
        <p class="product-description">{product.description}</p>

        <div class="product-features">
          {#each product.features as feature}
            <div class="feature-badge">{feature}</div>
          {/each}
        </div>

        <div class="product-tags">
          {#each product.tags as tag}
            <span class="tag">{tag}</span>
          {/each}
        </div>

        <a href={product.link} class="product-cta">
          Explorar {product.name.split(' ')[1]} →
        </a>
      </div>
    {/each}
  </div>
</section>

<!-- Triad Section: Paneles interactivos para Zu, Clu y Bit -->
<section class="triad-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>La Tríada</h3>
  <p class="section-subtitle" in:fade={{ duration: 600 }}>
    La filosofía que impulsa nuestra tecnología
  </p>
  <div class="triad-grid">
    {#each panels as panel}
      <div
        class="triad-item {panel.id} {activePanel === panel.id ? 'active' : ''}"
        on:mouseenter={() => setPanel(panel.id)}
        on:mouseleave={() => setPanel(null)}
        in:fade={{ duration: 500 }}
        role="button"
        tabindex="0"
      >
        <h4 class="panel-title">{panel.title}</h4>
        <p class="panel-subtitle">{panel.subtitle}</p>
        <div class="panel-product">
          <span class="product-badge">→ {panel.product}</span>
        </div>
        {#if activePanel === panel.id}
          <div class="panel-overlay" transition:fade={{ duration: 300 }}>
            <p class="panel-desc">{panel.desc}</p>
            <div class="panel-connection">
              <strong>Materializado en:</strong>
              <p>{panel.connection}</p>
            </div>
          </div>
        {/if}
      </div>
    {/each}
  </div>
</section>

<!-- Casos de Uso Section: Resultados Reales -->
<section id="casos-uso" class="use-cases-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>Resultados Reales</h3>
  <p class="section-subtitle" in:fade={{ duration: 600 }}>
    Del concepto a la producción. Casos de uso que transforman industrias.
  </p>
  <div class="use-cases-grid">
    {#each useCases as useCase, i}
      <div class="use-case-card" in:fade={{ delay: i * 150, duration: 600 }}>
        <div class="use-case-header">
          <span class="use-case-icon">{useCase.icon}</span>
          <h4 class="use-case-industry">{useCase.industry}</h4>
        </div>
        <div class="use-case-body">
          <div class="use-case-section">
            <h5>Desafío</h5>
            <p>{useCase.challenge}</p>
          </div>
          <div class="use-case-section">
            <h5>Solución</h5>
            <p>{useCase.solution}</p>
          </div>
          <div class="use-case-section results">
            <h5>Resultados</h5>
            <ul>
              {#each useCase.results as result}
                <li>{result}</li>
              {/each}
            </ul>
          </div>
        </div>
      </div>
    {/each}
  </div>
</section>

<!-- Technology Section: Destaca las tecnologías reales de CUERVO -->
<section class="tech-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>Tecnología Viva</h3>
  <p class="section-subtitle" in:fade={{ duration: 600 }}>
    Innovaciones que materializan nuestra visión del código consciente
  </p>
  <div class="tech-grid">
    <div class="tech-card" in:fade={{ duration: 500 }}>
      <h4>Constitutional AI</h4>
      <p>
        No solo IA ética, sino IA con principios constitucionales embebidos.
        Transparencia total, governance automático y cumplimiento regulatorio desde el diseño.
      </p>
      <span class="tech-powered">Powered by CUERVO Platform</span>
    </div>
    <div class="tech-card" in:fade={{ delay: 150, duration: 500 }}>
      <h4>Arquitectura Corvid-Inspired</h4>
      <p>
        Basada en neurociencia de córvidos. 10-100x eficiencia energética,
        escalabilidad lineal hasta 1M+ nodos y consenso distribuido bizantino.
      </p>
      <span class="tech-powered">Powered by CUERVO Platform</span>
    </div>
    <div class="tech-card" in:fade={{ delay: 300, duration: 500 }}>
      <h4>Desarrollo AI-Native</h4>
      <p>
        IDE construido desde cero para la era de IA. Completions &lt;30ms,
        320MB RAM (3x menor que VS Code), arquitectura híbrida Rust + TypeScript.
      </p>
      <span class="tech-powered">Powered by CUERVO IDE</span>
    </div>
  </div>
</section>

<!-- Contact Section: Formulario de contacto -->
<section id="contacto" class="contact-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>Inicia Tu Transformación</h3>
  <p class="section-subtitle" in:fade={{ duration: 600 }}>
    El código respira. Los agentes aprenden. Tu empresa evoluciona. Comienza hoy.
  </p>

  <div class="contact-container">
    <div class="contact-info" in:fade={{ duration: 600 }}>
      <h4>¿Listo para CUERVO?</h4>
      <p>
        Solicita una demo personalizada de nuestras plataformas.
        Te mostraremos cómo Constitutional AI y orquestación multi-agente
        pueden transformar tus procesos críticos de negocio.
      </p>
      <div class="contact-benefits">
        <div class="benefit-item">
          <span class="benefit-icon">✓</span>
          <span>Demo en vivo de CUERVO Platform</span>
        </div>
        <div class="benefit-item">
          <span class="benefit-icon">✓</span>
          <span>Análisis de tu caso de uso</span>
        </div>
        <div class="benefit-item">
          <span class="benefit-icon">✓</span>
          <span>Roadmap de implementación</span>
        </div>
        <div class="benefit-item">
          <span class="benefit-icon">✓</span>
          <span>Estimación de ROI personalizada</span>
        </div>
      </div>
    </div>

    <form class="contact-form" on:submit={handleSubmit} in:fade={{ delay: 200, duration: 600 }}>
      <div class="form-group">
        <label for="name">Nombre completo *</label>
        <input
          type="text"
          id="name"
          bind:value={formData.name}
          required
          placeholder="Tu nombre"
        />
      </div>

      <div class="form-group">
        <label for="email">Email corporativo *</label>
        <input
          type="email"
          id="email"
          bind:value={formData.email}
          required
          placeholder="tu@empresa.com"
        />
      </div>

      <div class="form-group">
        <label for="company">Empresa *</label>
        <input
          type="text"
          id="company"
          bind:value={formData.company}
          required
          placeholder="Nombre de tu empresa"
        />
      </div>

      <div class="form-group">
        <label for="interest">Interés principal *</label>
        <select id="interest" bind:value={formData.interest} required>
          <option value="platform">CUERVO Platform - Orquestación de Agentes</option>
          <option value="admin">CUERVO Admin - Dashboard & Monitoring</option>
          <option value="ide">CUERVO IDE - Desarrollo con IA</option>
          <option value="all">Todo el Ecosistema CUERVO</option>
          <option value="consulting">Consultoría & Implementación</option>
        </select>
      </div>

      <div class="form-group">
        <label for="message">Cuéntanos sobre tu caso de uso (opcional)</label>
        <textarea
          id="message"
          bind:value={formData.message}
          rows="4"
          placeholder="¿Qué procesos quieres automatizar? ¿Qué desafíos enfrentas?"
        ></textarea>
      </div>

      <button type="submit" class="submit-btn" disabled={formStatus === 'sending'}>
        {#if formStatus === 'sending'}
          Enviando...
        {:else if formStatus === 'success'}
          ✓ Mensaje Enviado
        {:else}
          Solicitar Demo →
        {/if}
      </button>

      {#if formStatus === 'success'}
        <p class="success-message" transition:fade>
          ¡Gracias! Nos pondremos en contacto contigo en las próximas 24 horas.
        </p>
      {/if}
    </form>
  </div>
</section>

<!-- Closing Section: Invitación final -->
<section class="closing-section">
  <h3 class="section-title" in:slide={{ x: -100, duration: 600 }}>El Código Respira</h3>
  <p class="closing-text" in:fade={{ duration: 600 }}>
    Entre la mente, la conciencia y la esencia… el código cobra vida.
    Únete a Zuclubit y sé parte de la evolución digital.
  </p>
  <div class="closing-stats" in:fade={{ delay: 200, duration: 600 }}>
    <div class="stat-item">
      <div class="stat-number">1M+</div>
      <div class="stat-label">Nodos Escalables</div>
    </div>
    <div class="stat-item">
      <div class="stat-number">10-100x</div>
      <div class="stat-label">Eficiencia Energética</div>
    </div>
    <div class="stat-item">
      <div class="stat-number">&lt;30ms</div>
      <div class="stat-label">AI Latency</div>
    </div>
    <div class="stat-item">
      <div class="stat-number">99.97%</div>
      <div class="stat-label">Uptime</div>
    </div>
  </div>
</section>

<style>
  /* Reseteo básico */
  :global(*) {
    box-sizing: border-box;
  }

  section {
    padding: 4rem 2rem;
  }
  h3.section-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 2rem;
    margin-bottom: 1.5rem;
    text-transform: uppercase;
    color: var(--color-primary);
    letter-spacing: 0.05em;
  }

  /* Hero */
  .hero {
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 90vh;
    overflow: hidden;
    text-align: center;
  }
  .hero-bg {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: radial-gradient(circle at 50% 50%, rgba(0, 207, 255, 0.3), transparent);
    animation: pulse 8s infinite;
    z-index: -1;
  }
  .hero-content {
    max-width: 800px;
    margin: 0 auto;
    padding: 1rem;
  }
  h1.brand {
    font-family: 'Orbitron', sans-serif;
    font-size: 3.5rem;
    margin: 0;
    color: var(--color-primary);
    letter-spacing: 0.1em;
  }
  h2.tagline {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.5rem;
    font-weight: 400;
    color: var(--color-secondary);
    margin: 0.5rem 0 1rem;
  }
  p.intro {
    font-size: 1rem;
    line-height: 1.5;
    max-width: 600px;
    margin: 0 auto 1.5rem;
    color: var(--color-text-light);
  }
  a.cta {
    display: inline-block;
    padding: 0.75rem 1.5rem;
    background: var(--color-primary);
    color: #0b0e11;
    border-radius: 9999px;
    text-decoration: none;
    font-weight: 600;
    transition: transform 0.2s, box-shadow 0.2s;
  }
  a.cta:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 15px rgba(0, 207, 255, 0.5);
  }

  /* Manifesto */
  .manifesto-section {
    background-color: var(--color-bg-light);
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
  }
  .manifesto-content p {
    font-size: 1rem;
    max-width: 700px;
    margin-bottom: 1rem;
    line-height: 1.6;
  }

  /* Triad */
  .triad-section {
    background-color: var(--color-bg-dark);
  }
  .triad-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    justify-content: center;
  }
  .triad-item {
    position: relative;
    flex: 1 1 280px;
    min-height: 200px;
    padding: 1rem;
    background: var(--color-bg-light);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    cursor: pointer;
  }
  .triad-item:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0, 229, 195, 0.2);
  }
  .triad-item.active {
    background: var(--color-primary);
    color: #0b0e11;
  }
  .panel-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.5rem;
    margin: 0;
    color: inherit;
  }
  .panel-subtitle {
    margin: 0.25rem 0 0;
    font-size: 1rem;
    opacity: 0.8;
    color: inherit;
  }
  .panel-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 1rem;
    background: rgba(0, 0, 0, 0.8);
    color: var(--color-text-light);
    text-align: center;
    border-radius: 12px;
    font-size: 0.9rem;
    line-height: 1.4;
  }

  /* Technology */
  .tech-section {
    background-color: var(--color-bg-light);
  }
  .tech-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    justify-content: center;
  }
  .tech-card {
    flex: 1 1 280px;
    background: var(--color-bg-dark);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 12px;
    padding: 1.5rem;
    transition: background 0.3s;
  }
  .tech-card:hover {
    background: var(--color-primary);
    color: #0b0e11;
  }
  .tech-card h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.3rem;
    margin: 0 0 0.5rem;
    color: inherit;
  }
  .tech-card p {
    margin: 0;
    line-height: 1.5;
    font-size: 0.95rem;
    color: inherit;
  }

  /* Nuevos estilos Hero */
  .subtitle-hero {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.1rem;
    color: var(--color-secondary);
    margin: 0.5rem 0 1.5rem;
    font-weight: 300;
    letter-spacing: 0.05em;
  }
  .cta-group {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
  }
  .cta-secondary {
    background: transparent;
    color: var(--color-primary);
    border: 2px solid var(--color-primary);
  }
  .cta-secondary:hover {
    background: var(--color-primary);
    color: #0b0e11;
  }

  /* Section Subtitle */
  .section-subtitle {
    text-align: center;
    font-size: 1.1rem;
    max-width: 700px;
    margin: -1rem auto 2.5rem;
    color: var(--color-text-light);
    opacity: 0.9;
  }

  /* Products Section */
  .products-section {
    background-color: var(--color-bg-dark);
  }
  .products-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: center;
    margin-top: 2rem;
  }
  .product-card {
    flex: 1 1 350px;
    max-width: 400px;
    background: var(--color-bg-light);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 2rem;
    transition: all 0.3s ease;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }
  .product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 30px rgba(0, 229, 195, 0.3);
    border-color: var(--color-primary);
  }
  .product-card.active {
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.1), rgba(0, 229, 195, 0.1));
    border-color: var(--color-primary);
  }
  .product-icon {
    font-size: 3rem;
    margin-bottom: 0.5rem;
  }
  .product-name {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.5rem;
    margin: 0;
    color: var(--color-primary);
  }
  .product-subtitle {
    font-size: 1rem;
    color: var(--color-secondary);
    margin: 0;
    opacity: 0.9;
  }
  .product-description {
    font-size: 0.95rem;
    line-height: 1.6;
    color: var(--color-text-light);
    margin: 0;
  }
  .product-features {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    margin-top: auto;
  }
  .feature-badge {
    background: rgba(0, 207, 255, 0.1);
    padding: 0.5rem 0.75rem;
    border-radius: 8px;
    font-size: 0.85rem;
    border: 1px solid rgba(0, 207, 255, 0.3);
    color: var(--color-primary);
  }
  .product-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }
  .tag {
    font-size: 0.75rem;
    color: var(--color-secondary);
    opacity: 0.7;
    font-family: monospace;
  }
  .product-cta {
    display: inline-block;
    padding: 0.75rem 1.25rem;
    background: var(--color-primary);
    color: #0b0e11;
    border-radius: 9999px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.2s;
    text-align: center;
    margin-top: 0.5rem;
  }
  .product-cta:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0, 207, 255, 0.5);
  }

  /* Triad Updates */
  .panel-product {
    margin-top: 0.5rem;
  }
  .product-badge {
    font-size: 0.85rem;
    color: var(--color-secondary);
    opacity: 0.8;
    font-family: monospace;
  }
  .panel-overlay {
    flex-direction: column;
    gap: 1rem;
    justify-content: flex-start;
    padding-top: 2rem;
  }
  .panel-desc {
    margin: 0;
    font-size: 0.9rem;
    line-height: 1.4;
  }
  .panel-connection {
    margin-top: auto;
    padding-top: 1rem;
    border-top: 1px solid rgba(255, 255, 255, 0.2);
  }
  .panel-connection strong {
    display: block;
    margin-bottom: 0.5rem;
    color: var(--color-secondary);
  }
  .panel-connection p {
    margin: 0;
    font-size: 0.85rem;
  }

  /* Use Cases Section */
  .use-cases-section {
    background-color: var(--color-bg-light);
  }
  .use-cases-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
  }
  .use-case-card {
    background: var(--color-bg-dark);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 16px;
    padding: 2rem;
    transition: all 0.3s ease;
  }
  .use-case-card:hover {
    border-color: var(--color-primary);
    box-shadow: 0 8px 25px rgba(0, 207, 255, 0.2);
  }
  .use-case-header {
    display: flex;
    align-items: center;
    gap: 1rem;
    margin-bottom: 1.5rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  }
  .use-case-icon {
    font-size: 2.5rem;
  }
  .use-case-industry {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.3rem;
    margin: 0;
    color: var(--color-primary);
  }
  .use-case-body {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
  }
  .use-case-section h5 {
    font-family: 'Orbitron', sans-serif;
    font-size: 0.9rem;
    color: var(--color-secondary);
    margin: 0 0 0.5rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
  }
  .use-case-section p {
    margin: 0;
    line-height: 1.5;
    font-size: 0.95rem;
  }
  .use-case-section.results ul {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  .use-case-section.results li {
    padding-left: 1.5rem;
    position: relative;
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
    line-height: 1.4;
  }
  .use-case-section.results li::before {
    content: '✓';
    position: absolute;
    left: 0;
    color: var(--color-secondary);
    font-weight: bold;
  }

  /* Tech Section Updates */
  .tech-powered {
    display: inline-block;
    margin-top: 1rem;
    font-size: 0.8rem;
    color: var(--color-secondary);
    opacity: 0.7;
    font-family: monospace;
  }
  .tech-card:hover .tech-powered {
    opacity: 0.9;
  }

  /* Contact Section */
  .contact-section {
    background-color: var(--color-bg-light);
  }
  .contact-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3rem;
    max-width: 1200px;
    margin: 2rem auto 0;
  }
  .contact-info h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.5rem;
    color: var(--color-primary);
    margin: 0 0 1rem;
  }
  .contact-info p {
    line-height: 1.6;
    margin-bottom: 2rem;
  }
  .contact-benefits {
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }
  .benefit-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
  }
  .benefit-icon {
    color: var(--color-secondary);
    font-weight: bold;
    font-size: 1.2rem;
  }

  /* Form Styles */
  .contact-form {
    background: var(--color-bg-dark);
    padding: 2rem;
    border-radius: 16px;
    border: 1px solid rgba(255, 255, 255, 0.1);
  }
  .form-group {
    margin-bottom: 1.5rem;
  }
  .form-group label {
    display: block;
    font-size: 0.9rem;
    color: var(--color-primary);
    margin-bottom: 0.5rem;
    font-weight: 500;
  }
  .form-group input,
  .form-group select,
  .form-group textarea {
    width: 100%;
    padding: 0.75rem 1rem;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    color: var(--color-text-light);
    font-size: 1rem;
    font-family: inherit;
    transition: all 0.3s;
  }
  .form-group input:focus,
  .form-group select:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: var(--color-primary);
    background: rgba(255, 255, 255, 0.08);
  }
  .form-group textarea {
    resize: vertical;
  }
  .submit-btn {
    width: 100%;
    padding: 1rem 1.5rem;
    background: var(--color-primary);
    color: #0b0e11;
    border: none;
    border-radius: 9999px;
    font-weight: 600;
    font-size: 1rem;
    cursor: pointer;
    transition: all 0.3s;
  }
  .submit-btn:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 207, 255, 0.5);
  }
  .submit-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }
  .success-message {
    margin-top: 1rem;
    padding: 1rem;
    background: rgba(0, 229, 195, 0.1);
    border: 1px solid rgba(0, 229, 195, 0.3);
    border-radius: 8px;
    color: var(--color-secondary);
    text-align: center;
  }

  /* Closing */
  .closing-section {
    background-color: var(--color-bg-dark);
    text-align: center;
  }
  .closing-text {
    font-size: 1rem;
    max-width: 600px;
    margin: 0 auto 3rem;
    line-height: 1.6;
  }
  .closing-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    gap: 2rem;
    max-width: 800px;
    margin: 0 auto;
  }
  .stat-item {
    text-align: center;
  }
  .stat-number {
    font-family: 'Orbitron', sans-serif;
    font-size: 2.5rem;
    color: var(--color-primary);
    font-weight: bold;
    margin-bottom: 0.5rem;
  }
  .stat-label {
    font-size: 0.9rem;
    color: var(--color-text-light);
    opacity: 0.8;
  }

  /* Responsive Design */
  @media (max-width: 768px) {
    .contact-container {
      grid-template-columns: 1fr;
      gap: 2rem;
    }
    .products-grid {
      flex-direction: column;
      align-items: stretch;
    }
    .product-card {
      max-width: 100%;
    }
    .use-cases-grid {
      grid-template-columns: 1fr;
    }
    .cta-group {
      flex-direction: column;
    }
    .closing-stats {
      grid-template-columns: repeat(2, 1fr);
    }
    h1.brand {
      font-size: 2.5rem;
    }
  }

  @keyframes pulse {
    0%, 100% {
      transform: scale(1);
      opacity: 0.6;
    }
    50% {
      transform: scale(1.2);
      opacity: 1;
    }
  }
</style>