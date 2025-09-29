/// Dart implementation of Swift's `Optional` type.
///
/// {@template optional}
/// Creates an object that holds a nullable value which can be unwrapped
/// safely.
/// {@endtemplate}
///
/// Swift specs: https://developer.apple.com/documentation/swift/optional
final class Optional<Wrapped extends Object> {
  /// {@macro optional}
  const Optional(this.value);

  /// Creates an [Optional] object that holds a non-null value.
  const Optional.some(Wrapped this.value);

  /// Creates an [Optional] object that holds a null value.
  const Optional.none() : value = null;

  final Wrapped? value;

  /// {@template optional_map}
  /// Evaluates the given closure when this [Optional] instance is not null,
  /// passing the unwrapped [value] as a parameter.
  /// {@endtemplate}
  U? map<U>(U Function(Wrapped value) cb) {
    return switch (value) {
      final value? => cb(value),
      null => null,
    };
  }

  /// {@macro optional_map}
  Optional<U> flatMap<U extends Object>(
    Optional<U> Function(Wrapped value) cb,
  ) {
    return switch (value) {
      final value? => cb(value),
      null => const Optional.none(),
    };
  }

  @override
  bool operator ==(Object other) =>
      other is Optional<Wrapped> && other.value == value;

  @override
  int get hashCode => Object.hash(runtimeType, value);
}
