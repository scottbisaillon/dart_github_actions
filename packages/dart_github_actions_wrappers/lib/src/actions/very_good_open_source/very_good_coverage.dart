import 'package:dart_github_actions/dart_github_actions.dart';

/// {@template very_good_coverage_v1}
/// [Action] wrapper for https://github.com/VeryGoodOpenSource/very_good_coverage.
/// {@endtemplate}
class VeryGoodCoverageV1 extends Action {
  /// {@macro very_good_coverage_v1}
  const VeryGoodCoverageV1({
    this.path,
    this.minCoverage,
    this.exclude,
  }) : super(
          actionOwner: 'VeryGoodOpenSource',
          actionName: 'very_good_coverage',
          actionVersion: 'v1',
        );

  /// lcov path.
  final String? path;

  /// minimum coverage percentage allowed.
  final int? minCoverage;

  /// list of files you would like to exclude from coverage.
  final String? exclude;

  @override
  Map<String, String?> get inputs => {
        'path': path,
        'min-coverage': minCoverage?.toString(),
        'exclude': exclude,
      }.whereNotNull();

  @override
  List<Object?> get props => [path, minCoverage, exclude];
}
