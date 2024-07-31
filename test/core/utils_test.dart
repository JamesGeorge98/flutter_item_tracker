import 'package:flutter_item_tracker/core/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generateID should produce a valid UUID', () {
    final id = generateID();
    final parts = id.split('-');

    expect(parts.length, equals(5));
    expect(parts[0].length, equals(8));
    expect(parts[1].length, equals(4));
    expect(parts[2].length, equals(4));
    expect(parts[3].length, equals(4));
    expect(parts[4].length, equals(12));

    // Basic format check, more rigorous validation might be required
    expect(int.tryParse(parts[0], radix: 16), isNotNull);
    expect(int.tryParse(parts[1], radix: 16), isNotNull);
    expect(int.tryParse(parts[2], radix: 16), isNotNull);
    expect(int.tryParse(parts[3], radix: 16), isNotNull);
    expect(int.tryParse(parts[4], radix: 16), isNotNull);
  });

  test('generateID should produce different IDs', () {
    final id1 = generateID();
    final id2 = generateID();
    expect(id1, isNot(equals(id2)));
  });
}
