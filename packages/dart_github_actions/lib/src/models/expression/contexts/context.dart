/// {@template context}
/// A base class for all contexts to extend.
/// {@endtemplate}
abstract class Context {
  /// {@macro context}
  const Context(this.base);

  /// The base path
  final String base;

  /// Formats the property with the [base] path.
  String formatProperty(String property) => '$base.$property';
}
