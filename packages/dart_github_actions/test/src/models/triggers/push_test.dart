import 'package:dart_github_actions/src/models/models.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('Push', () {
    test('cannot define branches and branchesIgnore', () {
      expect(
        () => Push(branches: [], branchesIgnore: []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('cannot define tags and tagsIgnore', () {
      expect(
        () => Push(tags: [], tagsIgnore: []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('cannot define paths and pathsIgnore', () {
      expect(
        () => Push(paths: [], pathsIgnore: []),
        throwsA(isA<AssertionError>()),
      );
    });

    group('toYaml', () {
      const writer = YAMLWriter();

      test('should have correct yaml representation', () {
        final yaml = writer.write(
          Push(
            branches: ['branch1', 'branch2'],
            tags: [
              'tag1',
              'tag2',
            ],
            paths: ['path1', 'path2'],
          ),
        );
        expect(
          yaml,
          equals(
            '''
branches:
  - branch1
  - branch2
tags:
  - tag1
  - tag2
paths:
  - path1
  - path2
''',
          ),
        );
      });

      test('should wrap wildcards in single quotes', () {
        final yaml = writer.write(
          Push(
            branches: ['releases/**'],
            tags: ['v*'],
            paths: ['**.js'],
          ),
        );
        expect(
          yaml,
          equals(
            '''
branches:
  - 'releases/**'
tags:
  - 'v*'
paths:
  - '**.js'
''',
          ),
        );
      });
    });
  });
}
