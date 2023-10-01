import 'data.dart';

class Profilemodel {
  bool? status;
  dynamic message;
  Data? data;

  Profilemodel({this.status, this.message, this.data});

  factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
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
