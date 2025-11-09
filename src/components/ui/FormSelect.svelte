<script>
  import { fly, scale } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export let label = '';
  export let id = '';
  export let value = '';
  export let required = false;
  export let error = '';
  export let touched = false;
  export let disabled = false;
  export let options = [];

  let focused = false;
  let select;

  $: showError = touched && error;

  function handleFocus() {
    focused = true;
  }

  function handleBlur() {
    focused = false;
    touched = true;
  }

  function handleChange(e) {
    value = e.target.value;
  }

  export function focus() {
    select?.focus();
  }
</script>

<div class="form-select" class:focused class:error={showError}>
  <label for={id} class="form-label">
    {label}
    {#if required}<span class="required">*</span>{/if}
  </label>

  <div class="select-wrapper">
    <select
      bind:this={select}
      {id}
      {required}
      {disabled}
      value={value}
      on:change={handleChange}
      on:focus={handleFocus}
      on:blur={handleBlur}
      class:error={showError}
    >
      {#each options as option}
        <option value={option.value}>{option.label}</option>
      {/each}
    </select>

    <div class="select-arrow" class:error={showError}>
      <svg width="12" height="8" viewBox="0 0 12 8" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M1 1L6 6L11 1" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
      </svg>
    </div>

    {#if showError}
      <div class="error-icon" in:scale={{ duration: 200, easing: cubicOut }}>
        <svg
          width="16"
          height="16"
          viewBox="0 0 16 16"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <circle cx="8" cy="8" r="7" stroke="currentColor" stroke-width="2" />
          <path d="M8 4V9" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
          <circle cx="8" cy="12" r="1" fill="currentColor" />
        </svg>
      </div>
    {/if}
  </div>

  {#if showError}
    <p class="error-message" in:fly={{ y: -10, duration: 200, easing: cubicOut }}>
      {error}
    </p>
  {/if}
</div>

<style>
  .form-select {
    position: relative;
    margin-bottom: 1.5rem;
  }

  .form-label {
    display: block;
    font-size: 0.875rem;
    font-weight: 600;
    color: #f5f7fa;
    margin-bottom: 0.5rem;
    transition: color 0.2s ease;
  }

  .form-select.focused .form-label {
    color: #00cfff;
  }

  .form-select.error .form-label {
    color: #ff4757;
  }

  .required {
    color: #ff4757;
    margin-left: 0.25rem;
  }

  .select-wrapper {
    position: relative;
  }

  select {
    width: 100%;
    padding: 0.875rem 2.5rem 0.875rem 1rem;
    font-size: 0.9375rem;
    color: #f5f7fa;
    background: rgba(255, 255, 255, 0.05);
    border: 2px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-family: inherit;
    cursor: pointer;
    appearance: none;
  }

  select:focus {
    outline: none;
    background: rgba(255, 255, 255, 0.08);
    border-color: #00cfff;
    box-shadow: 0 0 0 3px rgba(0, 207, 255, 0.1);
  }

  select.error {
    border-color: #ff4757;
    background: rgba(255, 71, 87, 0.05);
  }

  select.error:focus {
    box-shadow: 0 0 0 3px rgba(255, 71, 87, 0.1);
  }

  select:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    background: rgba(255, 255, 255, 0.02);
  }

  .select-arrow {
    position: absolute;
    right: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: rgba(255, 255, 255, 0.6);
    pointer-events: none;
    transition: all 0.3s ease;
  }

  .form-select.focused .select-arrow {
    color: #00cfff;
  }

  .select-arrow.error {
    color: #ff4757;
  }

  .error-icon {
    position: absolute;
    right: 3rem;
    top: 50%;
    transform: translateY(-50%);
    color: #ff4757;
    pointer-events: none;
  }

  .error-message {
    display: flex;
    align-items: center;
    gap: 0.375rem;
    margin-top: 0.5rem;
    font-size: 0.8125rem;
    color: #ff4757;
    line-height: 1.4;
  }

  /* Animations */
  @keyframes shake {
    0%,
    100% {
      transform: translateX(0);
    }
    25% {
      transform: translateX(-4px);
    }
    75% {
      transform: translateX(4px);
    }
  }

  .form-select.error select {
    animation: shake 0.4s ease;
  }
</style>
