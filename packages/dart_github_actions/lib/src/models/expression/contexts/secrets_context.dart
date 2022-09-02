// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_github_actions/src/models/expression/contexts/context.dart';

/// {@template secrets_context}
/// Context object containing all properties for the [SecretsContext](https://docs.github.com/en/actions/learn-github-actions/contexts#secrets-context).
///
/// Add additional variables to the `secrets` context by defining extension methods:
/// Call the method `formatProperty()` to ensure your variable is outputted correctly in the expression.
/// ```dart
/// extension SecretsContextX on SecretsContext {
///   String get yourVariable => formatProperty('your_variable');
/// }
/// ```
/// {@endtemplate}
class SecretsContext extends Context {
  /// {@macro secrets_context}
  const SecretsContext() : super('secrets');

  /// Automatically created token for each workflow run.
  /// For more information, see "Automatic token authentication."
  String get githubToken => formatProperty('GITHUB_TOKEN');
}
