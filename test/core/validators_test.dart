import 'package:flutter_base_project/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pure functions like [Validators] are the easiest things to test — no
/// widgets, no Riverpod, no mocks.
void main() {
  group('Validators.email', () {
    test('returns error when empty', () {
      expect(Validators.email(''), isNotNull);
    });

    test('returns error for malformed address', () {
      expect(Validators.email('not-an-email'), isNotNull);
    });

    test('returns null for a valid address', () {
      expect(Validators.email('eve.holt@reqres.in'), isNull);
    });
  });

  group('Validators.password', () {
    test('returns error when too short', () {
      expect(Validators.password('123'), isNotNull);
    });

    test('returns null for a long enough password', () {
      expect(Validators.password('cityslicka'), isNull);
    });
  });
}
