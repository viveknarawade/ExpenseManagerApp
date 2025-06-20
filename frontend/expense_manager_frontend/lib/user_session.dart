import 'package:expense_manager_frontend/model/user.dart';

class UserSession {
  static User? _currentUser;

  static void setUser(User user) {
    _currentUser = user;
  }

  static User? get user => _currentUser;
}
