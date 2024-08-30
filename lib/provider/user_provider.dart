import 'package:flutter/material.dart';
import '../backend/userdata/user_data.dart';

class UserProvider with ChangeNotifier {
  late Map<String, dynamic> _user;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic> get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final UserService _userService = UserService();

  Future<void> fetchUser(String userId, String role) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _user = (await _userService.fetchUserById(userId, role));
      if (_user == null) {
        _error = 'User not found';
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
