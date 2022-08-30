import 'package:dart_github_actions/src/dart_github_actions.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

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
}
