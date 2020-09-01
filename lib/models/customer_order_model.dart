import 'package:daily_basket_sellers/models/customer_order_address_model.dart';
import 'package:daily_basket_sellers/models/customer_order_item_model.dart';
import 'package:daily_basket_sellers/models/payment_model.dart';

import 'customer_model.dart';

class CustomerOrderModel {
  int id;
  int customerId;
  int itemsCount;
  int totalPrice;
  int deliveryType;
  int paymentType;
  String notes;
  int status;
  String createdAt;
  CustomerModel customer;
  CustomerOrderAddressModel address;
  List orderItems;
  PaymentModel payment;

  CustomerOrderModel({
    this.id,
    this.customerId,
    this.itemsCount,
    this.totalPrice,
    this.deliveryType,
    this.paymentType,
    this.notes,
    this.status,
    this.createdAt,
    this.customer,
    this.address,
    this.orderItems,
    this.payment,
  });

  factory CustomerOrderModel.fromJson(Map<String, dynamic> customerOrderJson) {
    return CustomerOrderModel(
      id: customerOrderJson['id'],
      customerId: customerOrderJson['customer_id'],
      itemsCount: customerOrderJson['items_count'],
      totalPrice: customerOrderJson['total_price'],
      deliveryType: customerOrderJson['delivery_type'],
      paymentType: customerOrderJson['payment_type'],
      notes: customerOrderJson['notes'],
      status: customerOrderJson['status'],
      createdAt: customerOrderJson['created_at'],
      customer: customerOrderJson['customer'] == null
          ? null
          : CustomerModel.fromJson(customerOrderJson['customer']),
      address: customerOrderJson['customer_order_address'] == null
          ? null
          : CustomerOrderAddressModel.fromJson(
              customerOrderJson['customer_order_address']),
      orderItems: customerOrderJson['customer_order_items'] == null
          ? []
          : customerOrderJson['customer_order_items']..map<CustomerOrderItemModel>((eachOrderItem) =>
            CustomerOrderItemModel.fromJson(eachOrderItem)).toList(),
      payment: customerOrderJson['payment'] == null
        ? null
        : PaymentModel.fromJson(customerOrderJson['payment'])
    );
  }
}
