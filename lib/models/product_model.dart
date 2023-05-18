import 'package:daily_basket_sellers/models/image_model.dart';

class ProductModel {
  int id;
  String name;
  String description;
  int price;
  int quantity;
  int baseQuantity;
  var unit;
  ImageModel image;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.baseQuantity,
    this.unit,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> productJson) {
    return ProductModel(
      id: productJson['id'],
      name: productJson['name'],
      description: productJson['description'],
      price: productJson['price'],
      quantity: productJson['quantity'],
      baseQuantity: productJson['base_quantity'],
      unit: productJson['unit'],
      image: ImageModel.fromJson(productJson['image']),
    );
  }

  // int get id => id;

  // String get name => name;
  
  // String get description => _description;
  
  // String get price => _price;
  
  // int get quantity => _quantity;
  
  // int get baseQuantity => _baseQuantity;
  
  // String get unit => _unit;
  
  // List get images => _images;
}