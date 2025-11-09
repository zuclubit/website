<script>
  import { fly, scale } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';

  export let label = '';
  export let id = '';
  export let value = '';
  export let placeholder = '';
  export let required = false;
  export let error = '';
  export let touched = false;
  export let disabled = false;
  export let rows = 4;
  export let maxlength = undefined;

  let focused = false;
  let textarea;

  $: showError = touched && error;
  $: hasValue = value && value.length > 0;
  $: characterCount = value ? value.length : 0;

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
    textarea?.focus();
  }
</script>

<div class="form-textarea" class:focused class:error={showError} class:has-value={hasValue}>
  <label for={id} class="form-label">
    {label}
    {#if required}<span class="required">*</span>{/if}
  </label>

  <div class="textarea-wrapper">
    <textarea
      bind:this={textarea}
      {id}
      {placeholder}
      {required}
      {disabled}
      {rows}
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

  {#if maxlength}
    <p class="char-count" class:warning={characterCount > maxlength * 0.9}>
      {characterCount}/{maxlength}
    </p>
  {/if}
</div>

<style>
  .form-textarea {
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

  .form-textarea.focused .form-label {
    color: #00cfff;
  }

  .form-textarea.error .form-label {
    color: #ff4757;
  }

  .required {
    color: #ff4757;
    margin-left: 0.25rem;
  }

  .textarea-wrapper {
    position: relative;
  }

  textarea {
    width: 100%;
    padding: 0.875rem 1rem;
    font-size: 0.9375rem;
    color: #f5f7fa;
    background: rgba(255, 255, 255, 0.05);
    border: 2px solid rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-family: inherit;
    resize: vertical;
    min-height: 100px;
  }

  textarea::placeholder {
    color: rgba(255, 255, 255, 0.4);
  }

  textarea:focus {
    outline: none;
    background: rgba(255, 255, 255, 0.08);
    border-color: #00cfff;
    box-shadow: 0 0 0 3px rgba(0, 207, 255, 0.1);
  }

  textarea.error {
    border-color: #ff4757;
    background: rgba(255, 71, 87, 0.05);
  }

  textarea.error:focus {
    box-shadow: 0 0 0 3px rgba(255, 71, 87, 0.1);
  }

  textarea:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    background: rgba(255, 255, 255, 0.02);
    resize: none;
  }

  .error-icon {
    position: absolute;
    right: 1rem;
    top: 1rem;
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

  .form-textarea.error textarea {
    animation: shake 0.4s ease;
  }
</style>
