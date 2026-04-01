---
outline: deep
---

# All Lint Rules

Complete list of all 40+ lint rules included in `sznm_lints`.

## Overview

sznm_lints extends [`flutter_lints`](https://pub.dev/packages/flutter_lints) with **42 additional rules** organized into categories:

| Category | Count | Description |
|----------|-------|-------------|
| 🎯 Type Safety | 8 | Explicit types and proper type handling |
| 📝 Code Style | 12 | Consistent formatting and style |
| 🔒 Null Safety | 5 | Proper null safety practices |
| ⚡ Performance | 4 | Avoid performance pitfalls |
| ✅ Best Practices | 13 | General Dart/Flutter best practices |

---

## Type Safety Rules

### `always_declare_return_types`
Always declare return types for functions and methods.

```dart
// ✅ GOOD
String getName() => 'John';

// ❌ BAD
getName() => 'John'; // Missing return type
```

**Why:** Improves code readability and type safety.

### `always_specify_types`
Always specify type annotations.

```dart
// ✅ GOOD
final String name = 'John';
final List<int> numbers = [1, 2, 3];

// ❌ BAD
final name = 'John'; // Type not specified
final numbers = [1, 2, 3];
```

**Why:** Makes code more explicit and easier to understand.

### `strict_top_level_inference`
Requires explicit types for top-level declarations.

```dart
// ✅ GOOD
const int maxCount = 10;

// ❌ BAD
const maxCount = 10; // Type not specified
```

**Why:** Prevents accidental type changes and improves API clarity.

### `avoid_type_to_string`
Avoid using `Type.toString()` in production code.

```dart
// ✅ GOOD
if (runtimeType == String) { }

// ❌ BAD
if (runtimeType.toString() == 'String') { }
```

**Why:** Type.toString() can be obfuscated in production.

### `test_types_in_equals`
Test types in equality operators.

```dart
// ✅ GOOD
@override
bool operator ==(Object other) =>
    identical(this, other) ||
    other is MyClass && runtimeType == other.runtimeType;
```

**Why:** Ensures proper type checking in equality comparisons.

### `tighten_type_of_initializing_formals`
Use specific types for initializing formals.

```dart
// ✅ GOOD
class Person {
  final String name;
  Person(this.name);
}

// ❌ BAD
class Person {
  final dynamic name;
  Person(this.name);
}
```

### `use_named_constants`
Use named constants instead of magic numbers/strings.

```dart
// ✅ GOOD
const int maxLoginAttempts = 3;
if (attempts > maxLoginAttempts) { }

// ❌ BAD
if (attempts > 3) { } // Magic number
```

### `use_is_even_rather_than_modulo`
Use `isEven`/`isOdd` instead of modulo operator.

```dart
// ✅ GOOD
if (number.isEven) { }

// ❌ BAD
if (number % 2 == 0) { }
```

---

## Code Style Rules

### `always_put_control_body_on_new_line`
Always put control flow statement bodies on a new line.

```dart
// ✅ GOOD
if (condition)
  doSomething();

// ❌ BAD
if (condition) doSomething();
```

### `always_put_required_named_parameters_first`
Place required named parameters before optional ones.

```dart
// ✅ GOOD
void createUser({required String name, int? age}) { }

// ❌ BAD
void createUser({int? age, required String name}) { }
```

### `prefer_single_quotes`
Prefer single quotes for strings.

```dart
// ✅ GOOD
const name = 'John';

// ❌ BAD
const name = "John";
```

### `require_trailing_commas`
Require trailing commas in multi-line collections.

```dart
// ✅ GOOD
final list = [
  'item1',
  'item2',
];

// ❌ BAD
final list = [
  'item1',
  'item2'
];
```

### `sort_constructors_first`
Sort constructors before other members.

```dart
// ✅ GOOD
class Person {
  Person();
  String name;
  void greet() { }
}

// ❌ BAD
class Person {
  String name;
  Person();
  void greet() { }
}
```

### `sort_unnamed_constructors_first`
Sort unnamed constructors before named ones.

```dart
// ✅ GOOD
class Person {
  Person();
  Person.named();
}

// ❌ BAD
class Person {
  Person.named();
  Person();
}
```

### `directives_ordering`
Order directives (imports/exports) properly.

```dart
// ✅ GOOD
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_package/my_package.dart';
import 'my_file.dart';
```

### `eol_at_end_of_file`
Ensure files end with a newline.

### `leading_newlines_in_multiline_strings`
Add leading newlines in multi-line strings.

```dart
// ✅ GOOD
final message = '''
Hello
World
''';

// ❌ BAD
final message = '''Hello
World''';
```

### `no_adjacent_strings_in_list`
Don't use adjacent strings in list.

```dart
// ✅ GOOD
final items = ['item1', 'item2', 'item3'];

// ❌ BAD
final items = ['item1' 'item2', 'item3'];
```

### `unnecessary_parenthesis`
Avoid unnecessary parentheses.

```dart
// ✅ GOOD
if (condition) { }

// ❌ BAD
if ((condition)) { }
```

---

## Null Safety Rules

### `prefer_null_aware_method_calls`
Use null-aware method calls.

```dart
// ✅ GOOD
text?.length;

// ❌ BAD
text != null ? text.length : null;
```

### `unnecessary_null_checks`
Avoid unnecessary null checks.

```dart
// ✅ GOOD
final length = text.length;

// ❌ BAD
final length = text!.length; // text is already non-nullable
```

### `null_check_on_nullable_type_parameter`
Don't null-check nullable type parameters.

### `avoid_bool_literals_in_conditional_expressions`
Avoid boolean literals in conditional expressions.

```dart
// ✅ GOOD
if (condition) return true;

// ❌ BAD
return condition ? true : false;
```

### `prefer_if_elements_to_conditional_expressions`
Prefer if elements to conditional expressions.

---

## Performance Rules

### `avoid_dynamic_calls`
Avoid dynamic calls.

```dart
// ✅ GOOD
void process(Object data) {
  if (data is String) {
    print(data.length);
  }
}

// ❌ BAD
void process(Object data) {
  print(data.length); // Dynamic call
}
```

### `avoid_slow_async_io`
Avoid slow async I/O operations.

### `avoid_void_async`
Avoid async functions with void return type.

```dart
// ✅ GOOD
Future<void> loadData() async { }

// ❌ BAD
void loadData() async { }
```

### `cancel_subscriptions`
Cancel stream subscriptions.

```dart
// ✅ GOOD
final sub = stream.listen((data) { });
sub.cancel();

// ❌ BAD
stream.listen((data) { }); // Never cancelled
```

---

## Best Practices

### `avoid_equals_and_hash_code_on_mutable_classes`
Don't override == and hashCode on mutable classes.

### `avoid_field_initializers_in_const_classes`
Avoid field initializers in const classes.

### `avoid_unused_constructor_parameters`
Don't have unused constructor parameters.

### `deprecated_consistency`
Use @Deprecated consistently.

### `flutter_style_todos`
Use Flutter-style TODOs.

```dart
// ✅ GOOD
// TODO(username): Add feature

// ❌ BAD
// todo: add feature
```

### `package_api_docs`
Provide API documentation for public members.

### `prefer_asserts_in_initializer_lists`
Prefer asserts in initializer lists.

### `prefer_foreach`
Prefer forEach for simple iterations.

### `prefer_if_elements_to_conditional_expressions`
Prefer if elements.

### `throw_in_finally`
Don't throw in finally blocks.

### `unnecessary_statements`
Avoid unnecessary statements.

### `use_late_for_private_fields_and_variables`
Use `late` for private fields when appropriate.

### `use_raw_strings`
Use raw strings for regex and paths.

```dart
// ✅ GOOD
final path = r'C:\Users\name';

// ❌ BAD
final path = 'C:\\Users\\name';
```

### `use_test_throws_matchers`
Use test throws matchers.

---

## Related Links

- [Usage Guide](/packages/sznm_lints/usage)
- [sznm_lints Overview](/packages/sznm_lints/)
- [flutter_lints](https://pub.dev/packages/flutter_lints)
- [Dart Linter Rules](https://dart-lang.github.io/linter/lints/)

## Contributing

Found a rule that should be added or removed? [Open an issue](https://github.com/agustinusnathaniel/sznm_dart_packages/issues).
