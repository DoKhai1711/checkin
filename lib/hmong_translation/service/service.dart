import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/hmong_translation/model/base/response_object.dart';
import 'package:untitled/hmong_translation/model/login/login_dto.dart';
import 'package:untitled/hmong_translation/model/login/login_request_dto.dart';
import 'package:untitled/hmong_translation/service/base/base_service.dart';
import 'package:untitled/hmong_translation/service/network/api_request.dart';
import 'package:untitled/hmong_translation/service/network/path_url.dart';

abstract class MyAppService {
  Future<ResponseObject<LoginDto>> login({
    required LoginRequestDto request,
  });
}

class MyAppServiceImp extends BaseService implements MyAppService {
  @override
  Future<ResponseObject<LoginDto>> login({
    required LoginRequestDto request,
  }) async {
    try {
      final requestEncode = json.encode(request.toJson());

      http.Response response = await ApiRequest.post(
        EndPoint.URL_LOGIN,
        body: requestEncode,
      );

      if (kDebugMode) {
        print("${response.request?.url.toString()}");
      }

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));

        if (kDebugMode) {
          print(jsonData.toString());
        }

        final result = LoginDto.fromJson(jsonData);
        return ResponseObject(data: result);
      } else {
        return ResponseObject(error: "Tài khoản/mật khẩu không đúng");
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return ResponseObject(error: ex.toString());
    }
  }
}
