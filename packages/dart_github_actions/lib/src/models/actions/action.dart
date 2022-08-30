import 'package:equatable/equatable.dart';

/// {@template action}
/// The base of any Github Action.
/// {@endtemplate}
abstract class Action extends Equatable {
  /// {@macro action}
  const Action({
    required this.actionOwner,
    required this.actionName,
    required this.actionVersion,
  });

  /// The owner of the action.
  final String actionOwner;

  /// The name of the action.
  final String actionName;

  /// The version of the action.
  final String actionVersion;

  /// The full name of the action, used in a job step.
  String get fullName => '$actionOwner/$actionName@$actionVersion';

  /// Builds the map of inputs for this [Action], used in the step yaml output.
  Map<String, String?> get inputs;
}
