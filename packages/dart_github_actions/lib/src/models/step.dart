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
