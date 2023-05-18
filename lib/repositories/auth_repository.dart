import 'package:daily_basket_sellers/api-providers/auth_api_provider.dart';

class AuthRepository {
  AuthApiProvider _authApiProvider = AuthApiProvider();

  signIn(String emailId, String password) async => await _authApiProvider.signIn(emailId, password);

  signOut() async => await _authApiProvider.signOut();
}