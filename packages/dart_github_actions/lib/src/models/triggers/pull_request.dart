import 'package:dart_github_actions/src/models/triggers/triggers.dart';
import 'package:dart_github_actions/src/utils/utils.dart';

/// {@template pull_request}
/// Triggers a workflow when a pull request is made to the repository.
/// {@endtemplate}
class PullRequest extends Trigger implements YAMLObject {
  /// {@macro push}
  PullRequest({
    this.type,
    this.branches,
    this.branchesIgnore,
    this.paths,
    this.pathsIgnore,
  })  : assert(
          !(branches != null && branchesIgnore != null),
          "Cannot define both 'branches' and 'branchesIgnore'!",
        ),
        assert(
          !(paths != null && pathsIgnore != null),
          "Cannot define both 'paths' and 'pathsIgnore'!",
        ),
        super(label: 'pull_request');

  /// The type associated with the pull request.
  final List<PullRequestType>? type;

  /// List of branches to watch for.
  ///
  /// Cannot be used with [branchesIgnore].
  final List<String>? branches;

  /// List of branches to ignore.
  ///
  /// Cannot be used with [branches].
  final List<String>? branchesIgnore;

  /// List of paths to watch for.
  ///
  /// Cannot be used with [pathsIgnore].
  final List<String>? paths;

  /// List of paths to ignore.
  ///
  /// Cannot be used with [paths].
  final List<String>? pathsIgnore;

  @override
  Map<String, dynamic> toYaml() => {
        'type': type?.map((e) => e.label).toList(),
        'branches': branches,
        'branches_ignore': branchesIgnore,
        'paths': paths,
        'paths_ignore': pathsIgnore,
      }.whereNotNull();
}
