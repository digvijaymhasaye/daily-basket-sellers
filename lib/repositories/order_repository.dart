import 'package:daily_basket_sellers/api-providers/orders_api_provider.dart';

class CustomerOrderRepository {
  CustomerOrdersApiProvider _customerOrdersApiProvider = CustomerOrdersApiProvider();

  getStats() async => await _customerOrdersApiProvider.getStats();

  getOrders(String sortBy, String sortOrder, int status, int pageNo, int pageSize) async => await _customerOrdersApiProvider.getAllOrders(sortBy, sortOrder, status, pageNo, pageSize);

  getCustomerOrder(int customerId, int orderId) async => await _customerOrdersApiProvider.getCustomerOrderByOrderId(customerId, orderId);

  getCustomerOrderItems(int customerId) async => await _customerOrdersApiProvider.getCustomerOrderItems(customerId);

  updateCustomerOrderStatus(int customerId, int orderId, int status) async => await _customerOrdersApiProvider.updateOrderStatus(customerId, orderId, status);
}