import 'dart:async';

import 'package:daily_basket_sellers/repositories/order_repository.dart';

class CustomerOrderBloc {
  CustomerOrderRepository _customerOrderRepository = CustomerOrderRepository();

  static final _statsStreamController = StreamController.broadcast();
  static final _ordersStreamController = StreamController.broadcast();
  static final _orderStreamController = StreamController.broadcast();
  static final _orderItemsStreamController = StreamController.broadcast();

  Stream get getStats => _statsStreamController.stream;
  Stream get ordersList => _ordersStreamController.stream;
  Stream get order => _orderStreamController.stream;
  Stream get getOrderItems => _orderItemsStreamController.stream;

  CustomerOrderBloc() {
    getOrderStats(true);
  }

  getOrderStats(bool asStream) async {
    var stats = await _customerOrderRepository.getStats();
    if (asStream) {
      _statsStreamController.sink.add(stats);
    } else {
      return stats;
    }
  }

  getAllOrdersList(String sortby, String sortOrder, int status, int pageNo, int pageSize, bool asStream) async {
    var orders = await _customerOrderRepository.getOrders(sortby, sortOrder, status, pageNo, pageSize);
    if (asStream) {
      _ordersStreamController.sink.add(orders);
    } else {
      return orders;
    }
  }

  getCustomerOrder(int customerId, int orderId, bool asStream) async {
    var order = await _customerOrderRepository.getCustomerOrder(customerId, orderId);
    if (asStream) {
      _orderStreamController.sink.add(order);
    } else {
      return order;
    }
  }

  getCustomerOrderItems(int customerId, bool asStream) async {
    var order = await _customerOrderRepository.getCustomerOrderItems(customerId);
    if (asStream) {
      _orderItemsStreamController.sink.add(order);
    } else {
      return order;
    }
  }

  updateCustomerOrderStatus(int customerId, int orderId, int status, bool asStream) async {
    var order = await _customerOrderRepository.updateCustomerOrderStatus(customerId, orderId, status);
    // if (asStream) {
    //   _orderStreamController.sink.add(order);
    // } else {
    return order;
    // }
  }

  void dispose() {
    _statsStreamController.close();
    _ordersStreamController.close();
    _orderStreamController.close();
    _orderItemsStreamController.close();
  }
}