import App from './App.svelte';

// Monta la aplicación Svelte en el contenedor #app.
const app = new App({
  target: document.getElementById('app'),
});

export default app;