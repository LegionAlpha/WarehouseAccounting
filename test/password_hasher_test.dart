import 'package:flutter_test/flutter_test.dart';
import 'package:warehouse_accounting/data/security/password_hasher.dart';

void main() {
  const hasher = PasswordHasher();

  group('PasswordHasher', () {
    test('verifies a correct password', () {
      final hashed = hasher.hash('s3cret!');
      expect(
        hasher.verify(
          password: 's3cret!',
          hash: hashed.hash,
          salt: hashed.salt,
        ),
        isTrue,
      );
    });

    test('rejects an incorrect password', () {
      final hashed = hasher.hash('s3cret!');
      expect(
        hasher.verify(
          password: 'wrong-password',
          hash: hashed.hash,
          salt: hashed.salt,
        ),
        isFalse,
      );
    });

    test('uses a unique salt so identical passwords hash differently', () {
      final first = hasher.hash('same-password');
      final second = hasher.hash('same-password');
      expect(first.salt, isNot(equals(second.salt)));
      expect(first.hash, isNot(equals(second.hash)));
    });
  });
}
