# Contributing to Zuclubit

Thank you for your interest in contributing to Zuclubit! This document provides guidelines and best practices for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

This project follows a Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to osvaloismtz@gmail.com.

## Getting Started

### Prerequisites

- Node.js 20 or higher
- npm or yarn
- Git
- CloudFlare account (for deployment)

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:

```bash
git clone https://github.com/YOUR_USERNAME/zuclubit-site.git
cd zuclubit-site
```

3. Add the upstream repository:

```bash
git remote add upstream https://github.com/Osvaloismtz/zuclubit-site.git
```

### Install Dependencies

```bash
npm install
```

### Run Development Server

```bash
npm run dev
```

Visit http://localhost:5173 to see your changes.

## Development Workflow

We follow **GitFlow** workflow:

### Branch Structure

- `main`: Production-ready code
- `develop`: Integration branch for features
- `feature/*`: New features
- `bugfix/*`: Bug fixes
- `hotfix/*`: Emergency fixes for production
- `release/*`: Release preparation

### Creating a New Feature

```bash
# Start from develop
git checkout develop
git pull upstream develop

# Create feature branch
git checkout -b feature/your-feature-name

# Make changes and commit
git add .
git commit -m "feat: add your feature"

# Push to your fork
git push origin feature/your-feature-name

# Create Pull Request to upstream/develop
```

### Branch Naming Convention

- `feature/description` - New features
- `bugfix/description` - Bug fixes
- `hotfix/description` - Urgent production fixes
- `refactor/description` - Code refactoring
- `docs/description` - Documentation updates
- `test/description` - Test additions/updates
- `chore/description` - Maintenance tasks

## Coding Standards

### JavaScript/Svelte

- Use **ES6+** syntax
- Use **const** and **let**, avoid **var**
- Use **arrow functions** where appropriate
- Use **template literals** for string interpolation
- **Destructure** objects and arrays when possible

### Code Style

We use Prettier and ESLint:

```bash
# Format code
npm run format

# Lint code
npm run lint

# Fix lint errors
npm run lint:fix
```

### File Structure

```
src/
├── components/       # Reusable Svelte components
│   └── ui/          # UI components (Button, Card, etc.)
├── lib/             # Utility functions and helpers
├── stores/          # Svelte stores for state management
├── assets/          # Images, fonts, etc.
└── App.svelte       # Main application component
```

### Component Guidelines

1. **Single Responsibility**: Each component should do one thing well
2. **Props Validation**: Document expected props
3. **Composition over Inheritance**: Use component composition
4. **Accessibility**: Follow WCAG 2.1 Level AA standards

Example:

```svelte
<script>
  /**
   * Button component with multiple variants
   * @component
   */

  /**
   * Button text label
   * @type {string}
   */
  export let label;

  /**
   * Button variant style
   * @type {'primary' | 'secondary' | 'danger'}
   */
  export let variant = 'primary';

  /**
   * Disabled state
   * @type {boolean}
   */
  export let disabled = false;
</script>

<button class="btn btn-{variant}" {disabled} on:click>
  {label}
</button>
```

## Commit Messages

We follow [Conventional Commits](https://www.conventionalcommits.org/):

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Maintenance tasks
- `ci`: CI/CD changes
- `build`: Build system changes
- `revert`: Revert a previous commit

### Examples

```bash
feat(ui): add dark mode toggle

fix(auth): resolve login redirect issue

docs: update installation guide

chore(deps): upgrade vite to v5.0.0

feat(components): add Button component with variants

BREAKING CHANGE: renamed Button prop from 'type' to 'variant'
```

### Commit Message Rules

- Use **present tense** ("add feature" not "added feature")
- Use **imperative mood** ("move cursor to..." not "moves cursor to...")
- Keep subject line **under 72 characters**
- Reference **issues and PRs** in the footer
- Include **breaking changes** in the footer

## Pull Request Process

### Before Submitting

1. **Update from upstream**:
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout your-feature-branch
   git rebase develop
   ```

2. **Run tests**:
   ```bash
   npm test
   ```

3. **Build the project**:
   ```bash
   npm run build
   ```

4. **Check code quality**:
   ```bash
   npm run lint
   npm run format:check
   ```

### PR Checklist

- [ ] Code follows the project's style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings or errors
- [ ] Tests added/updated
- [ ] All tests passing
- [ ] Build succeeds
- [ ] No console.log() statements left
- [ ] No secrets or sensitive data

### PR Title

Follow the same convention as commit messages:

```
feat(ui): add mobile navigation menu
fix(api): resolve CORS issue
docs: update README with new examples
```

### PR Description

Use the PR template provided. Include:

- Clear description of changes
- Related issues
- Screenshots (for UI changes)
- Testing instructions
- Breaking changes (if any)

### Review Process

1. **Automated checks** must pass:
   - CI/CD pipeline
   - Security scans
   - Build verification
   - Tests

2. **Code review** by maintainer(s)

3. **Address feedback** and push updates

4. **Squash and merge** after approval

## Testing

### Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Run tests with coverage
npm run test:coverage
```

### Writing Tests

- Write tests for new features
- Update tests when modifying existing features
- Aim for >80% code coverage
- Test edge cases and error handling

### Test Structure

```javascript
import { render, fireEvent } from '@testing-library/svelte';
import Button from './Button.svelte';

describe('Button Component', () => {
  it('renders with correct label', () => {
    const { getByText } = render(Button, { label: 'Click me' });
    expect(getByText('Click me')).toBeInTheDocument();
  });

  it('handles click events', async () => {
    const { component, getByRole } = render(Button, { label: 'Click' });
    const button = getByRole('button');

    let clicked = false;
    component.$on('click', () => { clicked = true; });

    await fireEvent.click(button);
    expect(clicked).toBe(true);
  });
});
```

## Documentation

### Code Comments

- Use **JSDoc** for functions and components
- Explain **why**, not **what**
- Keep comments **up to date**

### README Updates

Update README.md when:

- Adding new features
- Changing installation steps
- Modifying configuration
- Adding new dependencies

### Changelog

Maintain CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/):

```markdown
## [Unreleased]

### Added
- New feature X

### Changed
- Updated component Y

### Fixed
- Bug Z resolved
```

## Development Tools

### Recommended VS Code Extensions

- Svelte for VS Code
- ESLint
- Prettier
- GitLens
- Error Lens
- Path Intellisense

### VS Code Settings

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "svelte.enable-ts-plugin": true
}
```

## Performance Guidelines

- **Lazy load** images and components
- **Minimize bundle size**
- **Use code splitting**
- **Optimize images** (WebP, proper sizing)
- **Avoid unnecessary re-renders**

## Accessibility (a11y)

- Use **semantic HTML**
- Include **alt text** for images
- Ensure **keyboard navigation**
- Maintain **color contrast** (WCAG AA)
- Test with **screen readers**

## Security

- **Never commit secrets** (API keys, tokens)
- **Validate inputs** on client and server
- **Sanitize user data**
- **Use HTTPS** everywhere
- **Follow OWASP Top 10**

## Questions?

- Open an issue for questions
- Email: osvaloismtz@gmail.com
- Check existing issues and PRs

## License

By contributing, you agree that your contributions will be licensed under the project's license.

---

Thank you for contributing to Zuclubit! 🚀
