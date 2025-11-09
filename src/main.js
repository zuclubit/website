import App from './App.svelte';

// Obtener el contenedor y limpiar el contenido de carga
const target = document.getElementById('app');
target.innerHTML = '';

// Montar la aplicación Svelte
const app = new App({
  target,
});

export default app;
