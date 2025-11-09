<script>
  import { fly, scale } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export let label = '';
  export let type = 'text';
  export let id = '';
  export let value = '';
  export let placeholder = '';
  export let required = false;
  export let error = '';
  export let touched = false;
  export let disabled = false;
  export let autocomplete = '';
  export let maxlength = undefined;

  let focused = false;
  let input;

  $: showError = touched && error;
  $: hasValue = value && value.length > 0;

  function handleFocus() {
    focused = true;
  }

  function handleBlur() {
    focused = false;
    touched = true;
  }

  function handleInput(e) {
    value = e.target.value;
  }

  export function focus() {
    input?.focus();
  }
</script>

<div class="form-input" class:focused class:error={showError} class:has-value={hasValue}>
  <label for={id} class="form-label">
    {label}
    {#if required}<span class="required">*</span>{/if}
  </label>

  <div class="input-wrapper">
    <input
      bind:this={input}
      {id}
      {type}
      {placeholder}
      {required}
      {disabled}
      {autocomplete}
      {maxlength}
      value={value}
      on:input={handleInput}
      on:focus={handleFocus}
      on:blur={handleBlur}
      on:keydown
      class:error={showError}
    />

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

  {#if maxlength && hasValue}
    <p class="char-count" class:warning={value.length > maxlength * 0.9}>
      {value.length}/{maxlength}
    </p>
  {/if}
</div>

<style>
  .form-input {
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

  .form-input.focused .form-label {
    color: #00cfff;
  }

  .form-input.error .form-label {
    color: #ff4757;
  }

  .required {
    color: #ff4757;
    margin-left: 0.25rem;
  }

  .input-wrapper {
    position: relative;
  }

  input {
    width: 100%;
    padding: 0.875rem 1rem;
    font-size: 0.9375rem;
    color: #f5f7fa;
    background: rgba(255, 255, 255, 0.05);
    border: 2px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-family: inherit;
  }

  input::placeholder {
    color: rgba(255, 255, 255, 0.4);
  }

  input:focus {
    outline: none;
    background: rgba(255, 255, 255, 0.08);
    border-color: #00cfff;
    box-shadow: 0 0 0 3px rgba(0, 207, 255, 0.1);
  }

  input.error {
    border-color: #ff4757;
    background: rgba(255, 71, 87, 0.05);
  }

  input.error:focus {
    box-shadow: 0 0 0 3px rgba(255, 71, 87, 0.1);
  }

  input:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    background: rgba(255, 255, 255, 0.02);
  }

  .error-icon {
    position: absolute;
    right: 1rem;
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

  .char-count {
    text-align: right;
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.5);
    margin-top: 0.375rem;
    transition: color 0.2s ease;
  }

  .char-count.warning {
    color: #ffa502;
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

  .form-input.error input {
    animation: shake 0.4s ease;
  }
</style>
