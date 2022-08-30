import 'package:dart_github_actions/src/models/actions/actions.dart';

/// {@template action_output}
/// The base for all [Action] outputs.
/// {@endtemplate}
abstract class ActionOutput {
  /// {@macro action_output}
  const ActionOutput(this.stepId);

  /// The id of the step this [Action] is associated
  final String stepId;

  /// Allows for getting the output by name using 'ouputObject[outputName]'.
  String operator [](String outputName) => 'steps.$stepId.outputs.$outputName';
}

/// {@template action_with_outputs}
/// An action that has outputs.
/// {@endtemplate}
abstract class ActionWithOutputs<T extends ActionOutput> extends Action {
  /// {@macro action_with_outputs}
  const ActionWithOutputs({
    required super.actionOwner,
    required super.actionName,
    required super.actionVersion,
  });

  /// Builds the output object given the [stepId].
  T buildOutputObject(String stepId);
}
