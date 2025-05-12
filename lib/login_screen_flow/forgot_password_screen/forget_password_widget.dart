import 'package:flutter/material.dart';
import 'dart:ui';
import '../otp_screen/otp_screen.widget.dart';
import 'forget_password_model.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController StudentNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _requestOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = await ResetPasswordModel.requestOtp(
        mobileNumber: StudentNumberController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerificationScreen(
              mobileNumber: StudentNumberController.text.trim(),
              newPassword: newPasswordController.text.trim(),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C853),
      body: Column(
        children: [
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/forgot_password.png',
            height: 230,
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFE0E5EC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildPasswordField(
                        'Enter New Password',
                        newPasswordController,
                        'Enter New Password',
                        _obscureText,
                        (value) {
                          setState(() {
                            _obscureText = value;
                          });
                        },
                      ),
                      const Text(
                        'Password must be 8+ characters with a number & symbol',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      _buildPasswordField(
                        'Confirm Password',
                        confirmPasswordController,
                        'Re-Enter Password',
                        _obscureConfirmText,
                        (value) {
                          setState(() {
                            _obscureConfirmText = value;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      _buildTextField(
                        'Student Number',
                        StudentNumberController,
                        'Enter Student Number',
                        TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _requestOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF97C8D6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text(
                                  'Send OTP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    String hint,
    bool obscure,
    Function(bool) toggle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () => toggle(!obscure),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label == 'Confirm Password' &&
              value != newPasswordController.text) {
            return 'Passwords do not match';
          }
          if (label == 'Enter New Password' && value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
    TextInputType keyboardType,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label == 'Student Number' &&
              (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value))) {
            return 'Please enter a valid 10-digit number';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    StudentNumberController.dispose();
    super.dispose();
  }
}