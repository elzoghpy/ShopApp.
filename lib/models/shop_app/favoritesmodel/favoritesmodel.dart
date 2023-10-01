// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';

import 'data.dart';

class Favoritesmodel {
  bool? status;
  dynamic message;
  Data? data;

  Favoritesmodel({this.status, this.message, this.data});

  factory Favoritesmodel.fromJson(Map<String, dynamic> json) {
    return Favoritesmodel(
      status: json['status'] as bool?,
      message: json['message'] as dynamic,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Favoritesmodel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
