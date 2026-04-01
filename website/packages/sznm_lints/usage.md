---
outline: deep
---

# Usage Guide

How to use `sznm_lints` in your projects.

## Quick Setup

### Step 1: Add Dependency

In your `pubspec.yaml`:

```yaml
dev_dependencies:
  sznm_lints: ^2.0.0
```

### Step 2: Configure Analysis

Create or update `analysis_options.yaml` in your project root:

```yaml
include: package:sznm_lints/flutter.yaml
```

### Step 3: Run Analysis

```bash
dart analyze
# or
flutter analyze
```

## Project Types

### Flutter App

```yaml
# analysis_options.yaml
include: package:sznm_lints/flutter.yaml

# Additional project-specific rules can be added here
linter:
  rules:
    # Override specific rules if needed
    avoid_print: false # Allow print statements in development
```

### Flutter Package

```yaml
# analysis_options.yaml
include: package:sznm_lints/flutter.yaml

# For packages, you might want stricter rules
linter:
  rules:
    public_member_api_docs: true # Require API documentation
```

### Dart CLI Application

```yaml
# analysis_options.yaml
include: package:lints/recommended.yaml

linter:
  rules:
    # Import specific rules from sznm_lints
    - always_declare_return_types
    - prefer_single_quotes
    - require_trailing_commas
    - sort_constructors_first
    - avoid_print
```

## IDE Integration

### VS Code

The lint rules work automatically with the Dart extension. You'll see:
- 🔴 Errors for rule violations
- 💡 Quick fixes for auto-correctable issues
- 📝 Suggestions in the Problems panel

### Android Studio / IntelliJ

1. Enable Dart analysis in Settings → Languages & Frameworks → Dart
2. Lint errors appear in the Analysis panel
3. Use `Option+Enter` (macOS) or `Alt+Enter` (Windows/Linux) for quick fixes

### Cursor / AI Editors

Add to your project rules:

```md
## Code Style

This project uses `sznm_lints` for linting. Key rules:
- Always specify types explicitly
- Use single quotes for strings
- Add trailing commas in multi-line collections
- Sort constructors before other methods
```

## Customizing Rules

### Disable Specific Rules

```yaml
include: package:sznm_lints/flutter.yaml

linter:
  rules:
    avoid_print: false # Allow print statements
    flutter_style_todos: false # Use your own TODO style
```

### Enable Additional Rules

```yaml
include: package:sznm_lints/flutter.yaml

linter:
  rules:
    public_member_api_docs: true # Require API docs
    lines_longer_than_80_chars: false # Allow longer lines
```

## Ignoring Lints

### Ignore Specific Line

```dart
// ignore: avoid_print
print('Debug info');
```

### Ignore Multiple Lines

```dart
// ignore_for_file: avoid_print

print('Debug 1');
print('Debug 2');
```

### Ignore Entire File

```dart
// ignore_for_file: avoid_print, prefer_single_quotes

// All code in this file ignores these rules
```

## CI/CD Integration

### GitHub Actions

```yaml
name: CI
on: [push, pull_request]
jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - uses: koji-1009/setup-flutter@v1
        with:
          flutter-version-file: '.fvmrc'
      - run: flutter pub get
      - run: flutter analyze
```

### Pre-commit Hook

```bash
#!/bin/bash
# .git/hooks/pre-commit

flutter analyze
if [ $? -ne 0 ]; then
  echo "❌ Analysis failed. Please fix errors before committing."
  exit 1
fi
```

## Troubleshooting

### Rule Not Found

**Error:** `The rule 'xyz' doesn't exist`

**Solution:** Make sure you have the latest version:
```bash
flutter pub upgrade sznm_lints
```

### Too Many Errors

If migrating from a less strict linter:

1. Fix errors incrementally
2. Temporarily disable problematic rules:
   ```yaml
   linter:
     rules:
       always_specify_types: false
   ```
3. Re-enable rules as you fix code

### IDE Not Showing Lints

1. Restart the Dart analysis server
2. VS Code: `Ctrl+Shift+P` → "Dart: Restart Analysis Server"
3. IntelliJ: File → Invalidate Caches → Invalidate and Restart

## Next Steps

- [View All Rules](/packages/sznm_lints/rules)
- [Getting Started Guide](/guide/getting-started)
- [Report Issues](https://github.com/agustinusnathaniel/sznm_dart_packages/issues)
