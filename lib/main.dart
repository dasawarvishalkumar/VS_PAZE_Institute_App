import 'package:flutter/material.dart';
import 'index.dart';
import 'login_screen_flow/login_screen/login_screen_widget.dart';
import 'login_screen_flow/register_screen/register_screen_widget.dart';
import 'login_screen_flow/forgot_password_screen/forget_password_widget.dart';
import 'login_screen_flow/otp_screen/otp_screen.widget.dart';

void main() {
  runApp(const VspazeApp());
}

class VspazeApp extends StatelessWidget {
  const VspazeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VS Paze - Parent Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        fontFamily: 'Arial',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationPage(),
        '/forgot-password': (context) => const ResetPasswordScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/otp-verification') {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          return MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              mobileNumber: args['mobileNumber'] ?? '',
              newPassword: args['newPassword'] ?? '',
            ),
          );
        }
        return null;
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/vspaze_logo.png',
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 24),
            const Text(
              'Vspaze',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'INSTITUTIONS',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFE67E52),
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
