import 'package:dart_github_actions/dart_github_actions.dart';
import 'package:test/test.dart';

void main() {
  group('RunnerType', () {
    test('should have correct labels', () {
      expect(RunnerType.ubuntuLatest.label, equals('ubuntu-latest'));
      expect(RunnerType.windowsLatest.label, equals('windows-latest'));
      expect(RunnerType.macosLatest.label, equals('macos-latest'));
      expect(RunnerType.windowsServer2022.label, equals('windows-2022'));
      expect(RunnerType.windowsServr2019.label, equals('windows-2019'));
      expect(RunnerType.ubuntu2004.label, equals('ubuntu-20.04'));
      expect(RunnerType.ubuntu2204.label, equals('ubuntu-22.04'));
      expect(RunnerType.macosMonterey12.label, equals('macos-12'));
      expect(RunnerType.macosBigSur12.label, equals('macos-11'));
    });
  });
}
