import 'dart:async';

typedef StreamConverterCallback<T, S> = S Function(T value);

extension StreamConverterExtension<T> on Stream<T> {
  /// Convert the stream by applying the given [handler] to each value
  /// received and convert it to a new type.
  Stream<S> convertTo<S>(StreamConverterCallback<T, S> handler) {
    final transformer = StreamTransformer<T, S>.fromHandlers(
      handleData: (T data, Sink<S> sink) {
        final value = handler(data);
        sink.add(value);
      },
    );
    return transform(transformer);
  }
}
