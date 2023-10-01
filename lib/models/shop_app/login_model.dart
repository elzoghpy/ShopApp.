// ignore_for_file: unused_import

class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? cradite;
  String? token;

  UserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    cradite = json['cradite'];
    token = json['token'];
  }
}
