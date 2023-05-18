import 'dart:async';

import 'package:daily_basket_sellers/models/product_model.dart';
import 'package:daily_basket_sellers/repositories/product_repository.dart';

class ProductBloc {
  static final _productListStreamController = StreamController.broadcast();
  static final _productsCountStreamController = StreamController.broadcast();
  static final _productDetailsController =
      StreamController<ProductModel>.broadcast();

  ProductRepository _productRepositories = ProductRepository();

  Stream get getProductsStream => _productListStreamController.stream;
  Stream get getProductDetailsStream => _productDetailsController.stream;
  Stream get getStatsStream => _productsCountStreamController.stream;

  getStats() async {
    var activeProducts = await _productRepositories.getProductsCount(1);
    var allProductsCount = await _productRepositories.getProductsCount(null);
    _productsCountStreamController.sink.add({
      'active_products': activeProducts,
      'total_products': allProductsCount,
    });
  }

  getProductsList(int pageNo, int pageSize, String sortBy, String sortOrder, bool asStream) async {
    var _productList = await _productRepositories.getProducts(pageNo, pageSize, sortBy, sortOrder);
    if (asStream) {
      _productListStreamController.sink.add(_productList); 
    } else {
      return _productList;
    }
  }

  getProduct(int id) async {
    ProductModel _product = await _productRepositories.getProduct(id);
    _productDetailsController.sink.add(_product);
  }

  addProduct(int categoryId, String name, String description, int baseQuantity, String unit,
    num price, int quantity, String image) async {
      var _product = await _productRepositories.addProduct(categoryId, name, description, baseQuantity, unit,
        price, quantity, image);
      return _product;
    }
  
  updateProduct(int productId, int categoryId, String name, String description, int baseQuantity, String unit,
    num price, int quantity, String image) async {
      var updatedImage = image.startsWith('https') ? null : image;
      var _product = await _productRepositories.updateProduct(productId, categoryId, name, description, baseQuantity, unit,
        price, quantity, updatedImage);
      return _product;
    }

  dispose() {
    _productListStreamController.close();
    _productsCountStreamController.close();
    _productDetailsController.close();
  }
}
