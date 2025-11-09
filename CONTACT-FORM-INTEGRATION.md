# 📧 Contact Form - AWS Lambda Integration

## 🎯 Overview

The Zuclubit contact form has been upgraded with a professional integration to AWS Lambda, featuring:

- ✅ Real-time validation with instant feedback
- ✅ Advanced error handling with retry logic
- ✅ Skeleton loaders and loading states
- ✅ Microinteractions and smooth animations
- ✅ Toast notifications for user feedback
- ✅ Rate limiting protection (client and server-side)
- ✅ Disposable email detection
- ✅ Character count tracking
- ✅ Accessibility (ARIA labels, keyboard navigation)
- ✅ Mobile-responsive design

---

## 🏗️ Architecture

### Frontend (Svelte)
```
src/
├── components/
│   ├── sections/
│   │   └── ContactForm.svelte       # Main form component
│   └── ui/
│       ├── FormInput.svelte         # Text input with validation
│       ├── FormTextarea.svelte      # Textarea with char counter
│       ├── FormSelect.svelte        # Dropdown select
│       ├── LoadingSpinner.svelte    # Loading indicator
│       └── Toast.svelte             # Notification toast
└── services/
    └── contactApi.js                # API service layer
```

### Backend (AWS Lambda)
```
Lambda: ContactFormHandler-dev
Endpoint: https://vj5g5k1f4b.execute-api.us-east-1.amazonaws.com/dev/contact
Method: POST
```

---

## 📡 API Integration

### Request Format

**Endpoint:**
```
POST https://vj5g5k1f4b.execute-api.us-east-1.amazonaws.com/dev/contact
```

**Headers:**
```json
{
  "Content-Type": "application/json"
}
```

**Payload:**
```json
{
  "name": "John Doe",
  "email": "john@company.com",
  "company": "ACME Corp",
  "subject": "Architecture & Design Consultation",
  "message": "Service Interest: architecture\n\nCompany: ACME Corp\n\nWe need help with cloud architecture..."
}
```

### Response Format

**Success (200 OK):**
```json
{
  "success": true,
  "contactId": "3d158e3e-2f32-4ede-8d87-399ddf93a3d7",
  "timestamp": "2025-11-09T22:05:41.479Z",
  "message": "Your message has been received successfully..."
}
```

**Error (400/429/500):**
```json
{
  "success": false,
  "error": "ValidationError",
  "message": "Invalid email format",
  "details": {...}
}
```

---

## 🔒 Validation Rules

### Client-Side Validation

| Field | Rules |
|-------|-------|
| **Name** | Min: 2 chars, Max: 100 chars |
| **Email** | RFC 5322 format, No disposable domains |
| **Company** | Min: 2 chars, Max: 100 chars |
| **Service** | One of predefined service types |
| **Message** | Optional, Max: 2000 chars |

### Server-Side Validation

The Lambda performs additional validation:
- Email format validation
- Honeypot spam detection
- Rate limiting (3 submissions/hour per email)
- Duplicate detection (SHA-256 hash)
- Message sanitization

---

## 🎨 Features

### 1. Real-Time Validation

Fields are validated as the user types, with instant visual feedback:
- **Green border**: Valid input
- **Red border**: Invalid input with error message
- **Shake animation**: On validation error

```svelte
<FormInput
  id="email"
  label="Business Email"
  type="email"
  bind:value={formData.email}
  error={formErrors.email}
  touched={touchedFields.email}
  required
/>
```

### 2. Loading States

The submit button shows different states:
- **Default**: "Request Consultation" with Send icon
- **Sending**: Spinning loader + "Sending..." or "Retrying..."
- **Success**: Checkmark + "Message Sent!" (auto-reset after 2s)

### 3. Error Handling

Comprehensive error handling with user-friendly messages:

| Error Type | User Message |
|------------|--------------|
| Network error | "Network error. Please check your connection." |
| Timeout | "Request timeout. Please try again." |
| Rate limit (429) | "Too many requests. Please try again in a few minutes." |
| Validation (400) | Specific field errors shown inline |
| Server error (500) | "An error occurred. Please try again." |

### 4. Retry Logic

Automatic retry with exponential backoff:
- Max retries: 2
- Backoff: 1s, 2s, 4s (capped at 5s)
- Only retries on network/server errors (not validation errors)

### 5. Toast Notifications

Success and error messages appear as elegant toasts:
- Auto-dismiss after 5 seconds
- Manual close button
- Progress bar showing auto-dismiss countdown
- Pause on hover

### 6. Accessibility

- ARIA labels on all form fields
- Keyboard navigation support
- Focus management (auto-focus first error)
- Screen reader friendly error messages
- High contrast mode support

---

## 🧪 Testing

### Manual Testing

1. **Start preview server:**
   ```bash
   npm run preview
   ```

2. **Open in browser:**
   ```
   http://localhost:4173
   ```

3. **Test scenarios:**
   - ✅ Valid submission
   - ✅ Invalid email format
   - ✅ Empty required fields
   - ✅ Character limit (name: 100, message: 2000)
   - ✅ Disposable email detection
   - ✅ Network error (disconnect internet)
   - ✅ Rate limiting (submit 4 times with same email)

### Test with cURL

