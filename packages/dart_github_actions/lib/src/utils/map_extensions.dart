/// [Map] extensions.
extension MapX<T> on Map<String, T?> {
  /// Returns a new map with no null values.
  Map<String, T> whereNotNull() {
    return Map<String, T>.from(
      Map.from(this)..removeWhere((key, value) => value == null),
    );
  }
}
