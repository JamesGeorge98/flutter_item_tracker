import 'dart:math';

String generateID() {
  final random = Random();

  String formatHex(int value, int length) {
    return value.toRadixString(16).padLeft(length, '0');
  }

  String generateRandomHex(int length) {
    final max = (1 << (length * 4)) - 1;
    return formatHex(random.nextInt(max + 1), length);
  }

  final part1 = generateRandomHex(8);
  final part2 = generateRandomHex(4);
  var part3 = generateRandomHex(4);
  var part4 = generateRandomHex(4);
  final part5 = generateRandomHex(12);

  part3 = (int.parse(part3, radix: 16) & 0x0FFF | 0x4000)
      .toRadixString(16)
      .padLeft(4, '0');

  part4 = (int.parse(part4, radix: 16) & 0x3FFF | 0x8000)
      .toRadixString(16)
      .padLeft(4, '0');

  return '$part1-$part2-$part3-$part4-$part5';
}
