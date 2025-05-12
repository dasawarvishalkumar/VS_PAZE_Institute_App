class OTPVerificationModel {
  static Future<Map<String, dynamic>> verifyOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (otp.length != 4) {
      return {
        'success': false,
        'message': 'Please enter a valid 4-digit OTP',
      };
    }

    // For frontend, accept any 4-digit OTP as valid
    return {
      'success': true,
      'message': 'OTP verified successfully!',
    };
  }
}
