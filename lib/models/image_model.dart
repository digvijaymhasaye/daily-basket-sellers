class ImageModel {
  int id;
  String url;

  ImageModel({
    this.id,
    this.url,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
    );
  }

  int get imageId => id;

  String get imageUrl => url;
}