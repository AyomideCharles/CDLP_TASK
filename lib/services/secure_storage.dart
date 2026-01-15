import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await secureStorage.write(key: 'accessToken', value: token);
  }

  Future<void> storeRefreshToken(String refreshToken) async {
    await secureStorage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: 'refreshToken');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'accessToken');
    await secureStorage.delete(key: 'refreshToken');
  }
}
