import 'dart:convert';

typedef JsonDecodeReviver = Object? Function(Object? key, Object? value);

Object? jsonTryDecode(String source, {JsonDecodeReviver? reviver}) {
  try {
    return jsonDecode(source, reviver: reviver);
  } catch (e) {
    return null;
  }
}

// Test it
void main() {
  test("should return null if invalid source", () {
    expect(jsonTryDecode(""), isNull);
  });

  test("should return a valid JSON if source is correct", () {
    expect(jsonTryDecode('{"a":1}'), {"a": 1});
  });
}
