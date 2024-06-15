
import 'api_base.dart';
import 'api_response_status.dart';
import 'api_url.dart';

class ApiCategoryList {

  static void getCategoryData(
      Map<String, dynamic>? params,
      Function(ApiStatus) validator,
      ) async {
    await ApiBase.callApi(apiMethod: ApiMethod.post, url: ApiUrl.categoryList, params: params, validator: validator);
  }

  static void getSubCategoryData(
      Map<String, dynamic>? params,
      Function(ApiStatus) validator,
      ) async {
    await ApiBase.callApi(apiMethod: ApiMethod.post, url: ApiUrl.categoryList, params: params, validator: validator);
  }

  static void getProductData(
      Map<String, dynamic>? params,
      Function(ApiStatus) validator,
      ) async {
    await ApiBase.callApi(apiMethod: ApiMethod.post, url: ApiUrl.productList, params: params, validator: validator);
  }



}