<!--
  NavItem Component - Smart Navigation Link

  Componente de navegación reutilizable con detección automática de estado activo.

  Características:
  - Detección automática de sección activa via scroll
  - Indicador verde turquesa para sección activa
  - Animación de underline premium
  - Smooth scroll nativo
  - Arquitectura limpia (SOLID)

  @component
  @example
  <NavItem href="#services" label="Services" isActive={activeSection === 'services'} />
-->

<script>
  /**
   * URL de destino (hash para navegación)
   * @type {string}
   */
  export let href;

  /**
   * Label del nav item
   * @type {string}
   */
  export let label;

  /**
   * Estado activo (controlado por parent)
   * @type {boolean}
   */
  export let isActive = false;

  /**
   * Clases CSS adicionales
   * @type {string}
   */
  let className = '';
  export { className as class };

  /**
   * Handler de click con smooth scroll
   * @param {MouseEvent} event
   */
  function handleClick(event) {
    event.preventDefault();

    const targetId = href.replace('#', '');

    // Si es home (vacío o '/'), scroll to top
    if (href === '/' || href === '#' || targetId === '') {
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
      return;
    }

    // Buscar el elemento target
    const targetElement = document.getElementById(targetId);

    if (targetElement) {
      // Obtener la altura del navbar para offset
      const navbar = document.querySelector('.navbar');
      const navbarHeight = navbar ? navbar.offsetHeight : 0;

      // Calcular posición con offset
      const targetPosition = targetElement.offsetTop - navbarHeight - 20; // 20px extra padding

      // Smooth scroll a la posición
      window.scrollTo({
        top: targetPosition,
        behavior: 'smooth'
      });

      // Actualizar URL sin reload
      history.pushState(null, '', href);
    }
  }
</script>

<a
  {href}
  class="nav-item {isActive ? 'active' : ''} {className}"
  on:click={handleClick}
  aria-current={isActive ? 'page' : undefined}
>
  {label}
</a>

<style>
  /* Ya existe el CSS en App.svelte, este componente usa las clases globales */
  /* No necesitamos duplicar CSS aquí por arquitectura limpia */
</style>
