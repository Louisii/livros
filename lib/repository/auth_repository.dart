import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> login({required String email, required String senha}) async {
    const url = 'http://177.71.131.123:8080/api/v1/auth/login';

    final data = {
      'email': email,
      'senha': senha,
    };

    try {
      if (kDebugMode) {
        print('Attempting login with $data');
      }

      final response = await _dio.post(url, data: data);

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await _secureStorage.write(key: 'auth_token', value: token);
        if (kDebugMode) {
          print('Logged in successfully and token stored');
        }
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      throw Exception('Failed to log in');
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'auth_token');
  }
}
