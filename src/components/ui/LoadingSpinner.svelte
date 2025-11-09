<script>
  export let size = 'medium'; // 'small', 'medium', 'large'
  export let color = '#00cfff';
  export let text = '';
</script>

<div class="loading-spinner {size}">
  <div class="spinner" style="border-top-color: {color}"></div>
  {#if text}
    <p class="loading-text">{text}</p>
  {/if}
</div>

<style>
  .loading-spinner {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 1rem;
  }

  .spinner {
    border: 3px solid rgba(255, 255, 255, 0.1);
    border-top-color: #00cfff;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
  }

  .loading-spinner.small .spinner {
    width: 20px;
    height: 20px;
    border-width: 2px;
  }

  .loading-spinner.medium .spinner {
    width: 32px;
    height: 32px;
    border-width: 3px;
  }

  .loading-spinner.large .spinner {
    width: 48px;
    height: 48px;
    border-width: 4px;
  }

  .loading-text {
    font-size: 0.875rem;
    color: rgba(255, 255, 255, 0.7);
    margin: 0;
    animation: pulse 1.5s ease-in-out infinite;
  }

  @keyframes spin {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }

  @keyframes pulse {
    0%,
    100% {
      opacity: 0.7;
    }
    50% {
      opacity: 1;
    }
  }
</style>
