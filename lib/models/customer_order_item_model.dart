import 'package:daily_basket_sellers/models/product_model.dart';

class CustomerOrderItemModel {
  int id;
  int orderId;
  int cartId;
  int productId;
  int quantity;
  int price;
  ProductModel product;

  CustomerOrderItemModel({
    this.id,
    this.orderId,
    this.cartId,
    this.productId,
    this.quantity,
    this.price,
    this.product,
  });

  factory CustomerOrderItemModel.fromJson(Map<String, dynamic> orderItemJson) {
    return CustomerOrderItemModel(
      id: orderItemJson['id'],
      orderId: orderItemJson['orderId'],
      cartId: orderItemJson['cartId'],
      productId: orderItemJson['productId'],
      quantity: orderItemJson['quantity'],
      price: orderItemJson['price'],
      product: ProductModel.fromJson(orderItemJson['product']),
    ); 
  }
}