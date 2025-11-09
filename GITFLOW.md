# GitFlow Workflow Documentation

## Overview

This project uses **GitFlow** - a branching model designed for release-based software development with automated CI/CD pipelines.

## Branch Structure

```
main (production)
  └── develop (integration)
       ├── feature/* (new features)
       ├── bugfix/* (bug fixes)
       └── refactor/* (code improvements)

main (when urgent)
  └── hotfix/* (emergency production fixes)
```

## Branch Descriptions

### Permanent Branches

#### `main`
- **Purpose**: Production-ready code
- **Protected**: Yes
- **Deployment**: Auto-deploys to https://zuclubit.com
- **Merge from**: `develop`, `hotfix/*`, `release/*`
- **Merge requires**: PR approval, all checks passing

#### `develop`
- **Purpose**: Integration branch for features
- **Protected**: Yes
- **Deployment**: Auto-deploys to preview environment
- **Merge from**: `feature/*`, `bugfix/*`, `refactor/*`
- **Merge requires**: PR approval, all checks passing

### Temporary Branches

#### `feature/*`
- **Purpose**: New features or enhancements
- **Branch from**: `develop`
- **Merge into**: `develop`
- **Naming**: `feature/description` (e.g., `feature/dark-mode`)
- **Lifespan**: Until feature complete

#### `bugfix/*`
- **Purpose**: Bug fixes for develop
- **Branch from**: `develop`
- **Merge into**: `develop`
- **Naming**: `bugfix/description` (e.g., `bugfix/login-error`)
- **Lifespan**: Until bug fixed

#### `hotfix/*`
- **Purpose**: Emergency fixes for production
- **Branch from**: `main`
- **Merge into**: `main` AND `develop`
- **Naming**: `hotfix/description` (e.g., `hotfix/security-patch`)
- **Lifespan**: Until fix deployed

#### `release/*`
- **Purpose**: Release preparation
- **Branch from**: `develop`
- **Merge into**: `main` AND `develop`
- **Naming**: `release/v1.2.0`
- **Lifespan**: Until release complete

## Workflows

### Starting a New Feature

```bash
# 1. Update develop
git checkout develop
git pull origin develop

# 2. Create feature branch
git checkout -b feature/my-feature

# 3. Work on feature
git add .
git commit -m "feat: add my feature"

# 4. Push to remote
git push origin feature/my-feature

# 5. Create PR to develop
# Go to GitHub and create Pull Request
```

### Fixing a Bug

```bash
# 1. Update develop
git checkout develop
git pull origin develop

# 2. Create bugfix branch
git checkout -b bugfix/fix-issue

# 3. Fix the bug
git add .
git commit -m "fix: resolve issue"

# 4. Push and create PR
git push origin bugfix/fix-issue
```

### Emergency Hotfix

```bash
# 1. Branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-fix

# 2. Apply fix
git add .
git commit -m "fix: critical security patch"

# 3. Push and create PR to main
git push origin hotfix/critical-fix

# 4. After merging to main, merge to develop too
git checkout develop
git pull origin develop
git merge hotfix/critical-fix
git push origin develop
```

### Creating a Release

```bash
# 1. Create release branch from develop
git checkout develop
git pull origin develop
git checkout -b release/v1.2.0

# 2. Update version in package.json
npm version minor  # or major/patch

# 3. Update CHANGELOG.md
# Add release notes

# 4. Commit release preparation
git commit -am "chore(release): prepare v1.2.0"

# 5. Push and create PR to main
git push origin release/v1.2.0

# 6. After merge to main, also merge to develop
# 7. Tag the release on main
git checkout main
git pull origin main
git tag -a v1.2.0 -m "Release version 1.2.0"
git push origin v1.2.0
```

## Branch Protection Rules

### `main` Branch

- ✅ Require pull request before merging
- ✅ Require approvals: 1
- ✅ Dismiss stale PR approvals
- ✅ Require status checks to pass:
  - CI Build
  - Security Scan
  - Code Quality
- ✅ Require branches to be up to date
- ✅ Require signed commits
- ✅ Include administrators
- ✅ Restrict who can push to matching branches

### `develop` Branch

