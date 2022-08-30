// ignore_for_file: prefer_const_constructors

import 'package:dart_github_actions/dart_github_actions.dart';
import 'package:test/test.dart';

class SimpleAction extends Action {
  const SimpleAction({
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
  List<Object?> get props => [actionOwner, actionName, actionVersion, inputs];
}

void main() {
  group('Action', () {
    test('should support value equality', () {
      final action = SimpleAction(
        input1: 'input1',
        input2: 'input2',
        input3: 1,
      );
      expect(
        action,
        equals(
          SimpleAction(
            input1: 'input1',
            input2: 'input2',
            input3: 1,
          ),
        ),
      );
    });

    test('should have correct fullName', () {
      final action = SimpleAction(
        input1: 'input1',
        input2: 'input2',
        input3: 1,
      );

      expect(action.fullName, equals('owner/action-name@v1'));
    });
  });
}
