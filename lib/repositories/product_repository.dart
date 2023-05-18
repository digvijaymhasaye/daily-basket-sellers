import 'package:daily_basket_sellers/api-providers/product_api_provider.dart';
import 'package:daily_basket_sellers/models/product_model.dart';

class ProductRepository {
  ProductApiProvider _productApiProvider = ProductApiProvider();

  getProductsCount(int status) async => await _productApiProvider.getProductsCount(status);

  getProducts(int pageNo, int pageSize, String sortBy, String sortOrder) async => await _productApiProvider.getProducts(pageNo, pageSize, sortBy, sortOrder);

  getProduct(int productId) async => await _productApiProvider.getProductById(productId);

  addProduct(int categoryId, String name, String description, int baseQuantity, String unit,
    num price, int quantity, String image) async => await _productApiProvider.addProduct(categoryId, name, description, baseQuantity, unit,
    price, quantity, image);

  updateProduct(int productId, int categoryId, String name, String description, int baseQuantity, String unit,
    num price, int quantity, String image) async => await _productApiProvider.updateProduct(productId,categoryId, name, description, baseQuantity, unit,
    price, quantity, image);
}