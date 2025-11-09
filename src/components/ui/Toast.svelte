<script>
  import { fly, fade } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';
  import { CheckCircle2, AlertCircle, Info, X } from 'lucide-svelte';

  export let type = 'success'; // 'success', 'error', 'info'
  export let message = '';
  export let duration = 5000;
  export let onClose = () => {};

  let visible = true;
  let timeoutId;

  $: icon = type === 'success' ? CheckCircle2 : type === 'error' ? AlertCircle : Info;

  function handleClose() {
    visible = false;
    setTimeout(() => {
      onClose();
    }, 300);
  }

  if (duration > 0) {
    timeoutId = setTimeout(handleClose, duration);
  }

  function clearAutoClose() {
    if (timeoutId) {
      clearTimeout(timeoutId);
    }
  }

  function restartAutoClose() {
    if (duration > 0) {
      timeoutId = setTimeout(handleClose, duration);
    }
  }
</script>

{#if visible}
  <div
    class="toast toast-{type}"
    in:fly={{ y: -20, duration: 300, easing: cubicOut }}
    out:fade={{ duration: 200 }}
    on:mouseenter={clearAutoClose}
    on:mouseleave={restartAutoClose}
    role="alert"
  >
    <div class="toast-icon">
      <svelte:component this={icon} size={20} />
    </div>

    <p class="toast-message">{message}</p>

    <button class="toast-close" on:click={handleClose} aria-label="Close notification">
      <X size={18} />
    </button>

    {#if duration > 0}
      <div class="toast-progress" style="animation-duration: {duration}ms"></div>
    {/if}
  </div>
{/if}

<style>
  .toast {
    position: relative;
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem 1.25rem;
    background: rgba(11, 14, 17, 0.95);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(10px);
    min-width: 320px;
    max-width: 500px;
    overflow: hidden;
  }

  .toast-success {
    border-color: rgba(0, 229, 195, 0.3);
  }

  .toast-error {
    border-color: rgba(255, 71, 87, 0.3);
  }

  .toast-info {
    border-color: rgba(0, 207, 255, 0.3);
  }

  .toast-icon {
    flex-shrink: 0;
  }

  .toast-success .toast-icon {
    color: #00e5c3;
  }

  .toast-error .toast-icon {
    color: #ff4757;
  }

  .toast-info .toast-icon {
    color: #00cfff;
  }

  .toast-message {
    flex: 1;
    margin: 0;
    font-size: 0.9375rem;
    color: #f5f7fa;
    line-height: 1.5;
  }

  .toast-close {
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 24px;
    height: 24px;
    padding: 0;
    background: transparent;
    border: none;
    border-radius: 4px;
    color: rgba(255, 255, 255, 0.6);
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .toast-close:hover {
    background: rgba(255, 255, 255, 0.1);
    color: #f5f7fa;
  }

  .toast-progress {
    position: absolute;
    bottom: 0;
    left: 0;
    height: 3px;
    width: 100%;
    transform-origin: left;
    animation: shrink linear forwards;
  }

  .toast-success .toast-progress {
    background: linear-gradient(90deg, #00e5c3, #00cfff);
  }

  .toast-error .toast-progress {
    background: linear-gradient(90deg, #ff4757, #ff6348);
  }

  .toast-info .toast-progress {
    background: linear-gradient(90deg, #00cfff, #00e5c3);
  }

  @keyframes shrink {
    from {
      transform: scaleX(1);
    }
    to {
      transform: scaleX(0);
    }
  }
</style>
