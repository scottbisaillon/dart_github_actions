import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/models/expression/contexts/context.dart';

/// {@template needs_context}
/// Context object containing all properties for the [Needs Context](https://docs.github.com/en/actions/learn-github-actions/contexts#needs-context).
/// {@endtemplate}
class NeedsContext extends Context {
  /// {@macro needs_context}
  const NeedsContext() : super('needs');

  /// The value of a specific output for a job that the current job depends on.
  T job<T extends JobOutput>(JobWithOutput<T> job) => job.output;

  /// The result of a job that the current job depends on.
  /// Possible values are success, failure, cancelled, or skipped.
  String result(Job job) => formatProperty('${job.id}.result');
}
