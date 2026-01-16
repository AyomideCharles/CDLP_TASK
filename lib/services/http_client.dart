import 'dart:convert';
import 'dart:io';
import 'package:cpld_task/services/secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final SecureStorage _secureStorage = SecureStorage();

  Future<Map<String, String>> _getHeaders({
    bool requiresAuth = false,
    Map<String, String>? additionalHeaders,
  }) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (requiresAuth) {
      String? token = await _secureStorage.getToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  Future<T> get<T>(
    String url, {
    bool requiresAuth = false,
    Map<String, String>? additionalHeaders,
    T Function(Map<String, dynamic>)? fromJson,
    int expectedStatusCode = 200,
  }) async {
    try {
      final headers = await _getHeaders(
        requiresAuth: requiresAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http.get(Uri.parse(url), headers: headers);

      return _handleResponse<T>(
        response,
        fromJson: fromJson,
        expectedStatusCode: expectedStatusCode,
      );
    } on SocketException {
      throw "No internet connection or server unreachable.";
    } catch (e) {
      rethrow;
    }
  }

  Future<T> post<T>(
    String url, {
    required dynamic body,
    bool requiresAuth = false,
    Map<String, String>? additionalHeaders,
    T Function(Map<String, dynamic>)? fromJson,
    int expectedStatusCode = 200,
  }) async {
    try {
      final headers = await _getHeaders(
        requiresAuth: requiresAuth,
        additionalHeaders: additionalHeaders,
      );

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      return _handleResponse<T>(
        response,
        fromJson: fromJson,
        expectedStatusCode: expectedStatusCode,
      );
    } on SocketException {
      throw "No internet connection or server unreachable.";
    } catch (e) {
      rethrow;
    }
  }

  // Future<T> patch<T>(
  //   String url, {
  //   required dynamic body,
  //   bool requiresAuth = false,
  //   Map<String, String>? additionalHeaders,
  //   T Function(Map<String, dynamic>)? fromJson,
  //   int expectedStatusCode = 200,
  // }) async {
  //   try {
  //     final headers = await _getHeaders(
  //       requiresAuth: requiresAuth,
  //       additionalHeaders: additionalHeaders,
  //     );

  //     final response = await http.patch(
  //       Uri.parse(url),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );

  //     return _handleResponse<T>(
  //       response,
  //       fromJson: fromJson,
  //       expectedStatusCode: expectedStatusCode,
  //     );
  //   } on SocketException {
  //     throw "No internet connection or server unreachable.";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<T> delete<T>(
  //   String url, {
  //   bool requiresAuth = false,
  //   Map<String, String>? additionalHeaders,
  //   T Function(Map<String, dynamic>)? fromJson,
  //   int expectedStatusCode = 200,
  // }) async {
  //   try {
  //     final headers = await _getHeaders(
  //       requiresAuth: requiresAuth,
  //       additionalHeaders: additionalHeaders,
  //     );

  //     final response = await http.delete(Uri.parse(url), headers: headers);

  //     return _handleResponse<T>(
  //       response,
  //       fromJson: fromJson,
  //       expectedStatusCode: expectedStatusCode,
  //     );
  //   } on SocketException {
  //     throw "No internet connection or server unreachable.";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<T> put<T>(
  //   String url, {
  //   required dynamic body,
  //   bool requiresAuth = false,
  //   Map<String, String>? additionalHeaders,
  //   T Function(Map<String, dynamic>)? fromJson,
  //   int expectedStatusCode = 200,
  // }) async {
  //   try {
  //     final headers = await _getHeaders(
  //       requiresAuth: requiresAuth,
  //       additionalHeaders: additionalHeaders,
  //     );

  //     final response = await http.put(
  //       Uri.parse(url),
  //       headers: headers,
  //       body: jsonEncode(body),
  //     );
  //     return _handleResponse<T>(
  //       response,
  //       fromJson: fromJson,
  //       expectedStatusCode: expectedStatusCode,
  //     );
  //   } on SocketException {
  //     throw "No internet connection or server unreachable.";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<T> patchMultipart<T>(
  //   String url, {
  //   required Map<String, String> fields,
  //   List<http.MultipartFile>? files,
  //   bool requiresAuth = false,
  //   T Function(Map<String, dynamic>)? fromJson,
  //   int expectedStatusCode = 200,
  // }) async {
  //   try {
  //     final headers = await _getHeaders(requiresAuth: requiresAuth);

  //     final request = http.MultipartRequest('PATCH', Uri.parse(url));
  //     request.headers.addAll(headers);
  //     request.fields.addAll(fields);

  //     if (files != null) {
  //       request.files.addAll(files);
  //     }

  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);

  //     return _handleResponse<T>(
  //       response,
  //       fromJson: fromJson,
  //       expectedStatusCode: expectedStatusCode,
  //     );
  //   } on SocketException {
  //     throw "No internet connection or server unreachable.";
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  T _handleResponse<T>(
    http.Response response, {
    T Function(Map<String, dynamic>)? fromJson,
    int expectedStatusCode = 200,
  }) {
    if (response.statusCode == expectedStatusCode) {
      final responseBody = jsonDecode(response.body);
      if (fromJson != null) {
        return fromJson(responseBody);
      }
      if (T == bool) {
        return true as T;
      }
      return responseBody as T;
    } else {
      try {
        final data = jsonDecode(response.body);
        final errorMessage = data['message'];
        throw errorMessage;
      } catch (e) {
        rethrow;
      }
    }
  }
}
