import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class HashedPassword {
  const HashedPassword({required this.hash, required this.salt});

  final String hash;

  final String salt;
}

class PasswordHasher {
  const PasswordHasher();

  static const int _iterations = 12000;
  static const int _keyLength = 32;
  static const int _saltLength = 16;

  HashedPassword hash(String password) {
    final salt = _randomBytes(_saltLength);
    final derived = _pbkdf2(utf8.encode(password), salt);
    return HashedPassword(
      hash: base64.encode(derived),
      salt: base64.encode(salt),
    );
  }

  bool verify({
    required String password,
    required String hash,
    required String salt,
  }) {
    final derived = _pbkdf2(utf8.encode(password), base64.decode(salt));
    return _constantTimeEquals(derived, base64.decode(hash));
  }

  Uint8List _pbkdf2(List<int> password, List<int> salt) {
    final hmac = Hmac(sha256, password);
    final blockCount = (_keyLength / 32).ceil();
    final output = BytesBuilder();

    for (var block = 1; block <= blockCount; block++) {
      var u = hmac.convert([...salt, ..._intToBytes(block)]).bytes;
      final result = Uint8List.fromList(u);
      for (var i = 1; i < _iterations; i++) {
        u = hmac.convert(u).bytes;
        for (var j = 0; j < result.length; j++) {
          result[j] ^= u[j];
        }
      }
      output.add(result);
    }

    return output.toBytes().sublist(0, _keyLength);
  }

  List<int> _intToBytes(int value) => [
    (value >> 24) & 0xff,
    (value >> 16) & 0xff,
    (value >> 8) & 0xff,
    value & 0xff,
  ];

  Uint8List _randomBytes(int length) {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(length, (_) => random.nextInt(256)),
    );
  }

  bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
