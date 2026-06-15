import 'package:encrypt/encrypt.dart' as encrypt;

String customEncrypt(String input, String keyString) {
  // Pad the key to 16 bytes with underscores (matching PHP 16-byte AES-128 key)
  final key = encrypt.Key.fromUtf8(keyString.padRight(16, '\x00'));

  final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.ecb),
  );

  // ECB mode: no IV required
  final encrypted = encrypter.encrypt(input);

  // Custom base64 replacements
  String safe = encrypted.base64
      .replaceAll('+', '-')
      .replaceAll('/', '_')
      .replaceAll('=', 'p;');

  return safe;
}

