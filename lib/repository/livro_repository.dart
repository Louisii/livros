import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:livros/model/livro.dart';

class LivroRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  LivroRepository()
      : _dio = Dio(),
        _storage = FlutterSecureStorage() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<List<Livro>> fetchLivros() async {
    const url = 'http://177.71.131.123:8080/api/v1/livros';
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        return jsonList.map((json) => Livro.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch livros');
      }
    } catch (e) {
      print('Fetch Livros error: $e');
      throw Exception('Failed to fetch livros');
    }
  }

  Future<void> createLivro(Livro livro) async {
    const url = 'http://177.71.131.123:8080/api/v1/livros';
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await _dio.post(
        url,
        data: livro.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create livro');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Create Livro error: $e');
      }
    }
  }

  Future<void> updateLivro(int id, Livro livro) async {
    final url = 'http://177.71.131.123:8080/api/v1/livros/$id';
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await _dio.put(
        url,
        data: livro.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusMessage != "Created") {
        throw Exception('Failed to update livro');
      }
    } catch (e) {
      print('Update Livro error: $e');
      throw Exception('Failed to update livro');
    }
  }

  Future<void> deleteLivro(int id) async {
    final url = 'http://177.71.131.123:8080/api/v1/livros/$id';
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete livro');
      }
    } catch (e) {
      print('Delete Livro error: $e');
      throw Exception('Failed to delete livro');
    }
  }
}
