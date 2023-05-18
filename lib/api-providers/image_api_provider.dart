import 'dart:async';
import 'dart:io';

import 'package:daily_basket_sellers/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ImageApiProvider {
  uploadImage(image, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    int userId = prefs.getInt('user_id');
    int sessionId = prefs.getInt('session_id');
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/json',
      'account_id': '1',
      'user_id': '1',
      'session_id': '$sessionId',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiEndpoint.uploadImage));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.fields['type'] = '$type';

    var response = request.send().asStream();
    StreamConsumer streamConsumer;

    response?.pipe(streamConsumer);
  }
}
