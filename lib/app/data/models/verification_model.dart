class VerificationModel {
  bool? successful;
  String? message;
  int? statusCode;
  Data? data;

  VerificationModel(
      {this.successful, this.message, this.statusCode, this.data});

  VerificationModel.fromJson(Map<String, dynamic> json) {
    successful = json['successful'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['successful'] = successful;
    data['message'] = message;
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
