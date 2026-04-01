# Maintenance Log

## 2026-04-01: Major Repository Update

### Changes Made

#### 1. Flutter/Dart SDK Update
- **Flutter**: 3.3.1 → **3.41.5** (latest stable)
- **Dart**: 2.15 → **3.11.3**
- **flutter_lints**: ^2.0.1 → **^6.0.0**

#### 2. Melos 7.x Migration
- Migrated from `melos.yaml` to `pubspec.yaml` workspace configuration
- Added `resolution: workspace` to package pubspec
- Updated to melos ^7.3.0

#### 3. FVM Configuration
- Removed legacy `.fvm/fvm_config.json`
- Using `.fvmrc` (new standard format)
- Updated `.gitignore` accordingly

#### 4. Lint Rules Update
- Removed redundant rules (already in `flutter_lints`)
- Added new rules from `lints` 6.0.0:
  - `strict_top_level_inference`
  - `unnecessary_underscores`
- Total: 42 custom rules on top of `flutter_lints`

#### 5. Documentation
- Created `docs/` directory
- Added comprehensive README with:
  - Project structure
  - Development setup guide
  - Commands reference
  - Release guide
  - Lint rules documentation
- Added `docs/RELEASE.md` checklist
- Created `scripts/verify.sh` for pre-publish verification

#### 6. Release Automation
- Configured melos version command with conventional commits
- Added scripts:
  - `release` - Create version commit
  - `release-dry-run` - Preview version changes
  - `publish-all` - Publish to pub.dev
  - `publish-dry-run` - Test publish
- Created GitHub Actions workflows:
  - `ci.yaml` - CI checks on push/PR
  - `release.yaml` - Automated releases on push to main
  - `publish.yaml` - Auto-publish to pub.dev on tag

#### 7. GitHub Actions Workflows
- Removed old Node.js-based workflows (`release-please.yml`, `release.yml`)
- Created Flutter/Dart-native workflows using FVM and Melos
- Configured OIDC trusted publishing for pub.dev (no credentials needed)

### Files Modified

```
.fvmrc (updated)
.fvm/fvm_config.json (removed)
.gitignore (updated)
melos.yaml (removed)
pubspec.yaml (created)
pubspec.lock (created)
packages/sznm_lints/pubspec.yaml (updated)
packages/sznm_lints/lib/flutter.yaml (updated)
packages/sznm_lints/CHANGELOG.md (updated)
docs/README.md (created)
docs/RELEASE.md (created)
scripts/verify.sh (created)
```

### Breaking Changes

- **sznm_lints v2.0.0**: Requires Dart ^3.8.0 and Flutter >=3.41.0
- **melos.yaml removed**: Configuration now in root `pubspec.yaml`

### Migration Notes

For projects using `sznm_lints`:

```yaml
# Old (sznm_lints < 2.0.0)
dev_dependencies:
  sznm_lints: ^1.0.0

# New (sznm_lints >= 2.0.0)
dev_dependencies:
  sznm_lints: ^2.0.0

environment:
  sdk: ^3.8.0  # Required
```

### Verification

All checks passed:
- ✅ `melos bootstrap`
- ✅ `dart analyze packages`
- ✅ `dart format --set-exit-if-changed`
- ✅ `dart pub publish --dry-run`

---

## Previous Versions

### 2022-XX-XX: Initial Setup
- Created `sznm_lints` package
- Based on `flutter_lints` with custom rules
- Used FVM for Flutter version management
