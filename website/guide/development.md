---
outline: deep
---

# Development Guide

Guide for developing and contributing to `sznm_dart_packages`.

## Repository Structure

```
sznm_dart_packages/
├── .fvmrc                    # Flutter version (3.41.5)
├── .gitignore
├── pubspec.yaml              # Melos workspace config
├── packages/
│   └── sznm_lints/          # Main package
│       ├── lib/
│       │   └── flutter.yaml # Lint rules
│       ├── references/      # Lint rule references
│       ├── test/            # Tests (if any)
│       ├── CHANGELOG.md
│       ├── pubspec.yaml
│       └── README.md
├── docs/                     # Markdown docs
├── website/                  # VitePress site
└── scripts/                  # Utility scripts
```

## Setup

### 1. Clone and Install

```bash
git clone https://github.com/agustinusnathaniel/sznm_dart_packages.git
cd sznm_dart_packages
fvm install
fvm dart run melos bootstrap
```

### 2. Verify Setup

```bash
./scripts/verify.sh
```

## Making Changes

### Adding New Lint Rules

1. **Edit `packages/sznm_lints/lib/flutter.yaml`**:

```yaml
linter:
  rules:
    - your_new_rule
```

2. **Update documentation**:
   - Add rule to `website/docs/packages/sznm_lints/rules.md`
   - Include example code and explanation

3. **Update CHANGELOG**:

```md
## 2.1.0

 - **FEAT**: add `your_new_rule` lint rule.
```

4. **Run verification**:

```bash
./scripts/verify.sh
```

### Modifying Existing Rules

1. **Test the change** on a real project
2. **Update documentation** if behavior changes
3. **Add to CHANGELOG** under appropriate section

### Updating Documentation

Documentation is in two places:

1. **Markdown docs** (`docs/`) - Source of truth
2. **Website** (`website/docs/`) - VitePress site

Update both when making changes.

## Committing

### Conventional Commits

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

**Examples:**
```bash
feat: add strict_top_level_inference rule
fix: correct rule documentation
docs: update usage guide
refactor: simplify lint configuration
chore: update dependencies
```

### Pre-commit Checklist

- [ ] Code is formatted (`fvm dart run melos run format-check`)
- [ ] Analysis passes (`fvm dart run melos run analyze`)
- [ ] CHANGELOG updated (if applicable)
- [ ] Documentation updated (if applicable)

## Versioning

Versions are managed automatically by Melos based on commit messages.

### Version Bump Triggers

| Commit Type | Version Bump |
|-------------|--------------|
| `feat:` | Minor (2.0.0 → 2.1.0) |
| `fix:` | Patch (2.0.0 → 2.0.1) |
| `BREAKING CHANGE` | Major (2.0.0 → 3.0.0) |

### Manual Version Override

```bash
# Force specific version
dart --disable-dart-dev pub global run melos version sznm_lints:2.1.0
```

## Testing

### Local Testing

Test lint rules on a sample project:

```bash
# Create test project
mkdir test_project
cd test_project
flutter create .

# Add sznm_lints
cat >> pubspec.yaml <<EOF
dev_dependencies:
  sznm_lints:
    path: ../packages/sznm_lints
EOF

# Configure analysis
cat > analysis_options.yaml <<EOF
include: package:sznm_lints/flutter.yaml
EOF

# Run analysis
flutter analyze
```

### CI Testing

GitHub Actions runs on every push:
- ✅ Code formatting
- ✅ Static analysis
- ✅ Publish dry-run

## Building Documentation

### Local Development

```bash
cd website
yarn install
yarn dev
```

Visit `http://localhost:5173`

### Build Production

```bash
yarn build
yarn preview
```

## Common Tasks

### Adding a New Package

1. Create package directory:
```bash
mkdir -p packages/new_package/lib
```

2. Add `pubspec.yaml`:
```yaml
name: new_package
version: 0.1.0
description: Package description
```

3. Update workspace root `pubspec.yaml`:
```yaml
workspace:
  - packages/sznm_lints
  - packages/new_package  # Add here
```

4. Bootstrap:
```bash
fvm dart run melos bootstrap
```

### Updating Dependencies

```bash
# Update all dependencies
fvm dart pub upgrade

# Update specific package
fvm dart pub upgrade sznm_lints

# Check outdated
fvm dart pub outdated
```

### Cleaning Up

```bash
# Clean Melos
fvm dart run melos clean
fvm dart run melos bootstrap

# Clean build artifacts
find . -name "build" -type d -exec rm -rf {} +
find . -name ".dart_tool" -type d -exec rm -rf {} +
```

## Code Review

### Review Checklist

- [ ] Follows existing code style
- [ ] Includes appropriate documentation
- [ ] CHANGELOG updated
- [ ] Commit message follows convention
- [ ] No analysis errors

### Getting Review

1. Push to a feature branch
2. Create Pull Request
3. Request review from maintainers

## Publishing

See [Release Guide](/guide/releasing) for publishing instructions.

## Getting Help

- 📚 [Documentation](/)
- 🐛 [Issues](https://github.com/agustinusnathaniel/sznm_dart_packages/issues)
- 💬 [Discussions](https://github.com/agustinusnathaniel/sznm_dart_packages/discussions)
