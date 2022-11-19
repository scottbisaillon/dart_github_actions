import 'dart:io';

import 'package:dart_github_actions/src/models/models.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFile extends Mock implements File {}

void main() {
  group('Workflow', () {
    final mockFile = MockFile();
    setUp(() {
      when(() => mockFile.writeAsString(any()))
          .thenAnswer((invocation) async => MockFile());
    });

    test('should require at least one trigger', () {
      expect(
        () => Workflow(
          targetFile: MockFile(),
          name: 'Workflow',
          on: [],
          jobs: [
            Job(
              id: 'build',
              runsOn: RunnerType.ubuntuLatest,
              steps: [
                const CommandStep(id: 'step-1', command: 'echo something')
              ],
            ),
            Job(
              id: 'deploy',
              runsOn: RunnerType.ubuntuLatest,
              steps: [
                const CommandStep(id: 'step-1', command: 'echo something else')
              ],
            ),
          ],
        ),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => Workflow(
          targetFile: MockFile(),
          name: 'Workflow',
          on: [
            Push(branches: ['branch'])
          ],
          jobs: [
            Job(
              id: 'build',
              runsOn: RunnerType.ubuntuLatest,
              steps: [
                const CommandStep(id: 'step-1', command: 'echo something')
              ],
            ),
            Job(
              id: 'deploy',
              runsOn: RunnerType.ubuntuLatest,
              steps: [
                const CommandStep(id: 'step-1', command: 'echo something else')
              ],
            ),
          ],
        ),
        returnsNormally,
      );
    });

    test('should require at least one job', () {
      expect(
        () => Workflow(
          targetFile: MockFile(),
          name: 'Workflow',
          on: [
            Push(branches: ['branch1'])
          ],
          jobs: [],
        ),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => Workflow(
          targetFile: MockFile(),
          name: 'Workflow',
          on: [
            Push(branches: ['branch'])
          ],
          jobs: [
            Job(
              id: 'build',
              runsOn: RunnerType.ubuntuLatest,
              steps: [
                const CommandStep(id: 'step-1', command: 'echo something')
              ],
            ),
            Job(
              id: 'deploy',
              runsOn: RunnerType.ubuntuLatest,
              steps: [
                const CommandStep(id: 'step-1', command: 'echo something else')
              ],
            ),
          ],
        ),
        returnsNormally,
      );
    });

    test('should have default file name', () {
      final workflow = Workflow(
        name: 'workflow',
        on: [
          Push(branches: ['branch1'])
        ],
        jobs: [
          Job(
            id: 'build',
            runsOn: RunnerType.ubuntuLatest,
            steps: [const CommandStep(id: 'step-1', command: 'echo something')],
          ),
          Job(
            id: 'deploy',
            runsOn: RunnerType.ubuntuLatest,
            steps: [
              const CommandStep(id: 'step-1', command: 'echo something else')
            ],
          ),
        ],
      );

      expect(
        workflow.targetFile.path,
        endsWith(
          '${Directory.current.path}/workflows/${Platform.script.pathSegments[Platform.script.pathSegments.length - 1].replaceAll('.dart', '.yaml')}',
        ),
      );
    });

    test('should write yaml to file with header', () async {
      final workflow = Workflow(
        targetFile: mockFile,
        name: 'workflow',
        on: [
          Push(branches: ['branch1'])
        ],
        jobs: [
          Job(
            id: 'build',
            runsOn: RunnerType.ubuntuLatest,
            steps: [const CommandStep(id: 'step-1', command: 'echo something')],
          ),
          Job(
            id: 'deploy',
            runsOn: RunnerType.ubuntuLatest,
            steps: [
              const CommandStep(id: 'step-1', command: 'echo something else')
            ],
          ),
        ],
      );

      await workflow.writeYamlToFile();

      verify(
        () => mockFile.writeAsString(
          '''
# This workflow has been generated using dart_github_actions (https://github.com/scottbisaillon/dart_github_actions).
# All modifications should be made to '${Platform.script.pathSegments[Platform.script.pathSegments.length - 1]}' and the workflow regenerated.

name: workflow
on:
  push:
    branches:
      - branch1
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      -
        id: step-1
        run: echo something
  deploy:
    runs-on: ubuntu-latest
    steps:
      -
        id: step-1
        run: echo something else
''',
        ),
      ).called(1);
    });

    group('toYaml', () {
      const writer = YAMLWriter();

      test('should have correct yaml representation', () {
        final yaml = writer.write(
          Workflow(
            targetFile: MockFile(),
            name: 'workflow',
            on: [
              Push(branches: ['branch1'])
            ],
            env: {
              'VARIABLE_1': 'VALUE_1',
              'VARIABLE_2': 'VALUE_2',
            },
            jobs: [
              Job(
                id: 'build',
                runsOn: RunnerType.ubuntuLatest,
                steps: [
                  const CommandStep(id: 'step-1', command: 'echo something')
                ],
              ),
              Job(
                id: 'deploy',
                runsOn: RunnerType.ubuntuLatest,
                steps: [
                  const CommandStep(
                    id: 'step-1',
                    command: 'echo something else',
                  )
                ],
              ),
            ],
          ),
        );

        expect(
          yaml,
          equals(
            '''
name: workflow
on:
  push:
    branches:
      - branch1
env:
  VARIABLE_1: VALUE_1
  VARIABLE_2: VALUE_2
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      -
        id: step-1
        run: echo something
  deploy:
    runs-on: ubuntu-latest
    steps:
      -
        id: step-1
        run: echo something else
''',
          ),
        );
      });
    });
  });
}
