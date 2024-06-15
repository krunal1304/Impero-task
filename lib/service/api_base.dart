
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'api_response_model.dart';
import 'api_response_status.dart';
import 'api_url.dart';

enum ApiMethod {post}
var dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 5),
  ),
);

class ApiBase {

  //Api Base On Method(like GET, POST, DELETE)
  static callApi({
    required ApiMethod apiMethod,
    required String url,
    Map<String, dynamic>? params,
    required Function(ApiStatus) validator,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.vpn) {
      var endPoint = ApiUrl.apiVersion + url;
      var response = await _postMethod(ApiUrl.baseURL + endPoint, params);
      validator(_successHandler(response));
    } else {

    }
  }

  //Call Post API
  static Future<ApiResponseModel> _postMethod(
      String path,
      Map<String, dynamic>? params,
      ) async {
    try {
      Response response = await dio.post(path, data: params);
      if (response.statusCode == 200) {
        return ApiResponseModel.fromJson(response.data);
      } else {
        return errorHandler(response.statusCode);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return _postMethod(path, params);
      } else {
        return errorHandler(e.response?.statusCode);
      }
    }
  }



  //All API Success Response Handler
  static ApiStatus _successHandler(
      ApiResponseModel baseModel,
      ) {
    if (baseModel.status == 200) {
      return ApiStatus.completed(baseModel.result);
    } else if (baseModel.status == 2) {
      return ApiStatus.none();
    }
      return ApiStatus.error(baseModel.message);

  }

  //All API Error Response Handler
  static ApiResponseModel errorHandler(
      int? statusCode,
      ) {
    var errorMsg = "";

    if (statusCode == 500) {
      errorMsg = "Under Maintenance: Our server is getting renovated. Come back in a while to watch the new mansion unfold.";
    } else if (statusCode == 404) {
      errorMsg = "Not found: Missing media! The media you're looking for is currently unavailable. Please return if found elsewhere.";
    } else if (statusCode == 429) {
      errorMsg = "Too many requests: Slow down buddy! You're browsing too fast & over speeding kills (the joy out of the app).";
    } else if (statusCode == 408) {
      errorMsg = "Request Timeout: Time's up! Time runs out for everyone sometimes. Looks like it ran out for this action too.";
    } else if (statusCode == 413) {
      errorMsg = "File size to large please select small file.";
    } else {
      errorMsg = "Something went Wrong! Please retry $statusCode";
    }

    return ApiResponseModel(status: 0, message: errorMsg, result: "");
  }


}