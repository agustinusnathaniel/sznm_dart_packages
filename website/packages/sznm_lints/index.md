---
outline: deep
---

# sznm_lints

[![pub package](https://img.shields.io/pub/v/sznm_lints.svg)](https://pub.dev/packages/sznm_lints)
[![likes](https://img.shields.io/pub/likes/sznm_lints)](https://pub.dev/packages/sznm_lints/score)
[![pub points](https://img.shields.io/pub/points/sznm_lints)](https://pub.dev/packages/sznm_lints/score)

agustinusnathaniel's personal lint rules for Dart and Flutter projects.

## Features

- 🎯 **40+ Additional Rules** - Extends `flutter_lints` with strict rules for better code quality
- 📝 **Type Safety** - Enforces explicit type annotations and proper null safety
- 🎨 **Code Style** - Consistent formatting and style rules
- 🚀 **Performance** - Rules to catch common performance issues
- 📦 **Well Documented** - Each rule includes references and explanations

## Installation

Add `sznm_lints` as a dev dependency in your `pubspec.yaml`:

```yaml
dev_dependencies:
  sznm_lints: ^2.0.0
```

Then create or update your `analysis_options.yaml`:

```yaml
include: package:sznm_lints/flutter.yaml
```

## Requirements

- **Dart**: ^3.8.0
- **Flutter**: >=3.41.0

## What's Included

sznm_lints extends [`flutter_lints`](https://pub.dev/packages/flutter_lints) which itself extends [`package:lints/recommended.yaml`](https://pub.dev/packages/lints).

### Additional Rules (40+)

Some of the key rules added:

| Category | Rules |
|----------|-------|
| **Type Annotations** | `always_specify_types`, `always_declare_return_types` |
| **Code Style** | `prefer_single_quotes`, `require_trailing_commas`, `sort_constructors_first` |
| **Null Safety** | `prefer_null_aware_method_calls`, `unnecessary_null_checks` |
| **Performance** | `avoid_slow_async_io`, `avoid_dynamic_calls` |
| **Best Practices** | `avoid_type_to_string`, `avoid_void_async`, `cancel_subscriptions` |

For the complete list, see [All Rules](/packages/sznm_lints/rules).

## Usage

### Flutter Projects

```yaml
# analysis_options.yaml
include: package:sznm_lints/flutter.yaml
```

### Dart Projects (Non-Flutter)

Create a custom configuration:

```yaml
# analysis_options.yaml
include: package:lints/recommended.yaml

linter:
  rules:
    # Add specific rules from sznm_lints as needed
    - prefer_single_quotes
    - require_trailing_commas
```

## Migration Guide

### From v1.x to v2.0.0

Version 2.0.0 requires:
- Dart SDK ^3.8.0 (was >=2.15.1 <3.0.0)
- Flutter >=3.41.0 (was >=1.17.0)
- flutter_lints ^6.0.0 (was ^2.0.1)

**Breaking Changes:**
- New rules: `strict_top_level_inference`, `unnecessary_underscores`
- Removed redundant rules that are now in `flutter_lints` by default

## Related Packages

- [flutter_lints](https://pub.dev/packages/flutter_lints) - Base lint rules for Flutter
- [lints](https://pub.dev/packages/lints) - Core Dart lint rules
- [very_good_analysis](https://pub.dev/packages/very_good_analysis) - Alternative strict lint rules

## License

MIT License - see [LICENSE](https://github.com/agustinusnathaniel/sznm_dart_packages/blob/main/packages/sznm_lints/LICENSE) for details.