```bash
# Valid submission
curl -X POST "https://vj5g5k1f4b.execute-api.us-east-1.amazonaws.com/dev/contact" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "company": "Test Corp",
    "subject": "Architecture & Design Consultation",
    "message": "Service Interest: architecture\n\nCompany: Test Corp\n\nTest message"
  }'

# Invalid email
curl -X POST "https://vj5g5k1f4b.execute-api.us-east-1.amazonaws.com/dev/contact" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test",
    "email": "invalid-email",
    "company": "Test",
    "subject": "Test",
    "message": "Test"
  }'
```

---

## 🚀 Deployment

### Build for Production

```bash
npm run build
```

This creates an optimized production build in `dist/`:
- Minified JavaScript
- Optimized CSS
- Gzipped assets

### Deploy to Cloudflare Pages

The project is configured for Cloudflare Pages deployment:

```bash
# Via Wrangler CLI
npx wrangler pages deploy dist

# Via GitHub Actions (automatic)
git push origin main
```

---

## 🔧 Configuration

### Update Lambda Endpoint

If the Lambda endpoint changes, update `src/services/contactApi.js`:

```javascript
const API_CONFIG = {
  endpoint: 'https://your-new-endpoint.amazonaws.com/prod/contact',
  timeout: 30000,
  retries: 2,
};
```

### Customize Service Options

Update service options in `ContactForm.svelte`:

```javascript
const serviceOptions = [
  { value: 'architecture', label: 'Architecture & Design' },
  { value: 'devops', label: 'DevOps & Operations' },
  // Add more services...
];
```

### Adjust Validation Rules

Modify validation in `src/services/contactApi.js`:

```javascript
export function validateFormData(formData) {
  const errors = {};

  // Customize validation rules
  if (formData.name.length < 2) {
    errors.name = 'Name too short';
  }

  return { isValid: Object.keys(errors).length === 0, errors };
}
```

---

## 📊 Analytics

The form tracks successful submissions for analytics:

```javascript
if (typeof window !== 'undefined' && window.gtag) {
  window.gtag('event', 'form_submit', {
    event_category: 'Contact',
    event_label: formData.service,
  });
}
```

Add Google Analytics to `index.html` to enable tracking.

---

## 🐛 Troubleshooting

### Form not submitting

1. **Check console for errors:**
   - Open browser DevTools (F12)
   - Check Console tab for JavaScript errors

2. **Verify Lambda endpoint:**
   - Test endpoint with cURL (see Testing section)
   - Check Lambda logs in CloudWatch

3. **Check CORS:**
   - Ensure Lambda allows your domain
   - Check browser Network tab for CORS errors

### Validation errors not showing

1. **Ensure field is touched:**
   - Errors only show after field is blurred
   - Submit button click touches all fields

2. **Check validation logic:**
   - Review `validateFormData()` in `contactApi.js`

### Slow submissions

1. **Check network:**
   - Use browser DevTools Network tab
   - Look for slow API responses

2. **Lambda cold start:**
   - First request may be slower
   - Subsequent requests are faster

---

## 📝 Code Examples

### Using FormInput Component

```svelte
<FormInput
  id="name"
  label="Full Name"
  type="text"
  bind:value={formData.name}
  error={formErrors.name}
  touched={touchedFields.name}
  required
  disabled={isSubmitting}
  placeholder="John Doe"
  autocomplete="name"
  maxlength={100}
  on:blur={() => markFieldTouched('name')}
/>
```

### Custom API Call

```javascript
import { submitContactForm } from './services/contactApi.js';

async function handleCustomSubmit() {
  try {
    const result = await submitContactForm(
      {
        name: 'John Doe',
        email: 'john@example.com',
        company: 'ACME',
        service: 'consulting',
        message: 'Need help'
      },
      {
        onProgress: (progress) => {
          console.log(`Attempt ${progress.attempt}: ${progress.status}`);
        }
      }
    );

    console.log('Success!', result.contactId);
  } catch (error) {
    console.error('Failed:', error.message);
  }
}
```

---

## 🎯 Performance

### Bundle Size

| Asset | Size | Gzipped |
|-------|------|---------|
| JavaScript | 78.07 KB | 22.08 KB |
| CSS | 25.02 KB | 4.24 KB |
| **Total** | **103 KB** | **26 KB** |

### Load Time

- **First Paint**: ~500ms
- **Interactive**: ~800ms
- **Form Ready**: ~1s

### Optimizations

- Code splitting (components lazy-loaded)
- CSS purging (unused styles removed)
- Asset compression (Gzip/Brotli)
- Image optimization
- Tree shaking

---

## 🔐 Security

### Client-Side

- ✅ Input sanitization
- ✅ XSS prevention
- ✅ CSRF tokens (if needed)
- ✅ Disposable email detection
- ✅ Rate limiting awareness

### Server-Side (Lambda)

- ✅ Input validation
- ✅ Email verification
- ✅ Rate limiting (3/hour)
- ✅ Duplicate detection
- ✅ Honeypot fields
- ✅ WAF protection (staging/prod)
- ✅ DynamoDB encryption
- ✅ SES verified domains

---

## 📚 Resources

- **AWS Lambda Docs**: https://docs.aws.amazon.com/lambda/
- **Svelte Docs**: https://svelte.dev/docs
- **Vite Docs**: https://vitejs.dev/
- **Cloudflare Pages**: https://pages.cloudflare.com/

---

## 🤝 Support

For issues or questions:

1. Check this documentation
2. Review Lambda logs in CloudWatch
3. Test API endpoint with cURL
4. Contact: osvaloismtz@gmail.com

---

**Last Updated**: November 9, 2025
**Version**: 1.0.0
**Author**: Oscar Valois
