extension type CollectionOfOne<T>._(Iterable<T> _value) implements Iterable<T> {
  CollectionOfOne(T value) : this._value = List<T>.filled(1, value);
}
