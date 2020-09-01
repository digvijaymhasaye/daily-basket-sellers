import 'dart:convert';
import 'dart:io';

import 'package:daily_basket_sellers/models/customer_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../api_endpoints.dart';

class CustomerOrdersApiProvider {
  var sortBy = 'created_at';
  var sortOrder = 'desc';

  getStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');

    final response = await http.get(ApiEndpoint.orderStats, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'account_id': '1',
      'user_id': '$userId',
      'session_id': '102' // '$sessionId'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['stats'];
      return decodedResponse;
      // } else if (response.statusCode == 400) {

      // } else if (response.statusCode == 401) {

      // } else if (response.statusCode == 403) {

      // } else if (response.statusCode == 404) {

    } else {
      throw Exception('Something went wrong');
    }
  }

  getAllOrders(String sortBy, String sortOrder, int status, int pageNo, int pageSize) async {
    sortBy ??= this.sortBy;
    sortOrder ??= this.sortOrder;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');

    var url = '${ApiEndpoint.orders}?sort_by=$sortBy&sort_order=$sortOrder&page_no=$pageNo&page_size=$pageSize';

    if (status != null) {
      url += '&status=$status';
    }

    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'account_id': '1',
      'user_id': '$userId',
      'session_id': '102' // '$sessionId'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['orders'];
      var customerOrderList = decodedResponse
        ..map<CustomerOrderModel>((eachCustomerOrderObject) =>
            CustomerOrderModel.fromJson(eachCustomerOrderObject)).toList();
      return customerOrderList;
      // } else if (response.statusCode == 400) {

      // } else if (response.statusCode == 401) {

      // } else if (response.statusCode == 403) {

      // } else if (response.statusCode == 404) {

    } else {
      throw Exception('Something went wrong');
    }
  }

  getCustomerOrderByOrderId(int customerId, int orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');

    var url = ApiEndpoint.customerOrderByOrderId(customerId, orderId);
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'account_id': '1',
      'user_id': '$userId',
      'session_id': '$sessionId'
    });

    if (response.statusCode == 200) {
      final decodedResponse =
          json.decode(response.body)['data']['customer_order'];
      return CustomerOrderModel.fromJson(decodedResponse);
      // } else if (response.statusCode == 400) {

      // } else if (response.statusCode == 401) {

      // } else if (response.statusCode == 403) {

    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Something went wrong');
    }
  }

  getCustomerOrderItems(int customerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');

    var url = ApiEndpoint.customerOrderItemsByCustomerId(customerId);
    final response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'account_id': '1',
      'user_id': '$userId',
      'session_id': '$sessionId'
    });

    if (response.statusCode == 200) {
      final decodedResponse =
          json.decode(response.body)['data']['orders'];
      return decodedResponse..map<CustomerOrderModel>((eachOrderJson) => CustomerOrderModel.fromJson(eachOrderJson)).toList();
      // } else if (response.statusCode == 400) {

      // } else if (response.statusCode == 401) {

      // } else if (response.statusCode == 403) {

    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Something went wrong');
    }
  }

  updateOrderStatus(int customerId, int orderId, int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');

    var url =
        ApiEndpoint.updateCustomerOrderStatus(customerId, orderId, status);
    final response = await http.put(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'account_id': '1',
      'user_id': '$userId',
      'session_id': '$sessionId'
    });

    if (response.statusCode == 200) {
      final decodedResponse =
          json.decode(response.body)['data']['customer_order'];
      return CustomerOrderModel.fromJson(decodedResponse);
      // } else if (response.statusCode == 400) {

      // } else if (response.statusCode == 401) {

      // } else if (response.statusCode == 403) {

    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Something went wrong');
    }
  }
}
