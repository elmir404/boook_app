class ImagesModel {
  int? imageId;
  String? base;

  ImagesModel({this.imageId, this.base});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    base = json['base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['base'] = this.base;
    return data;
  }
}
