import 'package:daily_basket_sellers/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationBloc {
  AuthRepository _authRepository = AuthRepository();

  signIn(String emailId, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    var signInResponse = await _authRepository.signIn(emailId, password);
    prefs.setString('token', signInResponse['data']['token']);
    return signInResponse; 
  }

  signOut() async {
    var response = await _authRepository.signOut();
    return response;
  }

  void dispose() {
  }
}