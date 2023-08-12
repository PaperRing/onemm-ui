import 'dart:math';

class RandomUtil {
  RandomUtil._();

  static String getRandomString(int length) {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))),
    );
  }
}
