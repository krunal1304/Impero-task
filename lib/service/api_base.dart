
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:impero_task/service/api_response_model.dart';

Future<ApiResponseModel> postData(String url, Map<String, dynamic> body) async {
  try {
    final response = await http.post(Uri.parse(url),body: json.encode(body),headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return ApiResponseModel.fromJson(jsonDecode(response.body));
    }
    return ApiResponseModel(status: 0, message: "test", result: "null");
  }catch (e){
    // Error occurred
    if (kDebugMode) {
      return ApiResponseModel(status: 0, message: e.toString(), result: "null");
      print('Error in POST request: $e');
    }
     return ApiResponseModel(status: 0, message: e.toString(), result: "null");
  }

}