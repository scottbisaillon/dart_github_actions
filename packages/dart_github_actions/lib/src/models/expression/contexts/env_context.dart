// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_github_actions/src/models/expression/contexts/context.dart';

/// {@template env_context}
/// Context object containing all properties for the [Env Context](https://docs.github.com/en/actions/learn-github-actions/contexts#env-context).
///
/// Add variables to the `env` context by defining extension methods:
/// Call the method `formatProperty()` to ensure your variable is outputted correctly in the expression.
/// ```dart
/// extension EnvContextX on EnvContext {
///   String get yourVariable => formatProperty('your_variable');
/// }
/// ```
/// {@endtemplate}
class EnvContext extends Context {
  /// {@macro env_context}
  const EnvContext() : super('env');
}
