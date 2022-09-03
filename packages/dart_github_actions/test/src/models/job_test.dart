import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Job', () {
    test('adds steps with generated ids', () {
      final job = Job(id: 'job-1', runsOn: RunnerType.ubuntuLatest)
        ..run(id: 'step-id', 'echo something')
        ..run('echo something else')
        ..uses(
          const CustomAction(
            actionOwner: 'actionOwner',
            actionName: 'actionName',
            actionVersion: 'v1',
            inputs: {'input1': 'value1', 'input2': 'value2'},
          ),
        );

      expect(
        job.steps,
        containsAllInOrder(
          const [
            CommandStep(id: 'step-id', command: 'echo something'),
            CommandStep(id: 'step-1', command: 'echo something else'),
            ActionStep(
              id: 'step-2',
              action: CustomAction(
                actionOwner: 'actionOwner',
                actionName: 'actionName',
                actionVersion: 'v1',
                inputs: {'input1': 'value1', 'input2': 'value2'},
              ),
            )
          ],
        ),
      );
    });

    group('toYaml', () {
      test('should have correct yaml representation', () {
        const yamlWriter = YAMLWriter();
        final job = Job(
          id: 'job-1',
          runsOn: RunnerType.ubuntuLatest,
          steps: const [
            CommandStep(id: 'step-1', command: 'echo something'),
            ActionStep(
              id: 'step-2',
              action: CustomAction(
                actionOwner: 'actionOwner',
                actionName: 'actionName',
                actionVersion: 'v1',
                inputs: {'input1': 'value1', 'input2': 'value2'},
              ),
            )
          ],
        );
        final yaml = yamlWriter.write(job);
        expect(
          yaml,
          equals(
            '''
runs-on: ubuntu-latest
steps:
  -
    id: step-1
    run: echo something
  -
    id: step-2
    uses: actionOwner/actionName@v1
    with:
      input1: value1
      input2: value2
''',
          ),
        );
      });

      test('should have correct yaml representation with defaults', () {
        const yamlWriter = YAMLWriter();
        final job = Job(
          id: 'job-1',
          defaults:
              const Defaults(run: Run(workingDirectory: 'some/directory')),
          runsOn: RunnerType.ubuntuLatest,
          steps: [const CommandStep(id: 'step-1', command: 'echo something')],
        );
        final yaml = yamlWriter.write(job);
        expect(
          yaml,
          equals(
            '''
defaults:
  run:
    working-directory: some/directory
runs-on: ubuntu-latest
steps:
  -
    id: step-1
    run: echo something
''',
          ),
        );
      });

      test('should omit CustomAction inputs when empty', () {
        const yamlWriter = YAMLWriter();
        final job = Job(
          id: 'job-1',
          runsOn: RunnerType.ubuntuLatest,
          steps: const [
            CommandStep(id: 'step-1', command: 'echo something'),
            ActionStep(
              id: 'step-2',
              action: CustomAction(
                actionOwner: 'actionOwner',
                actionName: 'actionName',
                actionVersion: 'v1',
              ),
            )
          ],
        );
        final yaml = yamlWriter.write(job);
        expect(
          yaml,
          equals(
            '''
runs-on: ubuntu-latest
steps:
  -
    id: step-1
    run: echo something
  -
    id: step-2
    uses: actionOwner/actionName@v1
''',
          ),
        );
      });
    });
  });
}
