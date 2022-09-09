import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

class SimpleJobOutput extends JobOutput {
  SimpleJobOutput(super.jobId);

  String get output1 => formatOutput('output1');
}

class SimpleStepOutput extends StepOutput {
  SimpleStepOutput(super.stepId);

  String get output1 => formatOutput('output1');
}

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

      test('should write needs list using job ids', () {
        final job1 = Job(id: 'job-1', runsOn: RunnerType.ubuntuLatest);
        final job2 = Job(id: 'job-2', runsOn: RunnerType.ubuntuLatest);
        final job3 = Job(
          id: 'job-3',
          runsOn: RunnerType.ubuntuLatest,
          needs: [job1, job2],
        )..run('echo something');
        const yamlWriter = YAMLWriter();

        final yaml = yamlWriter.write(job3);
        expect(
          yaml,
          equals(
            '''
needs: [job-1, job-2]
runs-on: ubuntu-latest
steps:
  -
    id: step-0
    run: echo something
''',
          ),
        );
      });

      test('should write job output', () {
        const commandStep = CommandStepWithOutput<SimpleStepOutput>(
          id: 'step1',
          command: 'echo something',
          buildOutput: SimpleStepOutput.new,
        );

        final job = JobWithOutput(
          id: 'job1',
          runsOn: RunnerType.ubuntuLatest,
          outputs: {
            'output1': Expression(
              (context) => context.steps.step(commandStep).output1,
            ).toString()
          },
          buildOutput: SimpleJobOutput.new,
        )..run('echo something');
        final yaml = const YAMLWriter().write(job);
        expect(
          yaml,
          equals(
            r'''
outputs:
  output1: ${{ steps.step1.outputs.output1 }}
runs-on: ubuntu-latest
steps:
  -
    id: step-0
    run: echo something
''',
          ),
        );
      });
    });
  });

  group('JobWithOutput', () {
    test('should write needs list using job ids', () {
      final job1 = JobWithOutput<SimpleJobOutput>(
        id: 'job-1',
        runsOn: RunnerType.ubuntuLatest,
        outputs: {'output1': 'anything'},
        buildOutput: SimpleJobOutput.new,
      );
      final job2 = JobWithOutput<SimpleJobOutput>(
        id: 'job-2',
        runsOn: RunnerType.ubuntuLatest,
        outputs: {'output1': 'anything'},
        buildOutput: SimpleJobOutput.new,
      );
      final job3 = JobWithOutput<SimpleJobOutput>(
        id: 'job-3',
        runsOn: RunnerType.ubuntuLatest,
        needs: [job1, job2],
        outputs: {'output1': 'anything'},
        buildOutput: SimpleJobOutput.new,
      )..run('echo something');
      const yamlWriter = YAMLWriter();

      final yaml = yamlWriter.write(job3);
      expect(
        yaml,
        equals(
          '''
outputs:
  output1: anything
needs: [job-1, job-2]
runs-on: ubuntu-latest
steps:
  -
    id: step-0
    run: echo something
''',
        ),
      );
    });
  });
}
