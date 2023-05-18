import 'dart:async';

import 'package:daily_basket_sellers/models/category_model.dart';
import 'package:daily_basket_sellers/repositories/category_repository.dart';

class CategoryBloc {
  static final _categoryListStreamController = StreamController.broadcast();
  static final _categoryDetailsController = StreamController<CategoryModel>();

  CategoryRepository _categoryRepositories = CategoryRepository();

  Stream get getCategories => _categoryListStreamController.stream;
  StreamSink<List<dynamic>> get sinkCategoryId => _categoryListStreamController.sink;

  CategoryBloc() {
    getCategoryList();
  }

  getCategoryList() async {
    var _categoryList = await _categoryRepositories.getCategories();
    _categoryListStreamController.sink.add(_categoryList);
  }

  getProduct(int id) async {
    CategoryModel _category = await _categoryRepositories.getCategory(id);
    _categoryDetailsController.sink.add(_category);
  }

  addCategory(String name, String description, String image) async {
    var response = await _categoryRepositories.addCategory(name, description, image);
    return response;
  }

  updateCategory(int id, String name, String description, String image) async {
    var updatedImage = image.startsWith('https') ? null : image;
    var response = await _categoryRepositories.updateCategory(id, name, description, updatedImage);
    return response;
  }

  updateCategoryStatus(int id, int status) async {
    CategoryModel _category = await _categoryRepositories.updateCategoryStatus(id, status);
    return _category; 
  }

  deleteCategory(int id) async {
    CategoryModel _category = await _categoryRepositories.deleteCategory(id);
    return _category;
  }

  dispose() {
    _categoryListStreamController.close();
    _categoryDetailsController.close();
  }
}