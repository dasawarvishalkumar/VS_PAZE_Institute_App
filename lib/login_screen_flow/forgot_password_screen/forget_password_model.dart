class ResetPasswordModel {
  static Future<Map<String, dynamic>> requestOtp({
    required String mobileNumber,
    required String newPassword,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Frontend validation
    if (mobileNumber.isEmpty || newPassword.isEmpty) {
      return {
        'success': false,
        'message': 'Please fill in all fields',
      };
    }

    if (mobileNumber.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
      return {
        'success': false,
        'message': 'Please enter a valid 10-digit mobile number',
      };
    }

    if (newPassword.length < 8) {
      return {
        'success': false,
        'message': 'Password must be at least 8 characters',
      };
    }

    if (!RegExp(r'[0-9]').hasMatch(newPassword) ||
        !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPassword)) {
      return {
        'success': false,
        'message': 'Password must contain a number and a special character',
      };
    }

    // Simulate successful OTP request
    return {
      'success': true,
      'message': 'OTP sent successfully to $mobileNumber',
    };
  }
}
