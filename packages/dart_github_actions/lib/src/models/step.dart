import 'package:dart_github_actions/src/models/models.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:equatable/equatable.dart';

/// {@template step}
/// The base class for all steps that can be contained by a job.
/// {@endtemplate}
abstract class Step extends Equatable implements YAMLObject {
  /// {@macro step}
  const Step({
    required this.id,
    this.name,
    this.env,
  });

  /// The unique identifier of the step.
  final String id;

  /// Optional name of the step.
  final String? name;

  /// The environment variables for a step.
  final Map<String, String>? env;
}

/// {@template command_step}
/// A job step that runs the given [command].
/// {@endtemplate}
class CommandStep extends Step {
  /// {@macro command_step}
  const CommandStep({
    required super.id,
    super.name,
    required this.command,
    super.env,
  });

  /// The command to run during this step.
  final String command;

  @override
  Map<String, dynamic> toYaml() => {
        'id': id,
        'name': name,
        'run': command,
        'env': env,
      }.whereNotNull();

  @override
  List<Object?> get props => [id, name, command, env];
}

/// {@template step_output}
/// The base for all [Step] outputs.
/// {@endtemplate}
abstract class StepOutput {
  /// {@macro action_output}
  const StepOutput(this.stepId);

  /// The id of the step this [Action] is associated
  final String stepId;

  /// Formats the output with correct accessor given the [stepId].
  String formatOutput(String output) => 'steps.$stepId.outputs.$output';
}

/// A function definition for building a [StepOutput] given the [stepId].
typedef StepOutputBuilder<T extends StepOutput> = T Function(String stepId);

/// {@template step_with_output}
/// The base for all [Step]s with outputs.
/// {@endtemplate}
abstract class StepWithOutput<T extends StepOutput> extends Step {
  /// {@macro step_with_output}
  const StepWithOutput({
    required super.id,
    super.name,
    super.env,
    required this.buildOutput,
  });

  /// A builder function for the step's output.
  final StepOutputBuilder<T> buildOutput;

  /// Getter for this [Step]'s output.
  T get output => buildOutput(id);
}

/// {@template command_step_with_output}
/// A [CommandStep] that exposes one more more outputs.
/// {@endtemplate}
class CommandStepWithOutput<T extends StepOutput> extends StepWithOutput<T> {
  /// {@macro command_step_with_output}
  const CommandStepWithOutput({
    required super.id,
    super.name,
    required this.command,
    super.env,
    required super.buildOutput,
  });

  /// The command to run during this step.
  final String command;

  @override
  Map<String, dynamic> toYaml() => {
        'id': id,
        'name': name,
        'run': command,
        'env': env,
      }.whereNotNull();

  @override
  List<Object?> get props => [id, name, command, env];
}

/// {@template action_step}
/// A job step that runs the specified [action].
/// {@endtemplate}
class ActionStep extends Step {
  /// {@macro action_step}
  const ActionStep({
    required super.id,
    super.name,
    required this.action,
    super.env,
  });

  /// The action to run in this [Step].
  final Action action;

  @override
  Map<String, dynamic> toYaml() => {
        'id': id,
        'name': name,
        'uses': action.fullName,
        'with': action.inputs.isNotEmpty ? action.inputs.whereNotNull() : null,
        'env': env,
      }.whereNotNull();

  @override
  List<Object?> get props => [id, name, action, env];
}

/// {@template action_step_with_output}
/// An [ActionStep] that exposes one more more outputs.
/// {@endtemplate}
class ActionStepWithOutput<T extends StepOutput> extends StepWithOutput<T> {
  /// {@macro action_step_with_output}
  const ActionStepWithOutput({
    required super.id,
    super.name,
    required this.action,
    super.env,
    required super.buildOutput,
  });

  /// The action to run in this [Step].
  final Action action;

  @override
  Map<String, dynamic> toYaml() => {
        'id': id,
        'name': name,
        'uses': action.fullName,
        'with': action.inputs.isNotEmpty ? action.inputs.whereNotNull() : null,
        'env': env,
      }.whereNotNull();

  @override
  List<Object?> get props => [id, name, action, env];
}
