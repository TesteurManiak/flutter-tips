/// Allows you to navigate using `context.go` & `context.push` by passing a
/// [Uri].
///
/// ```dart
/// context.goUri(Uri(path: '/home', queryParameters: {'index': '1'}));
/// ```
extension GoRouterUriExtension on BuildContext {
  void goUri(Uri uri, {Object? extra}) => go(uri.toString(), extra: extra);
  void pushUri(Uri uri, {Object? extra}) => push(uri.toString(), extra: extra);
}

/// Allows you to navigate to a specific route from a [Uri] object.
///
/// ```dart
/// Uri(path: '/home', queryParameters: {'index': '1'}).go(context);
/// ```
extension GoRouterNavigationExtension on Uri {
  void go(BuildContext context, {Object? extra}) => context.goUri(
        this,
        extra: extra,
      );

  void push(BuildContext context, {Object? extra}) => context.pushUri(
        this,
        extra: extra,
      );
}
