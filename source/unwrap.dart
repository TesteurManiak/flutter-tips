typedef UnwrapSuccess<T extends Object, ResultType> = ResultType Function(
  T value,
);
typedef UnwrapFailed<ResultType> = ResultType Function();

extension Unwrap<T extends Object> on T? {
  /// Unwrap the value if it is not null.
  ///
  /// Example:
  /// ```dart
  /// final String? value = 'Hello';
  /// value.unwrap(
  ///   onNotNull: (value) => print(value),
  ///   orElse: () => print('Value is null'),
  /// ); // Will print 'Hello'
  /// ```
  ResultType? unwrap<ResultType>({
    required UnwrapSuccess<T, ResultType> onNotNull,
    UnwrapFailed<ResultType>? orElse,
  }) {
    if (this case final nonNull?) {
      return onNotNull(nonNull);
    }
    return orElse?.call();
  }
}
