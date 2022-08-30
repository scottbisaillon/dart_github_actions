/// {@template trigger}
/// An event that causes a workflow to run.
/// {@endtemplate}
abstract class Trigger {
  /// {@macro trigger}
  const Trigger({required this.label});

  /// The yaml label for this [Trigger].
  final String label;
}
