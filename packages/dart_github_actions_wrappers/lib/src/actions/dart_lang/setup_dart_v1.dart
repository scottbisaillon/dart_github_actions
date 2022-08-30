// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_github_actions/dart_github_actions.dart';

enum Architecture {
  x64('x64'),
  ia32('ia32'),
  arm('arm'),
  arm64('arm64');

  const Architecture(this.inputLabel);

  final String inputLabel;
}

enum Flavor {
  raw('raw'),
  release('release');

  const Flavor(this.inputLabel);

  final String inputLabel;
}

/// {@template setup_dart_v1}
/// [Action] wrapper for https://github.com/dart-lang/setup-dart.
/// {@endtemplate}
class SetupDartV1 extends Action {
  /// {@macro setup_dart_v1}
  const SetupDartV1({
    this.sdk,
    this.architecture,
    this.flavor,
  }) : super(
          actionOwner: 'dart-lang',
          actionName: 'setup-dart',
          actionVersion: 'v1',
        );

  /// The channel, or a specific version from a channel to install ('stable', 'beta', 'dev', '2.7.2', '2.12.0-1.4.beta').
  /// Using one of the three channels instead of a version will give you the latest version published to that channel.
  final String? sdk;

  /// The CPU architecture ('x64', 'ia32', 'arm', or 'arm64').
  final Architecture? architecture;

  /// The build flavor ('raw' or 'release').
  final Flavor? flavor;

  @override
  Map<String, String?> get inputs => {
        'sdk': sdk,
        'architectre': architecture?.inputLabel,
        'flavor': flavor?.inputLabel,
      }.whereNotNull();

  @override
  List<Object?> get props => [sdk, architecture, flavor];
}
