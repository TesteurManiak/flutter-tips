import 'dart:async';

extension CompleterExtension<T> on Completer<T> {
  /// Ensure that the completer is not already completed before calling
  /// [complete] with the given [value].
  void safeComplete(FutureOr<T> value) {
    if (isCompleted) return;
    complete(value);
  }
}
