import 'package:dart_github_actions/src/models/triggers/triggers.dart';
import 'package:dart_github_actions/src/utils/utils.dart';

/// {@template push}
/// Triggers a workflow when a push is made to the repository.
/// {@endtemplate}
class Push extends Trigger implements YAMLObject {
  /// {@macro push}
  Push({
    this.branches,
    this.branchesIgnore,
    this.tags,
    this.tagsIgnore,
    this.paths,
    this.pathsIgnore,
  })  : assert(
          !(branches != null && branchesIgnore != null),
          "Cannot define both 'branches' and 'branchesIgnore'!",
        ),
        assert(
          !(tags != null && tagsIgnore != null),
          "Cannot define both 'tags' and 'tagsIgnore'!",
        ),
        assert(
          !(paths != null && pathsIgnore != null),
          "Cannot define both 'paths' and 'pathsIgnore'!",
        ),
        super(label: 'push');

  /// List of branches to watch for.
  ///
  /// Cannot be used with [branchesIgnore].
  final List<String>? branches;

  /// List of branches to ignore.
  ///
  /// Cannot be used with [branches].
  final List<String>? branchesIgnore;

  /// List of tags to watch for.
  ///
  /// Cannot be used with [tagsIgnore].
  final List<String>? tags;

  /// List of tags to ignore.
  ///
  /// Cannot be used with [tags].
  final List<String>? tagsIgnore;

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
        'branches': branches,
        'branches-ignore': branchesIgnore,
        'tags': tags,
        'tags-ignore': tagsIgnore,
        'paths': paths,
        'paths-ignore': pathsIgnore,
      }.whereNotNull();
}
