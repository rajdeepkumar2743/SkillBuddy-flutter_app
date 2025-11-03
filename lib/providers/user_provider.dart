import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _userEmail = '';
  String _userPassword = '';

  String get userEmail => _userEmail;
  String get userPassword => _userPassword;

  // Update both email and password
  void setUser(String email, String password) {
    _userEmail = email;
    _userPassword = password;
    notifyListeners();
  }

  // Update only email
  void setEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  // Update only password
  void setPassword(String password) {
    _userPassword = password;
    notifyListeners();
  }

  // Clear user information on logout
  void logout() {
    _userEmail = '';
    _userPassword = '';
    notifyListeners();
  }
}
