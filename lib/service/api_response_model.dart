

class ApiResponseModel {

  var status = 0;
  var message = "";
  dynamic result;

  ApiResponseModel({
    required this.status,
    required this.message,
    required this.result
  });

  ApiResponseModel.fromJson(Map map)
  : status = map["Status"],
    message = map["Message"],
    result = map["Result"];

}