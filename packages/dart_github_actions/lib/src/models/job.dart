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
    this.needs,
    this.defaults,
    required this.runsOn,
    this.env,
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

  /// The map of environment variables for this [Job].
  final Map<String, String>? env;

  /// Any jobs that must complete successfully before this job will run.
  final List<Job>? needs;

  /// The list of steps to run as a part of this [Job].
  final List<Step> steps;

  @override
  Map<String, dynamic> toYaml() => {
        'name': name,
        'defaults': defaults,
        'needs': needs != null
            ? YamlStringList(needs!.map((e) => e.id).toList())
            : null,
        'runs-on': runsOn.label,
        'env': env,
        'steps': steps,
      }.whereNotNull();
}

/// {@template job_output}
/// The base for all [Job] outputs.
/// {@endtemplate}
abstract class JobOutput {
  /// {@macro action_output}
  const JobOutput(this.jobId);

  /// The id of the step this [Action] is associated
  final String jobId;

  /// Formats the output with correct accessor given the [jobId].
  String formatOutput(String output) => 'needs.$jobId.outputs.$output';
}

/// {@template job_with_output}
/// A [Job] that exposes one ore more outputs that can be used in another [Job].
///
/// see: https://docs.github.com/en/actions/using-jobs/defining-outputs-for-jobs.
/// {@endtemplate}
class JobWithOutput<T extends JobOutput> extends Job {
  /// {@macro job_with_outputs}
  JobWithOutput({
    required super.id,
    required super.runsOn,
    super.needs,
    super.env,
    required this.outputs,
    required this.buildOutput,
  });

  /// The outputs of this [Job.]
  ///
  /// see: https://docs.github.com/en/actions/using-jobs/defining-outputs-for-jobs
  final Map<String, String> outputs;

  /// A builder function for the job's output.
  final T Function(String jobId) buildOutput;

  /// Getter for this [Job]'s output given its [id].
  T get output => buildOutput(id);

  @override
  Map<String, dynamic> toYaml() => {
        'name': name,
        'defaults': defaults,
        'outputs': outputs,
        'needs': needs != null
            ? YamlStringList(needs!.map((e) => e.id).toList())
            : null,
        'runs-on': runsOn.label,
        'steps': steps,
      }.whereNotNull();
}

/// [Job] extension methods for adding [CommandStep] and [ActionStep]s.
extension JobX on Job {
  /// Adds an [ActionStep] to the [Job]s steps.
  void uses(Action action, {String? id, String? name, bool condition = true}) {
    if (condition) {
      usesAction(
        ActionStep(
          id: id ?? 'step-${steps.length}',
          name: name,
          action: action,
        ),
      );
    }
  }

  /// Adds the [actionStep] to the [Job]s steps.
  void usesAction(ActionStep actionStep, {bool condition = true}) {
    if (condition) {
      steps.add(actionStep);
    }
  }

  /// Adds an [CommandStep] to the [Job]s steps.
  void run(String command, {String? id, String? name, bool condition = true}) {
    runCommandStep(
      CommandStep(
        id: id ?? 'step-${steps.length}',
        name: name,
        command: command,
      ),
      condition: condition,
    );
  }

  /// Adds the [step] to the [Job]s steps.
  void runCommandStep(CommandStep step, {bool condition = true}) {
    if (condition) {
      steps.add(step);
    }
  }
}
