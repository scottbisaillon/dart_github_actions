// ignore_for_file: public_member_api_docs

/// Available GitHub-hosted runner types.
///
/// see: https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#choosing-github-hosted-runners
enum RunnerType {
  // Latests
  ubuntuLatest('ubuntu-latest'),
  windowsLatest('windows-latest'),
  macosLatest('macos-latest'),

  // Windows
  windowsServer2022('windows-2022'),
  windowsServr2019('windows-2019'),

  // Ubuntu
  ubuntu2004('ubuntu-20.04'),
  ubuntu2204('ubuntu-22.04'),

  // MacOS
  macosMonterey12('macos-12'),
  macosBigSur12('macos-11');

  const RunnerType(this.label);

  final String label;
}
