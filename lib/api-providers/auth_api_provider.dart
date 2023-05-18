import 'dart:convert';
import 'dart:io';

import 'package:daily_basket_sellers/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiProvider {
  signIn(String emailId, String password) async {  
    final response = await http.post(
      ApiEndpoint.signIn,
      headers: {
        'account_id': '1',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode({
        'email_id': emailId,
        'password': password,
      })
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 403) {
      throw Exception('Incorrect password');
    } else if (response.statusCode == 404) {
      throw Exception('User does not exist');
    } else {
      throw Exception('Something went wrong');
    }
  }

  signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token');
    final response = await http.post(
      ApiEndpoint.signIn,
      headers: {
        'account_id': '1',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token,
      });

    return response;
  }
}