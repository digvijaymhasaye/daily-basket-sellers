import 'image_model.dart';

class CategoryModel {
  int id;
  String name;
  String description;
  ImageModel image;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> categoryJson) {
    return CategoryModel(
      id: categoryJson['id'],
      name: categoryJson['name'],
      description: categoryJson['description'],
      image: ImageModel.fromJson(categoryJson['image']),
    );
  }

  // int get id => _id;

  // String get name => _name;
  
  // String get description => _description;
  
  // ImageModel get image => _image;
}