<script>
  export let variant = 'primary'; // primary | secondary | outline
  export let href = null;
  export let type = 'button';
  export let disabled = false;
</script>

{#if href}
  <a {href} class="btn btn-{variant}" class:disabled>
    <slot />
  </a>
{:else}
  <button {type} class="btn btn-{variant}" {disabled} on:click>
    <slot />
  </button>
{/if}

<style>
  .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.75rem 1.75rem;
    font-weight: 600;
    font-size: 1rem;
    border-radius: 8px;
    text-decoration: none;
    border: 2px solid transparent;
    cursor: pointer;
    transition: all 0.2s ease;
    font-family: 'Inter', sans-serif;
  }

  .btn-primary {
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    color: #0b0e11;
  }

  .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0, 207, 255, 0.4);
  }

  .btn-secondary {
    background: transparent;
    border-color: #00cfff;
    color: #00cfff;
  }

  .btn-secondary:hover {
    background: rgba(0, 207, 255, 0.1);
  }

  .btn-outline {
    background: rgba(255, 255, 255, 0.05);
    border-color: rgba(255, 255, 255, 0.2);
    color: #f5f7fa;
  }

  .btn-outline:hover {
    background: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.4);
  }

  .btn:disabled,
  .btn.disabled {
    opacity: 0.5;
    cursor: not-allowed;
    transform: none;
  }
</style>
