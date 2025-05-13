import 'package:flutter/material.dart';
import 'index.dart';
import 'login_screen_flow/login_screen/login_screen_widget.dart';
import 'login_screen_flow/register_screen/register_screen_widget.dart';
import 'login_screen_flow/forgot_password_screen/forget_password_widget.dart';
import 'login_screen_flow/otp_screen/otp_screen.widget.dart';
import 'library_appstate/library_screen_widget.dart';
import 'library_appstate/digital_classes_screen/digital_classes_screen_widget.dart';

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
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegistrationPage(),
        AppRoutes.forgotPassword: (context) => const ResetPasswordScreen(),
        AppRoutes.dashboard: (context) => const LibraryScreen(),
        '/digital-classes': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
          return CourseListPage(
            subject: args['subject'] ?? '',
            subjectImage: args['image'] ?? '',
          );
        },
        '/books': (context) => const LibraryScreen(),
        '/profile': (context) => const LibraryScreen(),
        '/settings': (context) => const LibraryScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.otpVerification) {
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
              'assets/images/VS_paze icon.png',
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
