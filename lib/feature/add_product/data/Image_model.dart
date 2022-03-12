class ImageModel {
  String? token;
  String? message;
  String? filename;
  String? path;

  ImageModel({this.token, this.message, this.filename, this.path});

  ImageModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    filename = json['filename'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    data['filename'] = this.filename;
    data['path'] = this.path;
    return data;
  }
}
