import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreenModel {
  Future<RegisterResult> register({
    required String studentFirstName,
    required String studentLastName,
    required String className,
    required String dob,
    required String fatherName,
    required String motherName,
    required String email,
    required String enrollId,
    required String mobileNumber,
    required String password,
  }) async {
    // Simulate frontend-only validation
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate a short delay

    // Basic frontend validation
    if (studentFirstName.isEmpty ||
        studentLastName.isEmpty ||
        className.isEmpty ||
        dob.isEmpty ||
        fatherName.isEmpty ||
        motherName.isEmpty ||
        email.isEmpty ||
        enrollId.isEmpty ||
        mobileNumber.isEmpty ||
        password.isEmpty) {
      return RegisterResult(
        success: false,
        errorMessage: 'All fields are required',
      );
    }

    // Email validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return RegisterResult(
        success: false,
        errorMessage: 'Please enter a valid email address',
      );
    }

    // Mobile number validation
    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobileNumber)) {
      return RegisterResult(
        success: false,
        errorMessage: 'Please enter a valid 10-digit mobile number',
      );
    }

    // Password validation
    if (password.length < 8 ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return RegisterResult(
        success: false,
        errorMessage: 'Password must be at least 8 characters with a number and special character',
      );
    }

    return RegisterResult(success: true);
  }
}

class RegisterResult {
  final bool success;
  final String? errorMessage;

  RegisterResult({
    required this.success,
    this.errorMessage,
  });
}
