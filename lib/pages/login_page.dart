import 'package:flutter/material.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/custom_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // Title
              Text(
                'Welcome Back!',
                style: AppTextStyles.h1.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Please enter your account here',
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Email input
              CustomTextField(
                label: '',
                hintText: 'Email or phone number',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                borderColor: Colors.grey[300]!,
                focusedBorderColor: AppColors.primary,
                borderradius: 24,
                textColor: Colors.black,
                iconColor: Colors.grey[600]!,
                focusedIconColor: AppColors.primary,
              ),

              const SizedBox(height: 20),

              // Password input
              CustomTextField(
                label: '',
                hintText: 'Password',
                icon: Icons.lock_outline,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.grey[600],
                  ),
                ),
                obscureText: _obscurePassword,
                borderColor: Colors.grey[300]!,
                focusedBorderColor: AppColors.primary,
                borderradius: 24,
                textColor: Colors.black,
                iconColor: Colors.grey[600]!,
                focusedIconColor: AppColors.primary,
              ),

              const SizedBox(height: 16),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/password-recovery');
                  },
                  child: Text(
                    'Forgot password?',
                    style: AppTextStyles.body.copyWith(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Login button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  height: 56,
                  borderradius: 24,
                ),
              ),

              // Or continue with
              Text(
                'Or continue with',
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 20),

              // Google button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  onPressed: () {
                    print("Google Login pressed");
                  },
                  backgroundColor: const Color(0xFFFF4444),
                  height: 56,
                  borderradius: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'G',
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Google',
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sign up prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have any account? ",
                    style: AppTextStyles.body.copyWith(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
