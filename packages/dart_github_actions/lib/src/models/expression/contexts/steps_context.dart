import 'package:dart_github_actions/dart_github_actions.dart';
import 'package:dart_github_actions/src/models/expression/contexts/context.dart';

/// {@template steps_context}
/// Context object containing all properties for the [Steps Context](https://docs.github.com/en/actions/learn-github-actions/contexts#steps-context).
/// {@endtemplate}
class StepsContext extends Context {
  /// {@macro steps_context}
  const StepsContext() : super('steps');

  /// The value of a specific output for a step.
  T step<T extends StepOutput>(StepWithOutput<T> step) => step.output;
}
