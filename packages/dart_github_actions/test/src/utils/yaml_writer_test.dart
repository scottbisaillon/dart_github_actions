import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('YAMLWriter', () {
    const writer = YAMLWriter();

    test('should write multi-line string', () {
      expect(
        writer.write({'multi-line-string': 'first\nsecond\n'}),
        equals(
          '''
multi-line-string: |
    first
    second
''',
        ),
      );
    });

    test('should write multi-line string with no ending newline', () {
      expect(
        writer.write({'multi-line-string': 'first\nsecond'}),
        equals(
          '''
multi-line-string: |-
    first
    second
''',
        ),
      );
    });

    test('should write {} for empty map', () {
      final output = writer.write({'map': <String, String>{}});
      expect(
        output,
        equals(
          '''
map: {}''',
        ),
      );
    });

    test('should write simple map', () {
      final output = writer.write({
        'key-1': 'value 1',
        'key 2': 'value 2',
      });
      expect(
        output,
        equals(
          '''
key-1: value 1
'key 2': value 2
''',
        ),
      );
    });

    test('should write nested maps', () {
      final output = writer.write({
        'key-1': 'value 1',
        'key 2': {'key 3': 'value 3'},
      });
      expect(
        output,
        equals(
          '''
key-1: value 1
'key 2':
  'key 3': value 3
''',
        ),
      );
    });

    test('should write deeply nested maps', () {
      final output = writer.write({
        'key-1': 'value 1',
        'key 2': {
          'key 3': {'key 4': 'value 2'}
        },
      });
      expect(
        output,
        equals(
          '''
key-1: value 1
'key 2':
  'key 3':
    'key 4': value 2
''',
        ),
      );
    });

    test('should write list', () {
      final output = writer.write({
        'list': [1, 2, 3]
      });
      expect(
        output,
        equals(
          '''
list:
  - 1
  - 2
  - 3
''',
        ),
      );
    });

    test('should write list containing maps', () {
      final output = writer.write({
        'list': [
          {'key1': 'value1', 'key2': 'value2'}
        ]
      });
      expect(
        output,
        equals(
          '''
list:
  -
    key1: value1
    key2: value2
''',
        ),
      );
    });
  });
}
