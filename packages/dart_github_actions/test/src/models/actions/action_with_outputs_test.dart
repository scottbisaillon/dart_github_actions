// ignore_for_file: prefer_const_constructors

import 'package:dart_github_actions/dart_github_actions.dart';
import 'package:test/test.dart';

class SimpleActionOutputs extends ActionOutput {
  SimpleActionOutputs(super.stepId);

  String get output1 => this['output1'];
}

class SimpleActionWithOutputs extends ActionWithOutputs<SimpleActionOutputs> {
  const SimpleActionWithOutputs({
    required this.input1,
    this.input2,
    required this.input3,
  }) : super(
          actionOwner: 'owner',
          actionName: 'action-name',
          actionVersion: 'v1',
        );

  final String input1;

  final String? input2;

  final int input3;

  @override
  Map<String, String?> get inputs => {
        'input1': input1,
        'input2': input2,
        'input3': input3.toString(),
      };

  @override
  SimpleActionOutputs buildOutputObject(String stepId) =>
      SimpleActionOutputs(stepId);

  @override
  List<Object?> get props => [actionOwner, actionName, actionVersion, inputs];
}

void main() {
  group('ActionWithOutputs', () {
    test('should support value equality', () {
      final action = SimpleActionWithOutputs(
        input1: 'input1',
        input2: 'input2',
        input3: 1,
      );
      expect(
        action,
        equals(
          SimpleActionWithOutputs(
            input1: 'input1',
            input2: 'input2',
            input3: 1,
          ),
        ),
      );
    });

    test('should have correct fullName', () {
      final action = SimpleActionWithOutputs(
        input1: 'input1',
        input2: 'input2',
        input3: 1,
      );

      expect(action.fullName, equals('owner/action-name@v1'));
    });

    test('should have correct output format', () {
      final action = SimpleActionWithOutputs(
        input1: 'input1',
        input2: 'input2',
        input3: 1,
      );

      final output = action.buildOutputObject('step-id');

      expect(output.output1, equals('steps.step-id.outputs.output1'));
    });
  });
}
