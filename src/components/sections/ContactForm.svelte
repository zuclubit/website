<script>
  import { onMount } from 'svelte';
  import { fade, fly, scale } from 'svelte/transition';
  import { cubicOut } from 'svelte/easing';
  import { CheckCircle2, Send, Loader2 } from 'lucide-svelte';

  import FormInput from '../ui/FormInput.svelte';
  import FormTextarea from '../ui/FormTextarea.svelte';
  import FormSelect from '../ui/FormSelect.svelte';
  import Toast from '../ui/Toast.svelte';
  import LoadingSpinner from '../ui/LoadingSpinner.svelte';

  import {
    submitContactForm,
    validateFormData,
    ContactAPIError,
  } from '../../services/contactApi.js';

  // Form state
  let formData = {
    name: '',
    email: '',
    company: '',
    service: 'architecture',
    message: '',
  };

  let formErrors = {};
  let touchedFields = {};

  // UI state
  let isSubmitting = false;
  let submitSuccess = false;
  let submitError = null;
  let showToast = false;
  let toastMessage = '';
  let toastType = 'success';

  // Progress tracking
  let submissionProgress = {
    attempt: 0,
    status: null,
  };

  // Service options
  const serviceOptions = [
    { value: 'architecture', label: 'Architecture & Design' },
    { value: 'devops', label: 'DevOps & Operations' },
    { value: 'ai', label: 'AI & Machine Learning' },
    { value: 'cloud', label: 'Cloud Computing' },
    { value: 'security', label: 'Cybersecurity' },
    { value: 'transformation', label: 'Digital Transformation' },
    { value: 'consulting', label: 'General Consulting' },
  ];

  // Reactive validation
  $: {
    if (Object.keys(touchedFields).length > 0) {
      const validation = validateFormData(formData);
      formErrors = validation.errors;
    }
  }

  // Mark field as touched
  function markFieldTouched(fieldName) {
    touchedFields = { ...touchedFields, [fieldName]: true };
  }

  // Handle form submission
  async function handleSubmit(e) {
    e.preventDefault();

    // Mark all fields as touched
    touchedFields = {
      name: true,
      email: true,
      company: true,
      service: true,
      message: true,
    };

    // Validate form
    const validation = validateFormData(formData);
    if (!validation.isValid) {
      formErrors = validation.errors;

      // Show error toast
      toastMessage = 'Please fix the errors in the form';
      toastType = 'error';
      showToast = true;

      // Focus first error field
      const firstErrorField = Object.keys(validation.errors)[0];
      const element = document.getElementById(firstErrorField);
      if (element) {
        element.focus();
        element.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }

      return;
    }

    // Reset states
    submitError = null;
    isSubmitting = true;
    submitSuccess = false;

    try {
      // Submit to Lambda
      const result = await submitContactForm(formData, {
        onProgress: (progress) => {
          submissionProgress = progress;
        },
      });

      // Success!
      submitSuccess = true;
      isSubmitting = false;

      // Show success toast
      toastMessage = "Thank you! We'll contact you within 24 hours.";
      toastType = 'success';
      showToast = true;

      // Reset form after short delay
      setTimeout(() => {
        formData = {
          name: '',
          email: '',
          company: '',
          service: 'architecture',
          message: '',
        };
        touchedFields = {};
        formErrors = {};

        // Hide success state
        setTimeout(() => {
          submitSuccess = false;
        }, 2000);
      }, 1500);

      // Track success (optional analytics)
      if (typeof window !== 'undefined' && window.gtag) {
        window.gtag('event', 'form_submit', {
          event_category: 'Contact',
          event_label: formData.service,
        });
      }
    } catch (error) {
      isSubmitting = false;
      submitError = error;

      // Determine error message
      let errorMessage = 'An error occurred. Please try again.';

      if (error instanceof ContactAPIError) {
        if (error.statusCode === 429) {
          errorMessage = 'Too many requests. Please try again in a few minutes.';
        } else if (error.statusCode === 400) {
          errorMessage = error.message || 'Please check your input and try again.';
        } else if (error.statusCode === 0) {
          errorMessage = 'Network error. Please check your connection.';
        } else {
          errorMessage = error.message;
        }
      }

      // Show error toast
      toastMessage = errorMessage;
      toastType = 'error';
      showToast = true;

      console.error('Form submission error:', error);
    }
  }

  function handleToastClose() {
    showToast = false;
  }

  // Auto-focus name field on mount (optional)
  let nameInput;
  onMount(() => {
    // Optional: focus name field
    // nameInput?.focus();
  });
</script>

