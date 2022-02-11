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

// Test it
void main() {
  test("should return false if version is inferior", () {
    expect(
      isVersionGreaterThan(newVersion: "1.0.0", currentVersion: "1.0.1"),
      false,
    );
  });

  test("should return false if version is equal", () {
    expect(
      isVersionGreaterThan(newVersion: "1.0.0", currentVersion: "1.0.0"),
      false,
    );
  });

  test("should return true if version is greater", () {
    expect(
      isVersionGreaterThan(newVersion: "1.0.1", currentVersion: "1.0.0"),
      true,
    );
  });
}
