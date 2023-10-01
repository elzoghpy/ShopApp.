// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';

import 'product.dart';

class FavoritesData {
  int? id;
  Product? product;

  FavoritesData({this.id, this.product});

  factory FavoritesData.fromJson(Map<String, dynamic> json) => FavoritesData(
        id: json['id'] as int?,
        product: json['product'] == null
            ? null
            : Product.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product': product?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FavoritesData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ product.hashCode;
}
