import 'dart:async';

/// A model used for debouncing callbacks.
class AsyncDebouncer(final Duration _delay) {
  Timer? _timer;

  FutureOr<T> call<T>(
    FutureOr<T> Function() cb, {
    bool fireImmediately = false,
  }) {
    final completer = Completer<T>();

    _timer?.cancel();

    if (fireImmediately || _delay == .zero) {
      completer.complete(cb());
    } else {
      _timer = Timer(_delay, () => completer.complete(cb()));
    }

    return completer.future;
  }

  void cancel() => _timer?.cancel();

  /// Stops any running timers and disposes this instance.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