- ✅ Require pull request before merging
- ✅ Require approvals: 1
- ✅ Require status checks to pass:
  - CI Build
  - Security Scan
- ✅ Require branches to be up to date

## CI/CD Pipeline

### On Pull Request to `develop` or `main`

```
1. Security Scan
   ├── CodeQL analysis
   ├── Dependency scan
   ├── Secret scanning
   └── SAST analysis

2. Code Quality
   ├── ESLint
   └── Prettier

3. Build Verification
   ├── npm ci
   ├── npm run build
   └── Check output

4. Tests
   └── npm test

5. Preview Deployment (PRs only)
   └── Deploy to preview-{PR-number}.zuclubit-site.pages.dev
```

### On Merge to `main`

```
1. All CI checks (same as above)

2. Production Deployment
   ├── Build project
   ├── Deploy to CloudFlare Pages
   └── Update:
       ├── https://zuclubit.com
       ├── https://www.zuclubit.com
       └── https://zuclubit-site.pages.dev

3. Post-deployment
   ├── Tag release
   ├── Update changelog
   └── Notify team
```

## Commit Message Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting, missing semi-colons, etc.
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Adding tests
- `chore`: Maintenance
- `ci`: CI/CD changes
- `build`: Build system
- `revert`: Revert a commit

### Examples

```bash
feat(ui): add dark mode toggle
fix(auth): resolve token expiration issue
docs: update README with new examples
chore(deps): upgrade vite to v5.0.0
ci: add automated security scanning
```

## Pull Request Process

### 1. Create PR

- Use PR template
- Fill out all sections
- Link related issues
- Add screenshots for UI changes

### 2. Automated Checks

- ✅ Security scans
- ✅ Code quality checks
- ✅ Build verification
- ✅ Tests

### 3. Code Review

- Request review from maintainer
- Address feedback
- Update PR with changes

### 4. Merge

- Squash and merge (default)
- Delete branch after merge
- Auto-deploy triggers

## Best Practices

### Do's ✅

- Keep branches up to date with base branch
- Write descriptive commit messages
- Keep PRs small and focused
- Add tests for new features
- Update documentation
- Run tests locally before pushing
- Use meaningful branch names

### Don'ts ❌

- Don't commit directly to `main` or `develop`
- Don't push broken code
- Don't commit secrets or credentials
- Don't force push to shared branches
- Don't create PRs with failing tests
- Don't merge your own PRs (except minor docs)

## Versioning

We follow [Semantic Versioning](https://semver.org/):

```
MAJOR.MINOR.PATCH

1.2.3
│ │ │
│ │ └─ Patch: Bug fixes
│ └─── Minor: New features (backwards compatible)
└───── Major: Breaking changes
```

### Version Bumping

```bash
# Patch (1.2.3 → 1.2.4)
npm version patch

# Minor (1.2.3 → 1.3.0)
npm version minor

# Major (1.2.3 → 2.0.0)
npm version major
```

## Release Checklist

Before creating a release:

- [ ] All features merged to `develop`
- [ ] All tests passing
- [ ] Security scans clean
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped in package.json
- [ ] No known critical bugs

## Rollback Procedure

If a deployment causes issues:

### Option 1: Revert Commit

```bash
git revert <commit-sha>
git push origin main
```

### Option 2: Rollback to Previous Tag

```bash
git checkout v1.1.0
git checkout -b hotfix/rollback
git push origin hotfix/rollback
# Create PR to main
```

### Option 3: CloudFlare Rollback

1. Go to CloudFlare Pages dashboard
2. Find previous successful deployment
3. Click "Rollback to this deployment"

## Monitoring & Alerts

- **Build failures**: GitHub Actions notifications
- **Security issues**: GitHub Security alerts
- **Deployment status**: CloudFlare dashboard
- **Performance**: Lighthouse CI reports

## Resources

- [GitFlow Original Article](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [GitHub Flow vs GitFlow](https://www.atlassian.com/git/tutorials/comparing-workflows)

## Support

Questions about GitFlow?

- Check this document first
- Review CONTRIBUTING.md
- Open an issue
- Contact: osvaloismtz@gmail.com

---

Last Updated: 2025-11-09
