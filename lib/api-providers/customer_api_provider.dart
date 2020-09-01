import 'dart:convert';
import 'dart:io';

import 'package:daily_basket_sellers/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api_endpoints.dart';

class CustomerApiProvider {
  getCustomerList(int status, String search, int pageSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
  
    final response = await http.get(
      ApiEndpoint.customer,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '102'// '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['customers'];
      var customerList = decodedResponse..map<CustomerModel>((eachCustomerObject) => CustomerModel.fromJson(eachCustomerObject)).toList();

      return customerList;
    // } else if (response.statusCode == 400) {
      
    // } else if (response.statusCode == 401) {
      
    // } else if (response.statusCode == 403) {
      
    // } else if (response.statusCode == 404) {
      
    } else {
      throw Exception('Something went wrong');
    }
  }

  getCustomerById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
  
    final response = await http.get(
      '${ApiEndpoint.customer}/$id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '102'// '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['customer'];
      return CustomerModel.fromJson(decodedResponse);
    // } else if (response.statusCode == 400) {
      
    // } else if (response.statusCode == 401) {
      
    // } else if (response.statusCode == 403) {
      
    // } else if (response.statusCode == 404) {
      
    } else {
      throw Exception('Something went wrong');
    }
  }
}