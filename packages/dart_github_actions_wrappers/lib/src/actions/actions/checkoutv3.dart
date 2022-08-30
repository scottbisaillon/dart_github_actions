// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_github_actions/dart_github_actions.dart';

/// {@template submodules}
/// The input parameters for [CheckoutV3].submodules
/// {@endtemplate}
enum Submodules {
  /// Checkout submodules.
  checkout('true'),

  /// Ignore submodules (default).
  ignore('false'),

  /// Checkout submodules recursively.
  recursive('recursive');

  /// {@macro submodules}
  const Submodules(this.inputLabel);

  /// The action input value.
  final String inputLabel;
}

/// {@template checkout_v3}
/// [Action] wrapper for https://github.com/actions/checkout.
/// {@endtemplate}
class CheckoutV3 extends Action {
  /// {@macro checkout_v3}
  const CheckoutV3({
    this.repository,
    this.ref,
    this.token,
    this.sshKey,
    this.sshKnownHosts,
    this.sshStrict,
    this.persistCredentials,
    this.path,
    this.clean,
    this.fetchDepth,
    this.lfs,
    this.submodules,
    this.setSafeDirectory,
  }) : super(
          actionOwner: 'actions',
          actionName: 'checkout',
          actionVersion: 'v3',
        );

  /// Repository name with owner. For example, actions/checkout.
  final String? repository;

  /// The branch, tag or SHA to checkout. When checking out the repository that
  /// triggered a workflow, this defaults to the reference or SHA for that
  /// event.  Otherwise, uses the default branch.
  final String? ref;

  /// Personal access token (PAT) used to fetch the repository. The PAT is configured
  /// with the local git config, which enables your scripts to run authenticated git
  /// commands. The post-job step removes the PAT.
  /// We recommend using a service account with the least permissions necessary.
  /// Also when generating a new PAT, select the least scopes necessary.
  /// [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
  final String? token;

  /// SSH key used to fetch the repository. The SSH key is configured with the local
  /// git config, which enables your scripts to run authenticated git commands.
  /// The post-job step removes the SSH key.
  /// We recommend using a service account with the least permissions necessary.
  /// [Learn more about creating and using encrypted secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets)
  final String? sshKey;

  /// Known hosts in addition to the user and global host key database. The public
  /// SSH keys for a host may be obtained using the utility `ssh-keyscan`. For example,
  /// `ssh-keyscan github.com`. The public key for github.com is always implicitly added.
  final String? sshKnownHosts;

  /// Whether to perform strict host key checking. When true, adds the options `StrictHostKeyChecking=yes`
  /// and `CheckHostIP=no` to the SSH command line. Use the input `ssh-known-hosts` to
  /// configure additional hosts.
  final bool? sshStrict;

  /// Whether to configure the token or SSH key with the local git config.
  final bool? persistCredentials;

  /// Relative path under $GITHUB_WORKSPACE to place the repository.
  final String? path;

  /// Whether to execute `git clean -ffdx && git reset --hard HEAD` before fetching
  final bool? clean;

  /// Number of commits to fetch. 0 indicates all history for all branches and tags.
  final int? fetchDepth;

  /// Whether to download Git-LFS files.
  final bool? lfs;

  /// Whether to checkout submodules: `true` to checkout submodules or `recursive` to
  /// recursively checkout submodules.
  /// When the `ssh-key` input is not provided, SSH URLs beginning with `git@github.com:` are
  /// converted to HTTPS.
  final Submodules? submodules;

  /// Add repository path as safe.directory for Git global config by running `git config --global --add safe.directory <path>`.
  final bool? setSafeDirectory;

  @override
  Map<String, String?> get inputs => {
        'repository': repository,
        'ref': ref,
        'token': token,
        'ssh-key': sshKey,
        'ssh-known-hosts': sshKnownHosts,
        'ssh-strict': sshStrict?.toString(),
        'persist-credentials': persistCredentials?.toString(),
        'path': path,
        'clean': clean?.toString(),
        'fetch-depth': fetchDepth?.toString(),
        'lfs': lfs?.toString(),
        'submodules': submodules?.inputLabel,
        'set-safe-directory': setSafeDirectory?.toString(),
      }.whereNotNull();

  @override
  List<Object?> get props => [
        repository,
        ref,
        token,
        sshKey,
        sshKnownHosts,
        sshStrict,
        persistCredentials,
        path,
        clean,
        fetchDepth,
        lfs,
        submodules,
        setSafeDirectory,
      ];
}
