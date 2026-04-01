# sznm_dart_packages Documentation

Internal documentation for the sznm_dart_packages monorepo.

## Table of Contents

- [Project Structure](#project-structure)
- [Development Setup](#development-setup)
- [Commands Reference](#commands-reference)
- [Release Guide](#release-guide)
- [Lint Rules](#lint-rules)

---

## Project Structure

```
sznm_dart_packages/
├── .fvmrc                          # FVM Flutter version config
├── .gitignore
├── docs/                           # Documentation
├── packages/
│   └── sznm_lints/                 # Lint rules package
│       ├── lib/
│       │   └── flutter.yaml        # Lint rules configuration
│       ├── references/             # Lint rule references
│       ├── CHANGELOG.md
│       ├── pubspec.yaml
│       └── README.md
├── scripts/                        # Utility scripts
│   └── verify.sh                   # Pre-publish verification
├── pubspec.yaml                    # Workspace root (Melos 7.x)
└── website/                        # Documentation website (VitePress)
```

---

## Development Setup

### Prerequisites

1. **Install FVM** (Flutter Version Manager):
   ```bash
   brew install fvm  # macOS
   # or
   curl -fsSL https://fvm.app/install | sh
   ```

2. **Install Melos** (monorepo tool):
   ```bash
   dart pub global activate melos
   ```

### Setup Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sozonome/sznm_dart_packages.git
   cd sznm_dart_packages
   ```

2. **Install Flutter SDK via FVM**:
   ```bash
   fvm install
   ```

3. **Bootstrap the workspace**:
   ```bash
   fvm dart run melos bootstrap
   ```

### GitHub Actions Setup

For CI/CD workflows, use the latest official actions:

```yaml
- name: Checkout
  uses: actions/checkout@v6

- name: Setup Dart
  uses: dart-lang/setup-dart@v1.7.2

- name: Install FVM
  run: dart pub global activate fvm

- name: Use Flutter Version from .fvmrc
  run: fvm use
```

**Action versions used:**
- `actions/checkout@v6` - Latest stable (Jan 2026)
- `dart-lang/setup-dart@v1.7.2` - Latest stable (Mar 2026)

This approach:
- Uses the official `dart-lang/setup-dart` action
- Installs FVM globally
- Reads `.fvmrc` automatically to install the correct Flutter version

---

## Commands Reference

### Daily Development

```bash
# Analyze all packages
fvm dart run melos run analyze

# Check code formatting
fvm dart run melos run format-check

# Format all code
fvm dart run melos run format

# Run verification (before publishing)
fvm dart run melos run verify
# or
./scripts/verify.sh
```

### Version & Release

```bash
# Preview version changes (dry-run)
fvm dart run melos run release-dry-run

# Create version commit with tags
fvm dart run melos run release

# Publish to pub.dev (dry-run by default)
fvm dart run melos run publish-dry-run

# Actually publish to pub.dev
fvm dart run melos run publish-all
```

### Manual Version Override

```bash
# Manually specify version bump
dart --disable-dart-dev pub global run melos version sznm_lints:minor
```

### GitHub Actions Workflows

This repository includes automated workflows:

| Workflow | Trigger | Description |
|----------|---------|-------------|
| `ci.yaml` | Push/PR to `main` | Runs analyze, format check, and verification |
| `release.yaml` | Push to `main` | Automatically creates version commits and tags |
| `publish.yaml` | Tag push (`sznm_lints-v*`) | Publishes to pub.dev |

**Tag Pattern:**

Melos uses the format `<package_name>-v<version>` for tags:
- `sznm_lints-v2.0.0`
- `sznm_lints-v2.0.1`
- `sznm_lints-v2.1.0`

This pattern ensures unique tags for each package in the monorepo.

**Automated Release Flow:**

1. Push feature commits to `main`
2. `release.yaml` automatically:
   - Runs `melos version` to bump versions
   - Commits changelog and pubspec changes
   - Creates git tags (e.g., `sznm_lints-v2.0.1`)
   - Creates GitHub releases with auto-generated notes
3. `publish.yaml` automatically:
   - Detects new tag matching `sznm_lints-v*`
   - Publishes to pub.dev

No manual intervention required!

---

## Release Guide

### Automated Release (Recommended)

This project uses **Melos** with **Conventional Commits** for automated versioning, similar to `commit-and-tag-version` in the npm ecosystem.

#### Step 1: Ensure Conventional Commits

Commits should follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types that trigger version bumps:**

| Type | Version Bump | Example |
|------|--------------|---------|
| `feat` | Minor | `feat: add new lint rule` |
| `fix` | Patch | `fix: correct rule configuration` |
| `perf` | Patch | `perf: improve analysis speed` |
| `refactor` | Patch | `refactor: simplify lint logic` |
| `docs` | Patch | `docs: update README` |
| `bug` | Patch | `bug: fix false positive` |
| `revert` | Patch | `revert: revert previous commit` |

**Breaking changes:** Add `BREAKING CHANGE` in the footer or use `!` after the type:
```
feat!: remove deprecated rule
```

#### Step 2: Run Release

```bash
# 1. Preview what will change
fvm dart run melos run release-dry-run

# 2. If satisfied, create the release
fvm dart run melos run release
```

**What happens:**
- ✅ Analyzes commits since last version tag
- ✅ Determines version bump (major/minor/patch)
- ✅ Updates `pubspec.yaml` with new version
- ✅ Updates `CHANGELOG.md` (both root and package-level)
- ✅ Creates git commit: `chore(release): publish packages`
- ✅ Creates git tag: `sznm_lints-v2.0.1`

#### Step 3: Push Changes

```bash
git push origin main --tags
```

#### Step 4: Publish to pub.dev

```bash
# 1. Dry-run first
fvm dart run melos run publish-dry-run

# 2. Actually publish
fvm dart run melos run publish-all
```

### Manual Release

If you need to manually control the version:

```bash
# Specify exact version bump
dart --disable-dart-dev pub global run melos version sznm_lints:minor

# Or specify exact version
dart --disable-dart-dev pub global run melos version sznm_lints:2.1.0
```

### Publishing to pub.dev

1. **Ensure you're logged in**:
   ```bash
   dart pub login
   ```

2. **Run verification**:
   ```bash
   ./scripts/verify.sh
   ```

3. **Publish**:
   ```bash
   cd packages/sznm_lints
   fvm dart pub publish
   ```

---

## Lint Rules

### Configuration

The lint rules are defined in `packages/sznm_lints/lib/flutter.yaml`.

### Base Configuration

This package extends [`flutter_lints`](https://pub.dev/packages/flutter_lints) with additional strict rules:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # 40+ additional strict rules for:
    # - Type annotations
    # - Code style consistency
    # - Error handling
    # - Performance
    # - Documentation
```

### Usage in Projects

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  sznm_lints: ^2.0.0
```

Create `analysis_options.yaml`:

```yaml
include: package:sznm_lints/flutter.yaml
```

### Available Rules

See [`lib/flutter.yaml`](../packages/sznm_lints/lib/flutter.yaml) for the complete list of enabled rules.

---

## Troubleshooting

### Melos Commands Not Found

If `melos version` or `melos publish` commands are not available:

```bash
# Reinstall melos globally
dart pub global activate melos

# Ensure pub cache is in PATH
export PATH="$HOME/.pub-cache/bin:$PATH"
```

### FVM Issues

```bash
# Reinstall Flutter SDK
fvm remove 3.41.5
fvm install

# Re-link workspace
fvm dart run melos bootstrap
```

### Publishing Issues

```bash
# Check pub.dev login status
dart pub token list

# Clear pub cache
rm -rf ~/.pub-cache
dart pub get
```

---

## Related Resources

- [Melos Documentation](https://melos.invertase.dev/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [FVM Documentation](https://fvm.app/)
- [Dart Pub Publishing](https://dart.dev/tools/pub/publishing)
- [flutter_lints](https://pub.dev/packages/flutter_lints)
