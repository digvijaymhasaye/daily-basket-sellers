import 'package:daily_basket_sellers/api-providers/customer_api_provider.dart';

class CustomerRepository {
  CustomerApiProvider _customerApiProvider = CustomerApiProvider();

  getCustomers(int status, String search, int pageSize) async => await _customerApiProvider.getCustomerList(status, search, pageSize);
  
  getCustomerById(int id) async => await _customerApiProvider.getCustomerById(id);
  
}