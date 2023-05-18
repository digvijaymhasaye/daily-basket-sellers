import 'dart:async';

import 'package:daily_basket_sellers/repositories/customer_repository.dart';

class CustomerBloc {
  CustomerRepository _customerRepository = CustomerRepository();

  static final _customerListStreamController = StreamController.broadcast();
  static final _customerDetailStreamController = StreamController.broadcast();

  Stream get getCustomerListStream => _customerListStreamController.stream;
  Stream get getCustomerDetailsStream => _customerDetailStreamController.stream;

  getCustomerList(int status, String search, int pageSize) async {
    var customers = await _customerRepository.getCustomers(status, search, pageSize = 10);
    _customerListStreamController.sink.add(customers);
  }

  getCustomer(int id) async {
    var customer = await _customerRepository.getCustomerById(id);
    _customerDetailStreamController.sink.add(customer);
  }

  void dispose() {
    _customerListStreamController.close();
    _customerDetailStreamController.close();
  }
}