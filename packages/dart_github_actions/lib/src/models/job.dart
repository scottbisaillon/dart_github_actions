import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';

/// {@template defaults}
/// A set of defaults to apply to a [Job].
/// {@endtemplate}
class Defaults implements YAMLObject {
  /// {@macro defaults}
  const Defaults({
    required this.run,
  });

  /// Used to provide default shell and working-directory options for all run
  /// steps in a workflow.
  final Run run;

  @override
  Map<String, dynamic> toYaml() => {
        'run': run,
      };
}

/// {@template run}
///
/// {@endtemplate}
class Run implements YAMLObject {
  /// {@macro run}
  const Run({required this.workingDirectory});

  /// The working directory of where the job will be run.
  final String workingDirectory;

  @override
  Map<String, dynamic> toYaml() => {
        'working-directory': workingDirectory,
      };
}

/// {@template job}
/// A job that is run as a part of a workflow.
/// {@endtemplate}
class Job implements YAMLObject {
  /// {@macro job}
  Job({
    required this.id,
    this.name,
    this.defaults,
    required this.runsOn,
    List<Step>? steps,
  }) : steps = steps ?? [];

  /// A unique identifier for this [Job].
  final String id;

  /// An optional name for this [Job].
  final String? name;

  /// Optionally provide default values for this [Job].
  final Defaults? defaults;

  /// The type of machine to run this [Job] on.
  final RunnerType runsOn;

  /// The list of steps to run as a part of this [Job].
  final List<Step> steps;

  @override
  Map<String, dynamic> toYaml() => {
        'name': name,
        'defaults': defaults,
        'runs-on': runsOn.label,
        'steps': steps,
      }.whereNotNull();
}

/// [Job] extension methods for adding [CommandStep] and [ActionStep]s.
extension JobX on Job {
  /// Adds an [ActionStep] to the [Job]s steps.
  void uses(Action action, {String? id, String? name, bool condition = true}) {
    if (condition) {
      steps.add(
        ActionStep(
          id: id ?? 'step-${steps.length}',
          name: name,
          action: action,
        ),
      );
    }
  }

  /// Adds an [CommandStep] to the [Job]s steps.
  void run(String command, {String? id, String? name, bool condition = true}) {
    if (condition) {
      steps.add(
        CommandStep(
          id: id ?? 'step-${steps.length}',
          name: name,
          command: command,
        ),
      );
    }
  }
}
