class ApiEndpoint {
  static String customerOrderByOrderId(int customerId, int orderId) {
    return '$baseUrl/customers/$customerId/orders/$orderId';
  }

  static String customerOrderItemsByCustomerId(int customerId) {
    return '$baseUrl/customers/$customerId/orders/products';
  }

  static String updateCustomerOrderStatus(int customerId, int orderId, int status) {
    return '$baseUrl/customers/$customerId/orders/$orderId/status/$status';
  }
  static const baseUrl = 'http://192.168.43.29:10010';
  static const signIn = '$baseUrl/users/sign-in';
  static const signOut = '$baseUrl/users/sign-out';
  static const product = '$baseUrl/products';
  static const category = '$baseUrl/categories';
  static const uploadImage = '$baseUrl/images';
  static const orders = '$baseUrl/customers/orders';
  static const orderStats = '$baseUrl/customers/orders/stats';
  static const customer = '$baseUrl/customers';
  static const payment = '$baseUrl/payments';
}