<form class="contact-form" on:submit={handleSubmit} novalidate>
  <div class="form-grid">
    <!-- Name Field -->
    <FormInput
      bind:this={nameInput}
      id="name"
      label="Full Name"
      type="text"
      bind:value={formData.name}
      error={formErrors.name}
      touched={touchedFields.name}
      required
      disabled={isSubmitting || submitSuccess}
      placeholder="John Doe"
      autocomplete="name"
      maxlength={100}
      on:blur={() => markFieldTouched('name')}
    />

    <!-- Email Field -->
    <FormInput
      id="email"
      label="Business Email"
      type="email"
      bind:value={formData.email}
      error={formErrors.email}
      touched={touchedFields.email}
      required
      disabled={isSubmitting || submitSuccess}
      placeholder="john@company.com"
      autocomplete="email"
      maxlength={255}
      on:blur={() => markFieldTouched('email')}
    />
  </div>

  <div class="form-grid">
    <!-- Company Field -->
    <FormInput
      id="company"
      label="Company"
      type="text"
      bind:value={formData.company}
      error={formErrors.company}
      touched={touchedFields.company}
      required
      disabled={isSubmitting || submitSuccess}
      placeholder="Your Company"
      autocomplete="organization"
      maxlength={100}
      on:blur={() => markFieldTouched('company')}
    />

    <!-- Service Field -->
    <FormSelect
      id="service"
      label="Service Interest"
      bind:value={formData.service}
      options={serviceOptions}
      error={formErrors.service}
      touched={touchedFields.service}
      required
      disabled={isSubmitting || submitSuccess}
      on:blur={() => markFieldTouched('service')}
    />
  </div>

  <!-- Message Field -->
  <FormTextarea
    id="message"
    label="Tell us about your project"
    bind:value={formData.message}
    error={formErrors.message}
    touched={touchedFields.message}
    disabled={isSubmitting || submitSuccess}
    placeholder="Brief description of your needs..."
    rows={5}
    maxlength={2000}
    on:blur={() => markFieldTouched('message')}
  />

  <!-- Submit Button -->
  <div class="form-actions">
    <button
      type="submit"
      class="btn btn-submit"
      class:loading={isSubmitting}
      class:success={submitSuccess}
      disabled={isSubmitting || submitSuccess}
    >
      {#if isSubmitting}
        <span class="btn-content" in:fade={{ duration: 150 }}>
          <Loader2 size={20} class="spin-icon" />
          <span>
            {#if submissionProgress.status === 'retrying'}
              Retrying...
            {:else}
              Sending...
            {/if}
          </span>
        </span>
      {:else if submitSuccess}
        <span class="btn-content" in:scale={{ duration: 200, easing: cubicOut }}>
          <CheckCircle2 size={20} />
          <span>Message Sent!</span>
        </span>
      {:else}
        <span class="btn-content" in:fade={{ duration: 150 }}>
          <Send size={20} />
          <span>Request Consultation</span>
        </span>
      {/if}
    </button>

    {#if submissionProgress.status === 'retrying'}
      <p class="retry-message" transition:fly={{ y: -10, duration: 200 }}>
        Retrying... (Attempt {submissionProgress.attempt})
      </p>
    {/if}
  </div>
</form>

<!-- Toast Notifications -->
{#if showToast}
  <div class="toast-container">
    <Toast type={toastType} message={toastMessage} duration={5000} onClose={handleToastClose} />
  </div>
{/if}

<style>
  .contact-form {
    width: 100%;
    max-width: 600px;
  }

  .form-grid {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }

  @media (min-width: 640px) {
    .form-grid {
      grid-template-columns: 1fr 1fr;
    }
  }

  .form-actions {
    margin-top: 2rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
  }

  .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 1rem 2rem;
    font-weight: 600;
    border-radius: 10px;
    text-decoration: none;
    border: 2px solid transparent;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-size: 1rem;
    font-family: inherit;
    width: 100%;
  }

  .btn-submit {
    background: linear-gradient(135deg, #00cfff 0%, #00e5c3 100%);
    color: #0b0e11;
    position: relative;
    overflow: hidden;
    min-height: 54px;
  }

  .btn-submit::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.3);
    transform: translate(-50%, -50%);
    transition:
      width 0.6s ease,
      height 0.6s ease;
  }

  .btn-submit:hover:not(:disabled)::before {
    width: 400px;
    height: 400px;
  }

  .btn-submit:hover:not(:disabled) {
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(0, 207, 255, 0.4);
  }

  .btn-submit:active:not(:disabled) {
    transform: translateY(0);
  }

  .btn-submit:disabled {
    opacity: 0.8;
    cursor: not-allowed;
  }

  .btn-submit.loading {
    background: linear-gradient(135deg, rgba(0, 207, 255, 0.8) 0%, rgba(0, 229, 195, 0.8) 100%);
  }

  .btn-submit.success {
    background: linear-gradient(135deg, #00e5c3 0%, #00cfff 100%);
  }

  .btn-content {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    position: relative;
    z-index: 1;
  }

  :global(.spin-icon) {
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    from {
      transform: rotate(0deg);
    }
    to {
      transform: rotate(360deg);
    }
  }

  .retry-message {
    text-align: center;
    font-size: 0.875rem;
    color: rgba(255, 255, 255, 0.7);
    margin: 0;
  }

  .toast-container {
    position: fixed;
    top: 2rem;
    right: 2rem;
    z-index: 9999;
  }

  @media (max-width: 640px) {
    .toast-container {
      top: 1rem;
      right: 1rem;
      left: 1rem;
    }
  }
</style>
