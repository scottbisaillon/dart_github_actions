import 'package:dart_github_actions/dart_github_actions.dart';

/// {@template codecov_action_v3}
/// [Action] wrapper for https://github.com/codecov/codecov-action
/// {@endtemplate}
class CodecovActionV3 extends Action {
  /// {@macro codecov_action_v3}
  const CodecovActionV3({
    this.token,
    this.files,
  }) : super(
          actionOwner: 'codecov',
          actionName: 'codecov-action',
          actionVersion: 'v3',
        );

  /// Used to authorize coverage report uploads.
  ///
  /// Required for private repos.
  final String? token;

  /// Comma-separated paths to the coverage report(s).
  final String? files;

  @override
  Map<String, String?> get inputs => {
        'token': token,
        'files': files,
      };

  @override
  List<Object?> get props => [token, files];
}
