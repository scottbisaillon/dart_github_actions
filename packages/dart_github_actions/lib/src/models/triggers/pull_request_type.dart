// ignore_for_file: public_member_api_docs

/// Type associated with the pull request webhook event.
///
/// see: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#pull_request
enum PullRequestType {
  assigned('assigned'),
  unassigned('unassigned'),
  labeled('labeled'),
  unlabeled('unlabeled'),
  opened('opened'),
  edited('edited'),
  closed('closed'),
  reopened('reopened'),
  synchronize('synchronize'),
  convertedToDraft('converted_to_draft'),
  readyForReview('ready_for_review'),
  locked('locked'),
  unlocked('unlocked'),
  reviewRequested('review_requested'),
  reviewRequestRemoved('review_requested_removed'),
  autoMergeEnabled('auto_merge_enabled'),
  autoMergeDisabled('auto_merge_disabled');

  const PullRequestType(this.label);

  final String label;
}
