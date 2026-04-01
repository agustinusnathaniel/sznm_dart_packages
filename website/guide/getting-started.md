---
outline: deep
---

# Getting Started

Quick start guide for working with `sznm_dart_packages`.

## Prerequisites

- **Dart SDK**: ^3.11.0
- **Flutter SDK**: 3.41.5
- **FVM**: Latest version (for version management)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/agustinusnathaniel/sznm_dart_packages.git
cd sznm_dart_packages
```

### 2. Install FVM (if not already installed)

```bash
# macOS
brew install fvm

# Or via Dart
dart pub global activate fvm
```

### 3. Install Flutter SDK

```bash
fvm install
```

This reads `.fvmrc` and installs Flutter 3.41.5.

### 4. Activate Melos

```bash
dart pub global activate melos
```

### 5. Bootstrap Workspace

```bash
fvm dart run melos bootstrap
```

## Project Structure

```
sznm_dart_packages/
├── .fvmrc                    # Flutter version config
├── pubspec.yaml              # Workspace root (Melos 7.x)
├── packages/
│   └── sznm_lints/           # Lint rules package
│       ├── lib/
│       │   └── flutter.yaml  # Lint configuration
│       ├── pubspec.yaml
│       └── CHANGELOG.md
├── docs/                     # Markdown documentation
├── website/                  # VitePress documentation site
└── scripts/                  # Utility scripts
    └── verify.sh            # Pre-publish verification
```

## Development Workflow

### Running Analysis

```bash
# Analyze all packages
fvm dart run melos run analyze

# Analyze specific package
cd packages/sznm_lints
fvm dart analyze
```

### Formatting Code

```bash
# Format all code
fvm dart run melos run format

# Check formatting
fvm dart run melos run format-check
```

### Running Tests

```bash
# Run tests for all packages
fvm dart run melos run test
```

### Verification

Before committing or publishing:

```bash
./scripts/verify.sh
```

This checks:
- ✅ FVM setup
- ✅ Melos workspace
- ✅ Code formatting
- ✅ Static analysis
- ✅ Publish readiness
- ✅ Git status

## Using sznm_lints

### In Your Project

1. Add dependency:
```yaml
dev_dependencies:
  sznm_lints: ^2.0.0
```

2. Configure analysis:
```yaml
# analysis_options.yaml
include: package:sznm_lints/flutter.yaml
```

3. Run analysis:
```bash
flutter analyze
```

See [Usage Guide](/packages/sznm_lints/usage) for more details.

## Next Steps

- [View sznm_lints Documentation](/packages/sznm_lints/)
- [Learn About Lint Rules](/packages/sznm_lints/rules)
- [Development Guide](/guide/development)
- [Release Guide](/guide/releasing)

## Troubleshooting

### FVM Issues

```bash
# Check FVM installation
fvm --version

# List installed Flutter versions
fvm list

# Reinstall Flutter
fvm remove 3.41.5
fvm install
```

### Melos Issues

```bash
# Clean and rebootstrap
fvm dart run melos clean
fvm dart run melos bootstrap
```

### Analysis Errors

```bash
# Get dependencies
fvm dart pub get

# Upgrade dependencies
fvm dart pub upgrade
```

## Getting Help

- 📚 [Documentation](/)
- 🐛 [Report Issues](https://github.com/agustinusnathaniel/sznm_dart_packages/issues)
- 💬 [Discussions](https://github.com/agustinusnathaniel/sznm_dart_packages/discussions)
