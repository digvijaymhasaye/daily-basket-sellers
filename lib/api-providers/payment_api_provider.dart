import 'dart:convert';
import 'dart:io';

import 'package:daily_basket_sellers/exceptions/unauthorized_exception.dart';
import 'package:daily_basket_sellers/models/payment_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api_endpoints.dart';

class PaymentApiProvider {
  getPaymentsList(int pageNo, int pageSize, String sortBy, String sortOrder,
      int status, bool includeCustomerDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var response = await http.get(
        '${ApiEndpoint.payment}?page_no=$pageNo&page_size=$pageSize&sort_by=$sortBy&sort_order=$sortOrder&include_customer=$includeCustomerDetails',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    var decodedResponse = json.decode(response.body)['data']['payments'];
    if (response.statusCode == 200) {
      return decodedResponse..map<PaymentModel>((eachPaymentJson) => PaymentModel.fromJson(eachPaymentJson)).toList();
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Session expired');
    } else if (response.statusCode == 500) {
      // TODO throw server error exception
    }
  }

  getPaymentStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var response = await http.get(
        '${ApiEndpoint.payment}/stats',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    var decodedResponse = json.decode(response.body)['data']['stats'];
    if (response.statusCode == 200) {
      return decodedResponse;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Session expired');
    } else if (response.statusCode == 500) {
      // TODO throw server error exception
    }
  }

  getPaymentCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var response = await http.get(
        '${ApiEndpoint.payment}/count',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    var decodedResponse = json.decode(response.body)['data']['count'];
    if (response.statusCode == 200) {
      return decodedResponse;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Session expired');
    } else if (response.statusCode == 500) {
      // TODO throw server error exception
    }
  }

  getPaymentById(int paymentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var response = await http.get(
        '${ApiEndpoint.payment}/$paymentId',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        });
    var decodedResponse = json.decode(response.body)['data']['payment'];
    if (response.statusCode == 200) {
      return PaymentModel.fromJson(decodedResponse);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Session expired');
    } else if (response.statusCode == 404) {
      // TODO throw server error exception
    } else {

    }
  }
}
