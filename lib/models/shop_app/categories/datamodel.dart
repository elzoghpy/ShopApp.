class DataModel {
  int? id;
  dynamic name;
  dynamic image;

  DataModel({this.id, this.name, this.image});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
