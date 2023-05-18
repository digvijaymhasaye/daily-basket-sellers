import 'package:daily_basket_sellers/api-providers/category_api_provider.dart';
import 'package:daily_basket_sellers/models/category_model.dart';

class CategoryRepository {
  CategoryApiProvider _categoryApiProvider = CategoryApiProvider();

  getCategories() async => await _categoryApiProvider.getCategories();

  getCategory(int categoryId) async => await _categoryApiProvider.getCategoryById(categoryId);

  addCategory(String name, String description, String image) async => await _categoryApiProvider.addCategory(name, description, image);

  updateCategory(int id, String name, String description, String image) async => await _categoryApiProvider.updateCategory(id, name, description, image);

  updateCategoryStatus(int id, int status) async => await _categoryApiProvider.updateCategoryStatus(id, status);

  deleteCategory(int id) async => await _categoryApiProvider.deleteCategory(id);
}