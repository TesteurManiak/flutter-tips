extension PumpApp on WidgetTester {
  /// Call [pumpWidget] with the given [child] wrapped inside a [MaterialApp].
  Future<void> pumpApp(Widget child) {
    return pumpWidget(MaterialApp(home: child));
  }

  /// Call [pumpWidget] with the given [child] wrapped inside a [Localizations]
  /// widget using the given [locale].
  Future<void> pumpLocalized(Widget child, Locale locale) {
    return pumpWidget(
      Localizations(
        locale: locale,
        delegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        child: child,
      ),
    );
  }
}
