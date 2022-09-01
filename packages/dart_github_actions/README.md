# Dart Github Actions

[![dart_github_actions][dart_github_actions_build_workflow_badge]][dart_github_actions_build_workflow_link]
[![codecov][codecov_badge]][codecov_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A project for writing [Github Workflows](https://docs.github.com/en/actions/using-workflows) using a type-safe api rather than yaml.


This project is heavily inspired by [github-actions-kotlin-dsl](https://github.com/krzema12/github-actions-kotlin-dsl),
but aims to fill in some of the gaps with kotlin scripting. This project is by no means a replacement, rather, it is an alternative.

---

## Version 0.X
Dart Github Actions is still in development with basic functionality implemented to start writing and generating workflows. While in the `0.x` version range, the API is subject to change while more of the Github Workflow syntax is implemented. 

Be sure to submit an [issue](https://github.com/scottbisaillon/dart_github_actions/issues) or start a [discussion](https://github.com/scottbisaillon/dart_github_actions/discussions) for any bugs or feature requests.

## Feature List
## General syntax
- [ ] Workflow
  - [ ] Worfklow Concurrency
  - [ ] Workflow Permissions
  - [ ] Workflow Environment Variables
- [ ] Jobs
  - [X] Job Outputs
  - [X] Job Defaults
  - [ ] Job Concurrency
  - [ ] Job Strategy
  - [ ] Action Step
  - [ ] Command Step
  - [ ] Job Conditionals
  - [ ] Job Environment Variables 
  - [ ] Job Container
  - [ ] Job Services
## Triggers
- [ ] branch_protection_rule
- [ ] check_run
- [ ] check_suite
- [ ] create
- [ ] delete
- [ ] deployment
- [ ] deployment_status
- [ ] discussion
- [ ] discussion_comment
- [ ] fork
- [ ] gollum
- [ ] issue_comment
- [ ] issues
- [ ] label
- [ ] merge_group
- [ ] milestone
- [ ] page_build
- [ ] project
- [ ] project_card
- [ ] project_column
- [ ] public
- [X] pull_request
- [ ] pull_request_comment (use issue_comment)
- [ ] pull_request_review
- [ ] pull_request_review_comment
- [ ] pull_request_target
- [X] push
- [ ] registry_package
- [ ] release
- [ ] repository_dispatch
- [ ] schedule
- [ ] status
- [ ] watch
- [ ] workflow_call
- [ ] workflow_dispatch
- [ ] workflow_run

---
## Setup

1. Create a `pubspec.yaml` file in your `.github` folder of your project with `dart_github_actions` as a dependency.


```yaml
# .github/pubspec.yaml
name: workflows
description: Project for dart_github_actions defined workflows.
version: 1.0.0+1
publish_to: none

environment:
  sdk: ">=2.17.0 <3.0.0"

dependencies:
  dart_github_actions: latest
```

2. Run `dart pub get`.

## Writing Workflows

1. Create a `dart` file for your workflow. Your file should contain an async `main()` method.

```dart
// .github/workflows/workflow.dart
import 'package:dart_github_actions/dart_github_actions.dart';

void main() async {
  await Workflow(
    name: 'workflow',
    on: [
      Push(
        branches: ['master'],
      )
    ],
    jobs: [
      Job(
        id: 'job-1',
        runsOn: RunnerType.ubuntuLatest,
      )
        ..run('echo step 1', name: 'Step 1')
        ..run('echo step 2', name: 'Step 1'),
    ],
  ).writeYamlToFile();
}
```

2. Run your file with `dart workflow.dart` and the following should be produced:

```yaml
# This workflow has been generated using dart_github_actions (https://github.com/scottbisaillon/dart_github_actions).
# All modifications should be made to 'workflow.dart' and the workflow regenerated.

name: workflow
on:
  push:
    branches:
      - master
jobs:
  job-1:
    runs-on: ubuntu-latest
    steps:
      -
        id: step-0
        name: Step 1
        run: echo step 1
      -
        id: step-1
        name: Step 1
        run: echo step 2

```

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[codecov_badge]: https://codecov.io/gh/scottbisaillon/dart_github_actions/branch/development/graph/badge.svg?token=5CAD50BVEE
[codecov_link]: https://codecov.io/gh/scottbisaillon/dart_github_actions
[dart_github_actions_build_workflow_badge]: https://github.com/scottbisaillon/dart_github_actions/actions/workflows/build_dart_github_actions.yaml/badge.svg?branch=development
[dart_github_actions_build_workflow_link]: https://github.com/scottbisaillon/dart_github_actions/actions/workflows/build_dart_github_actions.yaml