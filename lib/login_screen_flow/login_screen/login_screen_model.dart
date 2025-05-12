// import 'package:http/http.dart' as http;
// import 'dart:convert';

class LoginScreenModel {
  // static const String _baseUrl = 'http://192.168.0.245:3000/api';

  Future<LoginResult> login({
    required String enrollId,
    required String password,
  }) async {
    // Simulate frontend-only validation
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate a short delay

    if (enrollId.isEmpty || password.isEmpty) {
      return LoginResult(
        success: false,
        errorMessage: 'Enroll ID and password cannot be empty',
      );
    }

    // You can add more frontend-only checks here if needed

    return LoginResult(
      success: true,
      enrollId: enrollId,
    );
  }
}

class LoginResult {
  final bool success;
  final String? enrollId;
  final String? errorMessage;

  LoginResult({
    required this.success,
    this.enrollId,
    this.errorMessage,
  });
}
