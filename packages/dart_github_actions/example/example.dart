import 'package:dart_github_actions/dart_github_actions.dart';

void main() async {
  const basePath = 'packages/dart_github_actions';

  await Workflow(
    name: 'dart_github_actions',
    on: [
      Push(
        branches: ['master', 'development'],
        paths: [
          '.github/workflows/build_dart_github_actions.yaml',
          '$basePath/**',
        ],
      )
    ],
    jobs: [
      Job(
        id: 'build',
        runsOn: RunnerType.ubuntuLatest,
        defaults: const Defaults(
          run: Run(workingDirectory: 'packages/dart_github_actions'),
        ),
      )
        ..uses(
          const CustomAction(
            actionOwner: 'actions',
            actionName: 'checkout',
            actionVersion: 'v3',
          ),
        )
        ..uses(
          const CustomAction(
            actionOwner: 'dart-lang',
            actionName: 'setup-dart',
            actionVersion: 'v1',
          ),
        )
        ..run('dart pub get', name: 'Install Dependencies')
        ..run('dart format --set-exit-if-changed .', name: 'Format')
        ..run('dart analyze --fatal-infos --fatal-warnings .', name: 'Analyze')
        ..run('dart run coverage:test_with_coverage', name: 'Run Tests')
    ],
  ).writeYamlToFile();
}
