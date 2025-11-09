/**
 * Contact Form API Service
 * Handles communication with AWS Lambda backend
 */

const API_CONFIG = {
  endpoint: 'https://vj5g5k1f4b.execute-api.us-east-1.amazonaws.com/dev/contact',
  timeout: 30000, // 30 seconds
  retries: 2,
};

/**
 * Custom API Error class
 */
export class ContactAPIError extends Error {
  constructor(message, statusCode, details) {
    super(message);
    this.name = 'ContactAPIError';
    this.statusCode = statusCode;
    this.details = details;
  }
}

/**
 * Delay utility for retries
 */
const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

/**
 * Map service selection to subject line
 */
const mapServiceToSubject = (service) => {
  const serviceMap = {
    architecture: 'Architecture & Design Consultation',
    devops: 'DevOps & Operations Inquiry',
    ai: 'AI & Machine Learning Project',
    cloud: 'Cloud Computing Services',
    security: 'Cybersecurity Consultation',
    transformation: 'Digital Transformation Initiative',
    consulting: 'General Consulting Request',
  };
  return serviceMap[service] || 'General Inquiry';
};

/**
 * Submit contact form to Lambda
 * @param {Object} formData - Form data to submit
 * @param {string} formData.name - User's full name
 * @param {string} formData.email - User's email
 * @param {string} formData.company - Company name
 * @param {string} formData.service - Service interest
 * @param {string} formData.message - Optional message
 * @returns {Promise<Object>} Response from API
 */
export async function submitContactForm(formData, options = {}) {
  const { retries = API_CONFIG.retries, onProgress } = options;

  // Validate required fields
  if (!formData.name || !formData.email || !formData.company || !formData.service) {
    throw new ContactAPIError('Missing required fields', 400, {
      fields: ['name', 'email', 'company', 'service'],
    });
  }

  // Prepare payload for Lambda
  const payload = {
    name: formData.name.trim(),
    email: formData.email.trim().toLowerCase(),
    company: formData.company.trim(),
    subject: mapServiceToSubject(formData.service),
    message: formData.message
      ? `Service Interest: ${formData.service}\n\nCompany: ${formData.company}\n\n${formData.message.trim()}`
      : `Service Interest: ${formData.service}\n\nCompany: ${formData.company}\n\nRequesting consultation for ${formData.service} services.`,
  };

  // Attempt submission with retries
  let lastError;
  for (let attempt = 0; attempt <= retries; attempt++) {
    try {
      if (onProgress) {
        onProgress({ attempt: attempt + 1, status: 'sending' });
      }

      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), API_CONFIG.timeout);

      const response = await fetch(API_CONFIG.endpoint, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload),
        signal: controller.signal,
      });

      clearTimeout(timeoutId);

      // Parse response
      const data = await response.json();

      // Handle successful response
      if (response.ok && data.success) {
        if (onProgress) {
          onProgress({ attempt: attempt + 1, status: 'success', data });
        }
        return {
          success: true,
          contactId: data.contactId,
          timestamp: data.timestamp,
          message: data.message,
        };
      }

      // Handle API error response
      throw new ContactAPIError(
        data.message || 'Failed to submit contact form',
        response.status,
        data.details || data.error
      );
    } catch (error) {
      lastError = error;

      // Don't retry on validation errors (4xx)
      if (error.statusCode >= 400 && error.statusCode < 500) {
        if (onProgress) {
          onProgress({ attempt: attempt + 1, status: 'error', error });
        }
        throw error;
      }

      // Retry on network/server errors
      if (attempt < retries) {
        const backoffDelay = Math.min(1000 * Math.pow(2, attempt), 5000);
        if (onProgress) {
          onProgress({ attempt: attempt + 1, status: 'retrying', delay: backoffDelay });
        }
        await delay(backoffDelay);
        continue;
      }

      // All retries exhausted
      if (onProgress) {
        onProgress({ attempt: attempt + 1, status: 'failed', error });
      }

      // Convert network errors to ContactAPIError
      if (error.name === 'AbortError') {
        throw new ContactAPIError('Request timeout. Please try again.', 408, {
          timeout: API_CONFIG.timeout,
        });
      }

      if (!error.statusCode) {
        throw new ContactAPIError(
          'Network error. Please check your connection and try again.',
          0,
          { originalError: error.message }
        );
      }

      throw error;
    }
  }

  throw lastError;
}

/**
 * Validate email format (client-side)
 */
export function validateEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return { valid: false, error: 'Invalid email format' };
  }

  // Check for common disposable email domains (basic list)
  const disposableDomains = [
    'tempmail.com',
    'throwaway.email',
    '10minutemail.com',
    'guerrillamail.com',
    'mailinator.com',
  ];

  const domain = email.split('@')[1]?.toLowerCase();
  if (disposableDomains.includes(domain)) {
    return { valid: false, error: 'Please use a business email address' };
  }

  return { valid: true };
}

/**
 * Validate form data before submission
 */
export function validateFormData(formData) {
  const errors = {};

  // Name validation
  if (!formData.name || formData.name.trim().length < 2) {
    errors.name = 'Name must be at least 2 characters';
  }
  if (formData.name && formData.name.trim().length > 100) {
    errors.name = 'Name must be less than 100 characters';
  }

  // Email validation
  if (!formData.email) {
    errors.email = 'Email is required';
  } else {
    const emailValidation = validateEmail(formData.email);
    if (!emailValidation.valid) {
      errors.email = emailValidation.error;
    }
  }

  // Company validation
  if (!formData.company || formData.company.trim().length < 2) {
    errors.company = 'Company name must be at least 2 characters';
  }
  if (formData.company && formData.company.trim().length > 100) {
    errors.company = 'Company name must be less than 100 characters';
  }

  // Service validation
  const validServices = [
    'architecture',
    'devops',
    'ai',
    'cloud',
    'security',
    'transformation',
    'consulting',
  ];
  if (!formData.service || !validServices.includes(formData.service)) {
    errors.service = 'Please select a valid service';
  }

  // Message validation (optional, but limit length if provided)
  if (formData.message && formData.message.trim().length > 2000) {
    errors.message = 'Message must be less than 2000 characters';
  }

  return {
    isValid: Object.keys(errors).length === 0,
    errors,
  };
}

/**
 * Get API health status (optional - for monitoring)
 */
export async function checkAPIHealth() {
  try {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 5000);

    const response = await fetch(API_CONFIG.endpoint.replace('/contact', '/health'), {
      method: 'GET',
      signal: controller.signal,
    });

    clearTimeout(timeoutId);

    return {
      healthy: response.ok,
      status: response.status,
    };
  } catch (error) {
    return {
      healthy: false,
      error: error.message,
    };
  }
}
