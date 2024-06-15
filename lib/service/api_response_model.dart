
class ApiResponseModel {
  var status = 0;
  var message = "";
  dynamic result;

  ApiResponseModel({
    required this.status,
    required this.message,
    required this.result,
  });

  ApiResponseModel.fromJson(Map json)
      : status = json['Status'],
        message = json['Message'],
        result = json['Result'];
}