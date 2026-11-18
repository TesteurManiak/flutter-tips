import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

typedef AsyncErrorCallback = void Function(Object error, StackTrace stackTrace);

class AsyncOperation extends StatefulWidget {
  const AsyncOperation({required this.child, this.onError, super.key});

  final AsyncErrorCallback? onError;
  final Widget child;

  @override
  State<AsyncOperation> createState() => _AsyncOperationState();

  static AsyncOperationState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AsyncOperationData>()
        ?.state;
  }

  static AsyncOperationState of(BuildContext context) {
    final state = maybeOf(context);
    if (state == null)
      throw FlutterError('No AsyncOperationState found in context');
    return state;
  }

  static bool loading(BuildContext context) => of(context).loading;

  static Future<void> operation(BuildContext context, AsyncCallback op) =>
      of(context).operation(op);
}

class AsyncOperationState extends State<AsyncOperation> {
  final _ops = <int>{};

  bool get loading => _ops.isNotEmpty;

  Future<void> operation(AsyncCallback op) async {
    final opFuture = op();
    final uniqueKey = opFuture.hashCode;
    setState(() => _ops.add(uniqueKey));

    try {
      await opFuture;
    } catch (e, s) {
      log(
        'Async operation error',
        error: e,
        stackTrace: s,
        name: 'AsyncOperation',
      );
      widget.onError?.call(e, s);
    } finally {
      if (mounted) {
        setState(() => _ops.remove(uniqueKey));
      } else {
        _ops.remove(uniqueKey);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AsyncOperationData(
      state: this,
      loading: loading,
      child: widget.child,
    );
  }
}

class _AsyncOperationData extends InheritedWidget {
  const _AsyncOperationData({
    required this.state,
    required this.loading,
    required super.child,
  });

  final bool loading;
  final AsyncOperationState state;

  @override
  bool updateShouldNotify(_AsyncOperationData oldWidget) =>
      oldWidget.loading != loading;
}
