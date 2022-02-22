extension ContainsNoDiacritics on String {
  static const diacritics =
      "ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž";
  static const letters =
      "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";

  String get withoutDiacritics => splitMapJoin(
        "",
        onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
            ? letters[diacritics.indexOf(char)]
            : char,
      );

  bool containsNoDiacritics(Pattern other, [int startIndex = 0]) =>
      withoutDiacritics.contains(other, startIndex);
}

// Test it
void main() {
  group("withoutDiacritics", () {
    test("should replace diacritics letter with their counterparts", () {
      expect(
        ContainsNoDiacritics.diacritics.withoutDiacritics,
        ContainsNoDiacritics.letters,
      );
    });
  });

  group("containsNoDiacritics", () {
    test(
      "should return true if the word contains é while the pattern include e",
      () {
        expect("é".containsNoDiacritics("e"), true);
      },
    );
  });
}
