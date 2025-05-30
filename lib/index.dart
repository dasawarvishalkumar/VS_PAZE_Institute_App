import 'package:flutter/material.dart';
import 'login_screen_flow/login_screen/login_screen_widget.dart';
import 'login_screen_flow/register_screen/register_screen_widget.dart';
import 'login_screen_flow/forgot_password_screen/forget_password_widget.dart';
import 'login_screen_flow/otp_screen/otp_screen.widget.dart';
import 'library_appstate/library_screen_widget.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String dashboard = '/dashboard';
  static const String books = '/books';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegistrationPage(),
      forgotPassword: (context) => const ResetPasswordScreen(),
      dashboard: (context) => const LibraryScreen(),
      books: (context) => const LibraryScreen(), // Placeholder for books screen
      profile: (context) => const LibraryScreen(), // Placeholder for profile screen
      settings: (context) => const LibraryScreen(), // Placeholder for settings screen
      otpVerification: (context) {
        final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
        return OTPVerificationScreen(
          mobileNumber: args['mobileNumber'] ?? '',
          newPassword: args['newPassword'] ?? '',
        );
      },
    };
  }
} 