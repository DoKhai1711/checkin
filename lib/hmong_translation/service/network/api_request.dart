import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequest {
  static Future<http.Response> post(
    url, {
    body,
    Encoding? encoding,
  }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "Authorization": "Bearer $token",
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 401) {
      throw AuthorizationException("Tên đăng nhập và mật khẩu không hợp lệ!");
    }
    if (response.statusCode == 403) {
      throw AuthorizationException("Bạn không có quyền!");
    }
    return response;
  }

  static Future<http.Response> postWithParams(
      url, body,{
        queryParameters,
      }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };
    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: queryParameters);
    final response = await http.post(finalUri, headers: headers,body: body);
    if (response.statusCode == 401) {
      throw AuthorizationException("Đăng nhập thất bại!");
    }
    if (response.statusCode == 403) {
      throw AuthorizationException("Bạn không có quyền!");
    }
    return response;
  }

  static Future<http.StreamedResponse> postFileAttach(
      url, {
        files,
        queryParameters,
      }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "Authorization": "Bearer $token",
    };
    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: queryParameters);
    var request = http.MultipartRequest("POST", finalUri);
    for (var file in files!) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'files',
          file.path ?? '',
          filename: basename(file.path ?? ''),
        ),
      );
      request.headers.addAll(headers);
    }
    return request.send();
  }

  static Future<http.Response> get(
    url, {
    body,
    Encoding? encoding,
  }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 401) {
      throw AuthorizationException("Đăng nhập thất bại!");
    }
    if (response.statusCode == 403) {
      throw AuthorizationException("Bạn không có quyền!");
    }
    return response;
  }

  static Future<http.Response> getWithParams(
      url, {
        queryParameters,
      }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };
    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: queryParameters);
    final response = await http.get(finalUri, headers: headers);
    if (response.statusCode == 401) {
      throw AuthorizationException("Đăng nhập thất bại!");
    }
    if (response.statusCode == 403) {
      throw AuthorizationException("Bạn không có quyền!");
    }
    return response;
  }

  static Future<http.Response> put(
    url, {
    body,
    Encoding? encoding,
  }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };
    return http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  static Future<http.Response> putWithParam(
      url, {
        body,
        Encoding? encoding,
        queryParameters,
      }) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };
    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: queryParameters);
    return http.put(
      finalUri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  static Future<http.Response> delete(url) async {
    // final token = await getToken();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };
    return http.delete(Uri.parse(url), headers: headers);
  }

  // static Future<String?> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(Constants.ACCESS_TOKEN);
  // }

}

class AuthorizationException implements Exception {
  final message;

  AuthorizationException(this.message);

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}
