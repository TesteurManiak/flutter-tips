Future<T> benchmarkAsync<T>(Future<T> asyncOperation) async {
  final stopwatch = Stopwatch()..start();
  final result = await asyncOperation;
  stopwatch.stop();
  print('Operation executed in ${stopwatch.elapsed}');
  return result;
}
