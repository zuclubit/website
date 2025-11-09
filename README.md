# Zuclubit - Enterprise Website

[![Deploy to CloudFlare Pages](https://github.com/Osvaloismtz/zuclubit-site/actions/workflows/deploy.yml/badge.svg)](https://github.com/Osvaloismtz/zuclubit-site/actions/workflows/deploy.yml)
[![CI](https://github.com/Osvaloismtz/zuclubit-site/actions/workflows/ci.yml/badge.svg)](https://github.com/Osvaloismtz/zuclubit-site/actions/workflows/ci.yml)
[![Security](https://github.com/Osvaloismtz/zuclubit-site/actions/workflows/security.yml/badge.svg)](https://github.com/Osvaloismtz/zuclubit-site/actions/workflows/security.yml)

Professional corporate website for Zuclubit - Complete Technology Integration Platform.

## 🌐 Live Site

- **Production**: [https://zuclubit.com](https://zuclubit.com)
- **Alternative**: [https://www.zuclubit.com](https://www.zuclubit.com)
- **CloudFlare Pages**: [https://zuclubit-site.pages.dev](https://zuclubit-site.pages.dev)

## 🏗️ Architecture

This project follows a modern, serverless architecture:

```
┌─────────────────────────────────────────────────────────────┐
│  CloudFlare CDN (330+ Global Locations)                    │
│  - HTTPS/SSL                                                 │
│  - DDoS Protection                                           │
│  - WAF (Web Application Firewall)                           │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
         ┌─────────────────────────────┐
         │  CloudFlare Pages           │
         │  - Static Site Hosting      │
         │  - Edge Functions           │
         │  - Auto Deployment          │
         └─────────────────────────────┘
```

**Benefits:**
- ✅ **Cost**: ~$0/month (CloudFlare Pages Free Tier)
- ✅ **Performance**: <100ms global response time
- ✅ **Scalability**: Infinite auto-scaling
- ✅ **Security**: Enterprise-grade DDoS protection + WAF
- ✅ **Availability**: 99.99% uptime SLA

## 🚀 Quick Start

### Prerequisites

- Node.js >= 20.0.0
- npm >= 10.0.0
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/Osvaloismtz/zuclubit-site.git
cd zuclubit-site

# Install dependencies
npm install

# Start development server
npm run dev
```

Visit [http://localhost:5173](http://localhost:5173)

### Build

```bash
# Production build
npm run build

# Preview production build
npm run preview
```

## 🔄 Development Workflow

We use **GitFlow** for branch management:

```
main (production)
  └── develop (integration)
       ├── feature/* (new features)
       ├── bugfix/* (bug fixes)
       └── refactor/* (improvements)
```

### Starting a New Feature

```bash
git checkout develop
git pull origin develop
git checkout -b feature/my-feature

# Make changes
git add .
git commit -m "feat: add my feature"
git push origin feature/my-feature

# Create PR to develop
```

📖 **See [GITFLOW.md](./GITFLOW.md) for complete workflow documentation**

## 🤝 Contributing

We welcome contributions! Please read our [CONTRIBUTING.md](./CONTRIBUTING.md) guide.

### Development Commands

```bash
# Development
npm run dev          # Start dev server
npm run build        # Build for production
npm run preview      # Preview production build

# Code Quality
npm run lint         # Lint code
npm run lint:fix     # Fix lint errors
npm run format       # Format code with Prettier
npm run format:check # Check formatting

# Testing
npm test             # Run tests
npm run test:watch   # Run tests in watch mode
npm run test:coverage # Generate coverage report

# Utilities
npm run clean        # Clean build artifacts
npm run audit        # Security audit
```

## 🔐 Security

Security is a top priority. We implement:

- **Automated Security Scanning**: CodeQL, Semgrep, Snyk
- **Dependency Monitoring**: Dependabot auto-updates
- **Secret Detection**: TruffleHog scans
- **SAST/DAST**: Multiple layers of security testing

🔒 **Report vulnerabilities**: [SECURITY.md](./SECURITY.md)

## 🏛️ Architecture & Standards

### Technology Stack

- **Frontend**: Svelte 4 + Vite 5
- **Styling**: Custom CSS with CSS Variables
- **Icons**: Lucide Icons
- **Hosting**: CloudFlare Pages
- **CDN**: CloudFlare Global Network
- **CI/CD**: GitHub Actions

### Security Standards

- ✅ **OWASP Top 10** compliance
- ✅ **CWE/SANS Top 25** mitigation
- ✅ **NIST Cybersecurity Framework** alignment
- ✅ **HTTPS Everywhere** with HSTS
- ✅ **CSP** (Content Security Policy)
- ✅ **CORS** properly configured

### Performance Standards

- ✅ Lighthouse Score: 90+ (All categories)
- ✅ First Contentful Paint: <2s
- ✅ Largest Contentful Paint: <2.5s
- ✅ Cumulative Layout Shift: <0.1
- ✅ Total Blocking Time: <300ms

### Accessibility Standards

- ✅ **WCAG 2.1 Level AA** compliance
- ✅ Keyboard navigation support
- ✅ Screen reader compatible
- ✅ Semantic HTML structure
- ✅ ARIA labels where needed

## 📊 CI/CD Pipeline

### Automated Workflows

#### On Pull Request
```
1. Security Scan (CodeQL, Trivy, Semgrep)
2. Code Quality Check (ESLint, Prettier)
3. Build Verification
4. Tests
5. Preview Deployment
   → https://preview-{PR-number}.zuclubit-site.pages.dev
```

#### On Merge to Main
```
1. All CI Checks
2. Production Build
3. Deploy to CloudFlare Pages
   → https://zuclubit.com
   → https://www.zuclubit.com
   → https://zuclubit-site.pages.dev
4. Performance Audit (Lighthouse)
```

### GitHub Actions Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `ci.yml` | PR, Push to develop | Build, test, quality checks |
| `deploy.yml` | Merge to main | Production deployment |
| `security.yml` | Daily, PR, Push | Security scanning |
| `performance.yml` | PR to main | Lighthouse audit |
| `auto-merge.yml` | Dependabot PR | Auto-merge minor updates |

## 📁 Project Structure

```
zuclubit-site/
├── .github/
│   ├── workflows/           # GitHub Actions
│   ├── ISSUE_TEMPLATE/      # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── CODEOWNERS           # Code ownership
├── src/
│   ├── components/          # Svelte components
│   │   └── ui/             # UI components
│   ├── lib/                # Utility functions
│   ├── assets/             # Static assets
│   ├── App.svelte          # Root component
│   └── main.js             # Entry point
├── public/                  # Public assets
├── legacy/                  # Legacy scripts & docs
│   ├── scripts/            # Manual deployment scripts
│   └── docs/               # Old documentation
├── .eslintrc.cjs           # ESLint configuration
├── .prettierrc             # Prettier configuration
├── .lighthouserc.json      # Lighthouse CI config
├── vite.config.js          # Vite configuration
├── wrangler.toml           # CloudFlare Pages config
├── GITFLOW.md              # GitFlow documentation
├── CONTRIBUTING.md         # Contribution guidelines
├── SECURITY.md             # Security policy
└── README.md               # This file
```

## 🔧 Configuration Files

| File | Purpose |
|------|---------|
| `vite.config.js` | Vite build configuration |
| `wrangler.toml` | CloudFlare Pages settings |
| `.eslintrc.cjs` | ESLint rules |
| `.prettierrc` | Code formatting rules |
| `.lighthouserc.json` | Performance budgets |
| `package.json` | Dependencies & scripts |

## 🌍 Environment Variables

For local development, create a `.env` file:

```bash
# Not required for this project currently
# Add environment variables as needed
```

For production, configure in CloudFlare Pages dashboard:
- Settings → Environment Variables

## 📈 Monitoring & Analytics

- **CloudFlare Analytics**: Built-in traffic analytics
- **Web Vitals**: Core Web Vitals tracking
- **Error Tracking**: Planned integration
- **Uptime Monitoring**: CloudFlare 99.99% SLA

## 🎯 Roadmap

### Phase 1: Foundation ✅ (Completed)
- [x] Serverless architecture
- [x] CI/CD pipeline
- [x] Security scanning
- [x] Custom domain with HTTPS
- [x] GitFlow workflow

### Phase 2: Enhancement 🔄 (In Progress)
- [ ] Unit tests (Vitest)
- [ ] E2E tests (Playwright)
- [ ] Component library documentation
- [ ] Performance monitoring
- [ ] A/B testing framework

### Phase 3: Expansion 📋 (Planned)
- [ ] Backend API (CloudFlare Workers)
- [ ] Database integration (D1/Durable Objects)
- [ ] User authentication (OAuth)
- [ ] CMS integration
- [ ] Multi-language support

## 📄 License

MIT License - see [LICENSE](./LICENSE) file for details

## 👥 Team

- **Oscar Valois** - [@Osvaloismtz](https://github.com/Osvaloismtz)

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/Osvaloismtz/zuclubit-site/issues)
- **Email**: osvaloismtz@gmail.com
- **Website**: [https://zuclubit.com](https://zuclubit.com)

## 🙏 Acknowledgments

- **CloudFlare Pages** for serverless hosting
- **Svelte** for the amazing framework
- **Vite** for lightning-fast builds
- **Lucide** for beautiful icons

## 📚 Additional Documentation

- [GitFlow Workflow](./GITFLOW.md)
- [Contributing Guide](./CONTRIBUTING.md)
- [Security Policy](./SECURITY.md)
- [Quick Start Guide](./QUICK-START.md)

---

**Built with ❤️ by Zuclubit Team**

Last Updated: 2025-11-09
