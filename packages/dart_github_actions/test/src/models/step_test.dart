// ignore_for_file: prefer_const_constructors

import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

class SimpleStepOutput extends StepOutput {
  SimpleStepOutput(super.stepId);

  String get output1 => formatOutput('output1');
}

void main() {
  group('CommandStep', () {
    group('toYaml', () {
      test('should have correct yaml representation', () {
        const yamlWriter = YAMLWriter();
        const step = CommandStep(
          id: 'step-1',
          name: 'Step 1',
          command: 'echo something',
          env: {
            'var1': 'value1',
            'var2': 'value2',
            'var3': 'value3',
          },
        );
        final yaml = yamlWriter.write(step);
        expect(
          yaml,
          equals(
            '''
id: step-1
name: Step 1
run: echo something
env:
  var1: value1
  var2: value2
  var3: value3
''',
          ),
        );
      });
    });
  });

  group('CommandStepWithOutput', () {
    test('should support value equality', () {
      final step = CommandStepWithOutput(
        id: 'step-1',
        name: 'Step 1',
        env: const {
          'var1': 'value1',
          'var2': 'value2',
          'var3': 'value3',
        },
        command: 'echo something',
        buildOutput: SimpleStepOutput.new,
      );
      expect(
        step,
        equals(
          CommandStepWithOutput(
            id: 'step-1',
            name: 'Step 1',
            env: const {
              'var1': 'value1',
              'var2': 'value2',
              'var3': 'value3',
            },
            command: 'echo something',
            buildOutput: SimpleStepOutput.new,
          ),
        ),
      );
    });

    test('should format outputs correctly', () {
      const step = CommandStepWithOutput(
        id: 'step-1',
        name: 'Step 1',
        env: {
          'var1': 'value1',
          'var2': 'value2',
          'var3': 'value3',
        },
        command: 'echo something',
        buildOutput: SimpleStepOutput.new,
      );
      expect(
        step.output.output1,
        equals('steps.step-1.outputs.output1'),
      );
    });

    group('toYaml', () {
      test('should have correct yaml representation', () {
        const yamlWriter = YAMLWriter();
        const step = CommandStepWithOutput(
          id: 'step-1',
          name: 'Step 1',
          command: 'echo something',
          env: {
            'var1': 'value1',
            'var2': 'value2',
            'var3': 'value3',
          },
          buildOutput: SimpleStepOutput.new,
        );
        final yaml = yamlWriter.write(step);
        expect(
          yaml,
          equals(
            '''
id: step-1
name: Step 1
run: echo something
env:
  var1: value1
  var2: value2
  var3: value3
''',
          ),
        );
      });
    });
  });

  group('ActionStep', () {
    group('toYaml', () {
      test('should have correct yaml representation', () {
        const yamlWriter = YAMLWriter();
        const step = ActionStep(
          id: 'step-1',
          name: 'Step 1',
          env: {
            'var1': 'value1',
            'var2': 'value2',
            'var3': 'value3',
          },
          action: CustomAction(
            actionOwner: 'actionOwner',
            actionName: 'actionName',
            actionVersion: 'v1',
            inputs: {'input1': 'value1', 'input2': 'value2'},
          ),
        );
        final yaml = yamlWriter.write(step);
        expect(
          yaml,
          equals(
            '''
id: step-1
name: Step 1
uses: actionOwner/actionName@v1
with:
  input1: value1
  input2: value2
env:
  var1: value1
  var2: value2
  var3: value3
''',
          ),
        );
      });
    });
  });

  group('ActionStepWithOutput', () {
    test('should support value equality', () {
      final step = ActionStepWithOutput(
        id: 'step-1',
        name: 'Step 1',
        env: const {
          'var1': 'value1',
          'var2': 'value2',
          'var3': 'value3',
        },
        action: CustomAction(
          actionOwner: 'actionOwner',
          actionName: 'actionName',
          actionVersion: 'v1',
          inputs: const {'input1': 'value1', 'input2': 'value2'},
        ),
        buildOutput: SimpleStepOutput.new,
      );
      expect(
        step,
        equals(
          ActionStepWithOutput(
            id: 'step-1',
            name: 'Step 1',
            env: const {
              'var1': 'value1',
              'var2': 'value2',
              'var3': 'value3',
            },
            action: CustomAction(
              actionOwner: 'actionOwner',
              actionName: 'actionName',
              actionVersion: 'v1',
              inputs: const {'input1': 'value1', 'input2': 'value2'},
            ),
            buildOutput: SimpleStepOutput.new,
          ),
        ),
      );
    });

    test('should format outputs correctly', () {
      const step = ActionStepWithOutput(
        id: 'step-1',
        name: 'Step 1',
        env: {
          'var1': 'value1',
          'var2': 'value2',
          'var3': 'value3',
        },
        action: CustomAction(
          actionOwner: 'actionOwner',
          actionName: 'actionName',
          actionVersion: 'v1',
          inputs: {'input1': 'value1', 'input2': 'value2'},
        ),
        buildOutput: SimpleStepOutput.new,
      );
      expect(
        step.output.output1,
        equals('steps.step-1.outputs.output1'),
      );
    });

    group('toYaml', () {
      test('should have correct yaml representation', () {
        const yamlWriter = YAMLWriter();
        const step = ActionStepWithOutput(
          id: 'step-1',
          name: 'Step 1',
          env: {
            'var1': 'value1',
            'var2': 'value2',
            'var3': 'value3',
          },
          action: CustomAction(
            actionOwner: 'actionOwner',
            actionName: 'actionName',
            actionVersion: 'v1',
            inputs: {'input1': 'value1', 'input2': 'value2'},
          ),
          buildOutput: SimpleStepOutput.new,
        );
        final yaml = yamlWriter.write(step);
        expect(
          yaml,
          equals(
            '''
id: step-1
name: Step 1
uses: actionOwner/actionName@v1
with:
  input1: value1
  input2: value2
env:
  var1: value1
  var2: value2
  var3: value3
''',
          ),
        );
      });
    });
  });
}
