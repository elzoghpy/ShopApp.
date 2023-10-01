class ChangesearchModel {
  bool? status;
  String? message;
  ChangesearchModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
