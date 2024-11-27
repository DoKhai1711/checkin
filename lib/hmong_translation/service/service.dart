import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/hmong_translation/model/base/response_object.dart';
import 'package:untitled/hmong_translation/model/login/login_dto.dart';
import 'package:untitled/hmong_translation/model/login/login_request_dto.dart';
import 'package:untitled/hmong_translation/model/question/group_question.dart';
import 'package:untitled/hmong_translation/service/base/base_service.dart';
import 'package:untitled/hmong_translation/service/network/api_request.dart';
import 'package:untitled/hmong_translation/service/network/path_url.dart';

abstract class MyAppService {
  Future<ResponseObject<LoginDto>> login({
    required LoginRequestDto request,
  });

  Future<List<GroupQuestionDto>> getListGroupQuest();

  Future<ResponseObject<GroupQuestionDto>> getGroupQuest({
    required int id,
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

  @override
  Future<List<GroupQuestionDto>> getListGroupQuest() async {
    try {

      http.Response response = await ApiRequest.get(
        EndPoint.URL_GET_LIST_GROUP_QUESTION,
      );

      if (kDebugMode) {
        print("${response.request?.url.toString()}");
      }

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));

        if (kDebugMode) {
          print(jsonData.toString());
        }

        List<GroupQuestionDto> result = [];
        jsonData.forEach((v) {
          result.add(GroupQuestionDto.fromJson(v));
        });

        return result;

      } else {
        return [];
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return [];
    }
  }

  @override
  Future<ResponseObject<GroupQuestionDto>> getGroupQuest({
    required int id,
  }) async {
    try {

      http.Response response = await ApiRequest.get(
        "${EndPoint.URL_GET_GROUP_QUESTION}/$id",
      );

      if (kDebugMode) {
        print("${response.request?.url.toString()}");
      }

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));

        if (kDebugMode) {
          print(jsonData.toString());
        }

        final result = GroupQuestionDto.fromJson(jsonData);

        return ResponseObject(data: result);
      } else {
        return ResponseObject(error: "Server lỗi");
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return ResponseObject(error: ex.toString());
    }
  }

}
