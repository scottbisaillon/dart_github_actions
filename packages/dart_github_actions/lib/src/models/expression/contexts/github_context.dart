// ignore_for_file: lines_longer_than_80_chars
import 'package:dart_github_actions/src/models/expression/contexts/context.dart';

/// {@template github_context}
/// Context object containing all properties for the [Github Context](https://docs.github.com/en/actions/learn-github-actions/contexts#github-context).
/// {@endtemplate}
class GithubContext extends Context {
  /// {@macro github_context}
  const GithubContext() : super('github');

  /// The name of the action currently running, or the id of a step.
  /// GitHub removes special characters, and uses the name __run when the current step runs a script without an id.
  /// If you use the same action more than once in the same job, the name will include a suffix with the sequence number with underscore before it.
  /// For example, the first script you run will have the name __run, and the second script will be named __run_2.
  /// Similarly, the second invocation of actions/checkout will be actionscheckout2.
  String get action => formatProperty('action');

  /// The path where an action is located.
  /// This property is only supported in composite actions.
  /// You can use this path to access files located in the same repository as the action.
  String get actionPath => formatProperty('action_path');

  /// For a step executing an action, this is the ref of the action being executed.
  /// For example, v2.
  String get actionRef => formatProperty('action_ref');

  /// For a step executing an action, this is the owner and repository name of the action.
  /// For example, actions/checkout.
  String get actionRepository => formatProperty('action_repository');

  /// For a composite action, the current result of the composite action.
  String get actionStatus => formatProperty('action_status');

  /// The username of the user that triggered the initial workflow run.
  /// If the workflow run is a re-run, this value may differ from github.triggering_actor.
  /// Any workflow re-runs will use the privileges of github.actor, even if the actor initiating the re-run (github.triggering_actor) has different privileges.
  String get actor => formatProperty('actor');

  /// The URL of the GitHub REST API.
  String get apiUrl => formatProperty('api_url');

  /// The base_ref or target branch of the pull request in a workflow run.
  /// This property is only available when the event that triggers a workflow run is either pull_request or pull_request_target.
  String get baseRef => formatProperty('base_ref');

  /// Path on the runner to the file that sets environment variables from workflow commands.
  /// This file is unique to the current step and is a different file for each step in a job.
  /// For more information, see "Workflow commands for GitHub Actions."
  String get env => formatProperty('env');

  /// The full event webhook payload.
  /// You can access individual properties of the event using this context.
  /// This object is identical to the webhook payload of the event that triggered the workflow run, and is different for each event.
  /// The webhooks for each GitHub Actions event is linked in "Events that trigger workflows."
  /// For example, for a workflow run triggered by the push event, this object contains the contents of the push webhook payload.
  // String get event => formatProperty('event');

  /// The name of the event that triggered the workflow run.
  String get eventName => formatProperty('event_name');

  /// The path to the file on the runner that contains the full event webhook payload.
  String get eventPath => formatProperty('event_path');

  /// The URL of the GitHub GraphQL API.
  String get graphqlUrl => formatProperty('graphql_url');

  /// The head_ref or source branch of the pull request in a workflow run.
  /// This property is only available when the event that triggers a workflow run is either pull_request or pull_request_target.
  String get headRef => formatProperty('head_ref');

  /// The job_id of the current job.
  /// Note: This context property is set by the Actions runner, and is only available within the execution steps of a job.
  /// Otherwise, the value of this property will be null.
  String get job => formatProperty('job');

  /// The branch or tag ref that triggered the workflow run.
  /// For workflows triggered by push, this is the branch or tag ref that was pushed.
  /// For workflows triggered by pull_request, this is the pull request merge branch.
  /// For workflows triggered by release, this is the release tag created.
  /// For other triggers, this is the branch or tag ref that triggered the workflow run.
  /// This is only set if a branch or tag is available for the event type.
  /// The ref given is fully-formed, meaning that for branches the format is refs/heads/<branch_name>, for pull requests it is refs/pull/<pr_number>/merge, and for tags it is refs/tags/<tag_name>. For example, refs/heads/feature-branch-1.
  String get ref => formatProperty('ref');

  /// The branch or tag name that triggered the workflow run.
  String get refName => formatProperty('ref_name');

  /// true if branch protections are configured for the ref that triggered the workflow run.
  String get refProtected => formatProperty('ref_protected');

  /// The type of ref that triggered the workflow run.
  /// Valid values are branch or tag.
  String get refType => formatProperty('ref_type');

  /// Path on the runner to the file that sets system PATH variables from workflow commands.
  /// This file is unique to the current step and is a different file for each step in a job.
  /// For more information, see "Workflow commands for GitHub Actions."
  String get path => formatProperty('path');

  /// The owner and repository name.
  /// For example, Codertocat/Hello-World.
  String get repository => formatProperty('repository');

  /// The repository owner's name.
  /// For example, Codertocat.
  String get repositoryOwner => formatProperty('repository_owner');

  /// The Git URL to the repository.
  /// For example, git://github.com/codertocat/hello-world.git.
  String get repositoryUrl => formatProperty('repositoryUrl');

  /// The number of days that workflow run logs and artifacts are kept.
  String get retentionDays => formatProperty('retention_days');

  /// A unique number for each workflow run within a repository.
  /// This number does not change if you re-run the workflow run.
  String get runId => formatProperty('run_id');

  /// A unique number for each attempt of a particular workflow run in a repository.
  /// This number begins at 1 for the workflow run's first attempt, and increments with each re-run.
  String get runNumber => formatProperty('run_number');

  /// The URL of the GitHub server.
  /// For example: https://github.com.
  String get serverUrl => formatProperty('server_url');

  /// The commit SHA that triggered the workflow.
  /// The value of this commit SHA depends on the event that triggered the workflow.
  /// For more information, see "Events that trigger workflows."
  /// For example, ffac537e6cbbf934b08745a378932722df287a53.
  String get sha => formatProperty('sha');

  /// A token to authenticate on behalf of the GitHub App installed on your repository.
  /// This is functionally equivalent to the GITHUB_TOKEN secret.
  /// For more information, see "Automatic token authentication."
  ///
  /// Note: This context property is set by the Actions runner, and is only available within the execution steps of a job.
  /// Otherwise, the value of this property will be null.
  String get token => formatProperty('token');

  /// The username of the user that initiated the workflow run.
  /// If the workflow run is a re-run, this value may differ from github.actor.
  /// Any workflow re-runs will use the privileges of github.actor, even if the actor initiating the re-run (github.triggering_actor) has different privileges.
  String get triggeringActor => formatProperty('triggering_actor');

  /// The name of the workflow.
  /// If the workflow file doesn't specify a name, the value of this property is the full path of the workflow file in the repository.
  String get workflow => formatProperty('workflow');

  /// The default working directory on the runner for steps, and the default location of your repository when using the checkout action.
  String get workspace => formatProperty('workspace');
}
