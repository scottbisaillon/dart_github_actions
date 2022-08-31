import 'package:dart_github_actions/dart_github_actions.dart';
import 'package:dart_github_actions_wrappers/dart_github_actions_wrappers.dart';

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
      Job(id: 'build', runsOn: RunnerType.ubuntuLatest)
        ..uses(const CheckoutV3())
        ..uses(const SetupDartV1())
        ..run(
          r'''
dart pub global activate coverage
echo "$HOME/.pub-cache/bin" >> "$GITHUB_PATH"
echo "$GITHUB_WORKSPACE/_flutter/.pub-cache/bin" >> "$GITHUB_PATH"
echo "$GITHUB_WORKSPACE/_flutter/bin/cache/dart-sdk/bin" >> "$GITHUB_PATH"
''',
        )
        ..run('dart pub get', name: 'Install Dependencies')
        ..run('dart format --set-exit-if-changed .', name: 'Format')
        ..run('dart analyze --fatal-infos --fatal-warnings .', name: 'Analyze')
        ..run('dart run coverage:test_with_coverage', name: 'Run Tests')
        ..uses(
          const VeryGoodCoverageV1(
            path: 'packages/dart_github_actions/coverage/lcov.info',
          ),
        ),
    ],
  ).writeYamlToFile();
}
