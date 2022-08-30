import 'dart:io';

import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';

/// {@template workflow}
/// A Github Workflow which runs one or more [Job]s.
/// {@endtemplate}
class Workflow implements YAMLObject {
  /// {@macro workflow}
  Workflow({
    File? targetFile,
    required this.name,
    required this.on,
    required this.jobs,
  })  : assert(on.isNotEmpty, 'At least one trigger must be defined.'),
        assert(jobs.isNotEmpty, 'At least one job must be defined.'),
        sourceFile = Platform
            .script.pathSegments[Platform.script.pathSegments.length - 1],
        targetFile = targetFile ??
            File(
              '${Directory.current.path}/workflows/${Platform.script.pathSegments[Platform.script.pathSegments.length - 1].replaceAll('.dart', '.yaml')}',
            );

  /// The
  final String sourceFile;

  /// The file name to write to.
  final File targetFile;

  /// The name of this [Workflow].
  final String name;

  /// The list of triggers for this [Workflow].
  final List<Trigger> on;

  /// The list of [Job]s that will run in this [Workflow].
  final List<Job> jobs;

  @override
  Map<String, dynamic> toYaml() => {
        'name': name,
        'on': {for (final trigger in on) trigger.label: trigger},
        'jobs': {for (final job in jobs) job.id: job},
      }.whereNotNull();

  /// Writes this [Workflow] as yaml to [targetFileName].
  Future<void> writeYamlToFile() async {
    const write = YAMLWriter();

    final fileHeader = '''
# This workflow has been generated using dart_github_actions (https://github.com/scottbisaillon/dart_github_actions).
# All modifications should be made to '$sourceFile' and the workflow regenerated.
''';

    await targetFile.writeAsString('$fileHeader\n${write.write(this)}');
  }
}
