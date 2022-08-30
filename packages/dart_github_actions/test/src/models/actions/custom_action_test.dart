// ignore_for_file: prefer_const_constructors

import 'package:dart_github_actions/src/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('CustomAction', () {
    test('should support value equality', () {
      final customAction = CustomAction(
        actionOwner: 'actionOwner',
        actionName: 'actionName',
        actionVersion: 'v1',
        inputs: const {'input1': 'value1', 'input2': 'value2'},
      );
      expect(
        customAction,
        equals(
          const CustomAction(
            actionOwner: 'actionOwner',
            actionName: 'actionName',
            actionVersion: 'v1',
            inputs: {'input1': 'value1', 'input2': 'value2'},
          ),
        ),
      );
    });

    test('should have correct fullName', () {
      const customAction = CustomAction(
        actionOwner: 'actionOwner',
        actionName: 'actionName',
        actionVersion: 'v1',
        inputs: {'input1': 'value1', 'input2': 'value2'},
      );

      expect(customAction.fullName, equals('actionOwner/actionName@v1'));
    });

    test('should remove null values from inputs', () {
      const customAction = CustomAction(
        actionOwner: 'actionOwner',
        actionName: 'actionName',
        actionVersion: 'v1',
        inputs: {'input1': 'value1', 'input2': null},
      );

      expect(customAction.buildInputs(), equals({'input1': 'value1'}));
    });

    test('should format output correctly', () {
      const customAction = CustomAction(
        actionOwner: 'actionOwner',
        actionName: 'actionName',
        actionVersion: 'v1',
        inputs: {'input1': 'value1', 'input2': 'value2'},
      );

      final output = customAction.buildOutputObject('some-step');

      expect(output['something'], equals('steps.some-step.outputs.something'));
    });
  });
}
