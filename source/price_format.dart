extension PriceFormatExt on double {
  /// Return the value formatted as would be a price with spaces.
  ///
  /// If the [currency] parameter is used, it will be used as the currency
  /// symbol.
  ///
  /// ## Example
  ///
  /// ```dart
  /// 3700440.0.toPriceValue(); // 3 700 440,00
  /// 3700440.0.toPriceValue(currency: '€'); // 3 700 440,00 €
  /// ```
  String toPriceValue({String? currency}) {
    final base = toStringAsFixed(2);
    final parts = base.split('.');
    final intPart = parts[0];
    final decimalPart = parts[1];
    final buffer = StringBuffer();
    final intPartContent = <String>[];
    final reversedIntPart = intPart.split('').reversed.toList();
    for (int i = 0; i < reversedIntPart.length; i++) {
      final char = reversedIntPart[i];
      if (i % 3 == 0) {
        intPartContent.add(' ');
      }
      intPartContent.add(char);
    }
    buffer
      ..write(intPartContent.reversed.join().trim())
      ..write(',$decimalPart');

    if (currency != null) {
      buffer.write(' $currency');
    }

    return buffer.toString();
  }
}
