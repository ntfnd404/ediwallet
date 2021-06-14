import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCtorage {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future setAuthKey({required String key}) async {
    await _secureStorage.write(key: 'auth_key', value: key);
  }

  static Future<String?> getAuthKey() async {
    return _secureStorage.read(key: 'auth_key');
  }

  static Future setIsAuthorized({required String key}) async {
    await _secureStorage.write(key: 'is_authorized', value: key);
  }

  static Future<bool> getIsAuthorized() async {
    if (await _secureStorage.containsKey(key: 'is_authorized') == false) {
      return false;
    }

    final String? isAuthorized =
        await _secureStorage.read(key: 'is_authorized');

    if (isAuthorized == null) {
      return false;
    } else {
      return isAuthorized == 'true';
    }
  }
}
