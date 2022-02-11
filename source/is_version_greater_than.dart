bool isVersionGreaterThan({
  required String newVersion,
  required String currentVersion,
}) {
  final _currentVersion = currentVersion.split('.');
  final _newVersion = newVersion.split('.');

  bool isGreater = false;
  for (int i = 0; i < 3; i++) {
    final newVersionI = int.parse(_newVersion[i]);
    final currentVersionI = int.parse(_currentVersion[i]);
    isGreater = newVersionI > currentVersionI;
    if (newVersionI != currentVersionI) break;
  }
  return isGreater;
}
