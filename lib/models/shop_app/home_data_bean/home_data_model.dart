import 'data.dart';

class HomeDataModel {
  bool? status;
  dynamic message;
  Data? data;

  HomeDataModel({this.status, this.message, this.data});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        status: json['status'] as bool?,
        message: json['message'] as dynamic,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
