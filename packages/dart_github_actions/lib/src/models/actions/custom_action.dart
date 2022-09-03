import 'package:dart_github_actions/src/models/models.dart';

/// {@template custom_action_output}
/// A simple [ActionOutput] used to expose the outputs of [CustomAction].
/// {@endtemplate}
class CustomActionOutput extends ActionOutput {
  /// {@macro custom_action_output}
  CustomActionOutput(super.stepId);
}

/// {@template custom_action}
/// Used in place of extending [Action] or [ActionWithOutputs] to provide an
/// [Action] definition without needing to explicitly type its inputs
/// and outputs.
/// {@endtemplate}
class CustomAction extends ActionWithOutputs<CustomActionOutput> {
  /// {@macro custom_action}
  const CustomAction({
    required super.actionOwner,
    required super.actionName,
    required super.actionVersion,
    this.inputs = const {},
  });

  /// The inputs of this [Action].
  @override
  final Map<String, String?> inputs;

  @override
  CustomActionOutput buildOutputObject(String stepId) =>
      CustomActionOutput(stepId);

  @override
  List<Object?> get props => [actionOwner, actionName, actionVersion, inputs];
}
