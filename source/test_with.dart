import 'dart:async';

import 'package:meta/meta.dart';
import 'package:test/test.dart';

typedef TestWithCallback<T> = FutureOr<void> Function(T arg);

@isTest
void testWith<T>(String name, TestWithCallback<T> testFn, Iterable<T> args) {
  for (final arg in args) {
    test('_ with $arg', () => testFn(arg));
  }
}
