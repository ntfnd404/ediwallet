import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AuthStatus { none, authorized, pinEnabled }

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

  static Future<String?> getPin() async {
    return _secureStorage.read(key: 'pin');
  }

  static Future setPin({required String pin}) async {
    await _secureStorage.write(key: 'pin', value: pin);
  }

  static Future enablePin({required bool isEnabled}) async {
    await _secureStorage.write(key: 'pin_enabled', value: isEnabled.toString());
  }

  static Future<bool> pinIsEnabled() async {
    return await _secureStorage.containsKey(key: 'pin') == true;
  }

  static Future<AuthStatus> getAuthStatus() async {
    if (await _secureStorage.containsKey(key: 'is_authorized') == false) {
      return AuthStatus.none;
    }

    if (await _secureStorage.containsKey(key: 'pin') == true) {
      return AuthStatus.pinEnabled;
    } else {
      return AuthStatus.authorized;
    }
  }
}
