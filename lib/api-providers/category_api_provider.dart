import 'dart:convert';
import 'dart:io';

import 'package:daily_basket_sellers/api_endpoints.dart';
import 'package:daily_basket_sellers/exceptions/unauthorized_exception.dart';
import 'package:daily_basket_sellers/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryApiProvider {
  getCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
  
    final response = await http.get(
      ApiEndpoint.category,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '102'// '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['categories'];
      var categoryList = decodedResponse..map<CategoryModel>((eachCategoryObject) => CategoryModel.fromJson(eachCategoryObject)).toList();
      return categoryList;
    // } else if (response.statusCode == 400) {
      
    // } else if (response.statusCode == 401) {
      
    // } else if (response.statusCode == 403) {
      
    // } else if (response.statusCode == 404) {
      
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<CategoryModel> getCategoryById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
  
    final response = await http.get(
      '${ApiEndpoint.category}/$id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['category'];
      return CategoryModel.fromJson(decodedResponse);
    // } else if (response.statusCode == 400) {
      
    // } else if (response.statusCode == 401) {
      
    // } else if (response.statusCode == 403) {
      
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Something went wrong');
    }
  }

  addCategory(String name, String description, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: token,
      // HttpHeaders.acceptHeader: 'application/json',
      'account_id': '1',
      'user_id': '1',
      'session_id': '$sessionId',
    };

    Map<String, String> fields = {
      'name': name,
      'description': description, 
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiEndpoint.category));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.fields.addAll(fields);

    var response = await request.send();
    return response;
  }

  updateCategory(int id, String name, String description, String image) async {
    ('Category Api provider');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: token,
      // HttpHeaders.acceptHeader: 'application/json',
      'account_id': '1',
      'user_id': '1',
      'session_id': '$sessionId',
    };

    Map<String, String> fields = {
      'name': name,
      'description': description, 
    };

    var request =
        http.MultipartRequest('PUT', Uri.parse('${ApiEndpoint.category}/$id'));
    request.headers.addAll(headers);
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }
    request.fields.addAll(fields);

    var response = await request.send();
    return response;
  }

  updateCategoryStatus(int id, int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
    
  
    final response = await http.put(
      '${ApiEndpoint.category}/$id?enable=${status == 1}',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['category'];
      return CategoryModel.fromJson(decodedResponse);
    } else if (response.statusCode == 400) {
      throw UnauthorizedException('Session expired');
    } else if (response.statusCode == 401) {
      
    } else if (response.statusCode == 403) {
      
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Something went wrong');
    }
  }

  deleteCategory(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');

    final response = await http.delete(
      '${ApiEndpoint.category}/$id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['category'];
      return CategoryModel.fromJson(decodedResponse);
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