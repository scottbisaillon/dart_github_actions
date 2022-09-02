import 'package:dart_github_actions/src/models/expression/contexts/contexts.dart';

/// A representation of a funciton that produces a Github Expression.
typedef ExpressionWithContext = String Function(ExpressionContext context);

/// {@template expression_context}
/// An object givnig access to all types of Contexts.
/// {@endtemplate}
class ExpressionContext {
  /// {@macro expression_context}
  const ExpressionContext();

  /// {@macro github_context}
  GithubContext get github => const GithubContext();
}

/// {@template expression}
/// A type-safe representation of [Github Actions Expressions](https://docs.github.com/en/actions/learn-github-actions/expressions).
/// {@endtemplate}
class Expression {
  /// {@macro expression}
  Expression(this.expression);

  /// The funciton to be evaluated for this [Expression].
  ///
  /// This will be passed an instance of [ExpressionContext].
  final ExpressionWithContext expression;

  /// Allows for an [Expression] to be added together with a [String].
  String operator +(String other) => '${toString()}$other';

  @override
  String toString() => '\${{ ${expression(const ExpressionContext())} }}';
}