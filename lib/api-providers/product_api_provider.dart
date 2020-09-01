import 'dart:convert';
import 'dart:io';

import 'package:daily_basket_sellers/api_endpoints.dart';
import 'package:daily_basket_sellers/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductApiProvider {
  final url = '/products';

  getProductsCount(int status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
    String url = '${ApiEndpoint.product}/count';

    if (status != null) {
      url += '?status=$status';
    }
  
    final response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['count'];
      return decodedResponse;
    // } else if (response.statusCode == 400) {
      
    // } else if (response.statusCode == 401) {
      
    // } else if (response.statusCode == 403) {
      
    // } else if (response.statusCode == 404) {
      
    } else {
      throw Exception('Something went wrong');
    }
  }

  getProducts(int pageNo, int pageSize, String sortBy, String sortOrder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
  
    final response = await http.get(
      '${ApiEndpoint.product}?page_no=$pageNo&page_size=$pageSize&sort_by=$sortBy&sort_order=$sortOrder',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['products'];
      return decodedResponse..map<ProductModel>((eachProductObject) => ProductModel.fromJson(eachProductObject)).toList();
    // } else if (response.statusCode == 400) {
      
    // } else if (response.statusCode == 401) {
      
    // } else if (response.statusCode == 403) {
      
    // } else if (response.statusCode == 404) {
      
    } else {
      throw Exception('Something went wrong');
    }
  }

  getProductById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
  
    final response = await http.get(
      '${ApiEndpoint.product}/$id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'account_id': '1',
        'user_id': '$userId',
        'session_id': '$sessionId'
      }
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['data']['product'];
      return ProductModel.fromJson(decodedResponse);
    } else if (response.statusCode == 400) {
      throw Exception('Validation Error');
    } else if (response.statusCode == 401) {
      
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorised');
    } else if (response.statusCode == 404) {
      throw Exception('Product not found');
    } else {
      throw Exception('Something went wrong');
    }
  }

  addProduct(int categoryId, String name, String description, int baseQuantity, String unit,
    num price, int quantity, String image) async {
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
      'price': '$price',
      'quantity': '$quantity',
      'unit': unit,
      'base_quantity': '$baseQuantity',
      'category_id': '$categoryId',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiEndpoint.product));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.fields.addAll(fields);

    var response = await request.send();
    return response;
  }

  updateProduct(int productId,int categoryId, String name, String description, int baseQuantity, String unit,
    num price, int quantity, String image) async {
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
      'price': '$price',
      'quantity': '$quantity',
      'unit': unit,
      'base_quantity': '$baseQuantity',
      'category_id': '$categoryId',
    };

    var request =
        http.MultipartRequest('PUT', Uri.parse('${ApiEndpoint.product}/$productId'));
    request.headers.addAll(headers);
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image));
    }
    request.fields.addAll(fields);

    var response = await request.send();
    return response;
  }
}