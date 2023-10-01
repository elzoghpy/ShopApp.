import 'data.dart';

class CatigoriesModel {
  bool? status;
  dynamic message;
  CategoriesDataModel? data;

  CatigoriesModel({this.status, this.message, this.data});

  factory CatigoriesModel.fromJson(Map<String, dynamic> json) =>
      CatigoriesModel(
        status: json['status'] as bool?,
        message: json['message'] as dynamic,
        data: json['data'] == null
            ? null
            : CategoriesDataModel.fromJson(
                json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
