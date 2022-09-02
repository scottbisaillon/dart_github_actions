import 'package:dart_github_actions/src/models/expression/contexts/env_context.dart';
import 'package:dart_github_actions/src/models/expression/expression.dart';
import 'package:test/test.dart';

extension EnvContextX on EnvContext {
  String get variable => formatProperty('variable');
}

void main() {
  group('Expression', () {
    test('should allow adding with a String', () {
      final expression = Expression((context) => context.github.action);
      expect(
        expression + '/something',
        equals(r'${{ github.action }}/something'),
      );
    });

    group('Github Context', () {
      test('should format github.action correctly', () {
        expect(
          Expression((context) => context.github.action).toString(),
          equals(r'${{ github.action }}'),
        );
      });

      test('should format github.actionPath correctly', () {
        expect(
          Expression((context) => context.github.actionPath).toString(),
          equals(r'${{ github.action_path }}'),
        );
      });

      test('should format github.actionRef correctly', () {
        expect(
          Expression((context) => context.github.actionRef).toString(),
          equals(r'${{ github.action_ref }}'),
        );
      });

      test('should format github.actionRepository correctly', () {
        expect(
          Expression((context) => context.github.actionRepository).toString(),
          equals(r'${{ github.action_repository }}'),
        );
      });

      test('should format github.actionStatus correctly', () {
        expect(
          Expression((context) => context.github.actionStatus).toString(),
          equals(r'${{ github.action_status }}'),
        );
      });

      test('should format github.actor correctly', () {
        expect(
          Expression((context) => context.github.actor).toString(),
          equals(r'${{ github.actor }}'),
        );
      });

      test('should format github.apiUrl correctly', () {
        expect(
          Expression((context) => context.github.apiUrl).toString(),
          equals(r'${{ github.api_url }}'),
        );
      });

      test('should format github.baseRef correctly', () {
        expect(
          Expression((context) => context.github.baseRef).toString(),
          equals(r'${{ github.base_ref }}'),
        );
      });

      test('should format github.env correctly', () {
        expect(
          Expression((context) => context.github.env).toString(),
          equals(r'${{ github.env }}'),
        );
      });

      test('should format github.eventName correctly', () {
        expect(
          Expression((context) => context.github.eventName).toString(),
          equals(r'${{ github.event_name }}'),
        );
      });

      test('should format github.eventPath correctly', () {
        expect(
          Expression((context) => context.github.eventPath).toString(),
          equals(r'${{ github.event_path }}'),
        );
      });

      test('should format github.graphqlUrl correctly', () {
        expect(
          Expression((context) => context.github.graphqlUrl).toString(),
          equals(r'${{ github.graphql_url }}'),
        );
      });

      test('should format github.headRef correctly', () {
        expect(
          Expression((context) => context.github.headRef).toString(),
          equals(r'${{ github.head_ref }}'),
        );
      });

      test('should format github.job correctly', () {
        expect(
          Expression((context) => context.github.job).toString(),
          equals(r'${{ github.job }}'),
        );
      });

      test('should format github.ref correctly', () {
        expect(
          Expression((context) => context.github.ref).toString(),
          equals(r'${{ github.ref }}'),
        );
      });

      test('should format github.refName correctly', () {
        expect(
          Expression((context) => context.github.refName).toString(),
          equals(r'${{ github.ref_name }}'),
        );
      });

      test('should format github.refProtected correctly', () {
        expect(
          Expression((context) => context.github.refProtected).toString(),
          equals(r'${{ github.ref_protected }}'),
        );
      });

      test('should format github.refType correctly', () {
        expect(
          Expression((context) => context.github.refType).toString(),
          equals(r'${{ github.ref_type }}'),
        );
      });

      test('should format github.path correctly', () {
        expect(
          Expression((context) => context.github.path).toString(),
          equals(r'${{ github.path }}'),
        );
      });

      test('should format github.repository correctly', () {
        expect(
          Expression((context) => context.github.repository).toString(),
          equals(r'${{ github.repository }}'),
        );
      });

      test('should format github.repositoryOwner correctly', () {
        expect(
          Expression((context) => context.github.repositoryOwner).toString(),
          equals(r'${{ github.repository_owner }}'),
        );
      });

      test('should format github.repositoryUrl correctly', () {
        expect(
          Expression((context) => context.github.repositoryUrl).toString(),
          equals(r'${{ github.repositoryUrl }}'),
        );
      });

      test('should format github.retentionDays correctly', () {
        expect(
          Expression((context) => context.github.retentionDays).toString(),
          equals(r'${{ github.retention_days }}'),
        );
      });

      test('should format github.runId correctly', () {
        expect(
          Expression((context) => context.github.runId).toString(),
          equals(r'${{ github.run_id }}'),
        );
      });

      test('should format github.runNumber correctly', () {
        expect(
          Expression((context) => context.github.runNumber).toString(),
          equals(r'${{ github.run_number }}'),
        );
      });

      test('should format github.serverUrl correctly', () {
        expect(
          Expression((context) => context.github.serverUrl).toString(),
          equals(r'${{ github.server_url }}'),
        );
      });

      test('should format github.sha correctly', () {
        expect(
          Expression((context) => context.github.sha).toString(),
          equals(r'${{ github.sha }}'),
        );
      });

      test('should format github.token correctly', () {
        expect(
          Expression((context) => context.github.token).toString(),
          equals(r'${{ github.token }}'),
        );
      });

      test('should format github.triggeringActor correctly', () {
        expect(
          Expression((context) => context.github.triggeringActor).toString(),
          equals(r'${{ github.triggering_actor }}'),
        );
      });

      test('should format github.workflow correctly', () {
        expect(
          Expression((context) => context.github.workflow).toString(),
          equals(r'${{ github.workflow }}'),
        );
      });

      test('should format github.workspace correctly', () {
        expect(
          Expression((context) => context.github.workspace).toString(),
          equals(r'${{ github.workspace }}'),
        );
      });
    });

    group('Env Context', () {
      test('should allow defining variables by extension method', () {
        final expression = Expression(
          (context) => context.env.variable,
        );
        expect(expression.toString(), equals(r'${{ env.variable }}'));
      });
    });
  });
}
