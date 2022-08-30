import 'package:dart_github_actions/src/models/models.dart';
import 'package:dart_github_actions/src/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  group('PullRequest', () {
    test('cannot define branches and branchesIgnore', () {
      expect(
        () => PullRequest(branches: [], branchesIgnore: []),
        throwsA(isA<AssertionError>()),
      );
    });

    test('cannot define paths and pathsIgnore', () {
      expect(
        () => PullRequest(paths: [], pathsIgnore: []),
        throwsA(isA<AssertionError>()),
      );
    });

    group('toYaml', () {
      const writer = YAMLWriter();

      test('should have correct yaml representation', () {
        final yaml = writer.write(
          PullRequest(
            type: [PullRequestType.assigned],
            branches: ['branch1', 'branch2'],
            paths: ['path1', 'path2'],
          ),
        );
        expect(
          yaml,
          equals(
            '''
type:
  - assigned
branches:
  - branch1
  - branch2
paths:
  - path1
  - path2
''',
          ),
        );
      });

      test('should wrap wildcards in single quotes', () {
        final yaml = writer.write(
          PullRequest(
            branches: ['releases/**'],
            paths: ['**.js'],
          ),
        );
        expect(
          yaml,
          equals(
            '''
branches:
  - 'releases/**'
paths:
  - '**.js'
''',
          ),
        );
      });
    });
  });
}
