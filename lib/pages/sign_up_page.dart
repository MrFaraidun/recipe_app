import 'package:flutter/material.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/custom_button.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get hasSixChars => passwordController.text.length >= 8;
  bool get hasNumber => passwordController.text.contains(RegExp(r'\d'));
  bool get hasUppercase => passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get hasLowercase => passwordController.text.contains(RegExp(r'[a-z]'));
  bool get passwordsMatch =>
      passwordController.text == confirmController.text &&
      confirmController.text.isNotEmpty;
  bool get hasValidUsername => usernameController.text.length >= 3;
  bool get hasValidEmail =>
      emailController.text.contains('@') && emailController.text.isNotEmpty;

  bool get isFormValid =>
      hasValidEmail &&
      hasValidUsername &&
      hasSixChars &&
      hasNumber &&
      hasUppercase &&
      hasLowercase &&
      passwordsMatch;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight - 40),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // Title
                  Text(
                    'Welcome!',
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

                  const SizedBox(height: 40),

                  // Email input
                  CustomTextField(
                    label: '',
                    controller: emailController,
                    hintText: 'Email or phone number',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                    borderColor: emailController.text.isEmpty
                        ? Colors.grey[300]!
                        : (hasValidEmail ? AppColors.primary : Colors.red),
                    focusedBorderColor: AppColors.primary,
                    borderWidth:
                        hasValidEmail && emailController.text.isNotEmpty
                        ? 2
                        : 1,
                    borderradius: 24,
                    textColor: Colors.black,
                    iconColor: Colors.grey[600]!,
                    focusedIconColor: AppColors.primary,
                    errorText: emailController.text.isNotEmpty && !hasValidEmail
                        ? 'Please enter a valid email'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Username input
                  CustomTextField(
                    label: '',
                    controller: usernameController,
                    hintText: 'Username',
                    icon: Icons.alternate_email,
                    onChanged: (_) => setState(() {}),
                    borderColor: usernameController.text.isEmpty
                        ? Colors.grey[300]!
                        : (hasValidUsername ? AppColors.primary : Colors.red),
                    focusedBorderColor: AppColors.primary,
                    borderWidth:
                        hasValidUsername && usernameController.text.isNotEmpty
                        ? 2
                        : 1,
                    borderradius: 24,
                    textColor: Colors.black,
                    iconColor: Colors.grey[600]!,
                    focusedIconColor: AppColors.primary,
                    errorText:
                        usernameController.text.isNotEmpty && !hasValidUsername
                        ? 'Username must be at least 3 characters'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Password input
                  CustomTextField(
                    label: '',
                    controller: passwordController,
                    hintText: '••••••••',
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
                    onChanged: (_) => setState(() {}),
                    borderColor: AppColors.primary,
                    focusedBorderColor: AppColors.primary,
                    borderWidth: 2,
                    borderradius: 24,
                    textColor: Colors.black,
                    iconColor: Colors.grey[600]!,
                    focusedIconColor: AppColors.primary,
                  ),

                  const SizedBox(height: 24),

                  // Password requirements
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Password must contain:',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildRequirement('At least 8 characters', hasSixChars),
                      const SizedBox(height: 12),
                      _buildRequirement('Contains a number', hasNumber),
                      const SizedBox(height: 12),
                      _buildRequirement(
                        'Contains uppercase letter',
                        hasUppercase,
                      ),
                      const SizedBox(height: 12),
                      _buildRequirement(
                        'Contains lowercase letter',
                        hasLowercase,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Confirm Password input
                  CustomTextField(
                    label: '',
                    controller: confirmController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      child: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey[600],
                      ),
                    ),
                    obscureText: _obscureConfirmPassword,
                    onChanged: (_) => setState(() {}),
                    borderColor: passwordsMatch
                        ? AppColors.primary
                        : Colors.grey[300]!,
                    focusedBorderColor: AppColors.primary,
                    borderWidth: passwordsMatch ? 2 : 1,
                    borderradius: 24,
                    textColor: Colors.black,
                    iconColor: Colors.grey[600]!,
                    focusedIconColor: AppColors.primary,
                    errorText:
                        confirmController.text.isNotEmpty && !passwordsMatch
                        ? 'Passwords do not match'
                        : null,
                  ),

                  if (confirmController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Icon(
                            passwordsMatch ? Icons.check_circle : Icons.error,
                            color: passwordsMatch
                                ? AppColors.primary
                                : Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            passwordsMatch
                                ? 'Passwords match'
                                : 'Passwords do not match',
                            style: AppTextStyles.body.copyWith(
                              color: passwordsMatch
                                  ? AppColors.primary
                                  : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const Spacer(),

                  // Sign Up button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 30),
                    child: CustomButton(
                      text: 'Sign Up',
                      onPressed: isFormValid
                          ? () {
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          : null,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                      height: 56,
                      borderradius: 24,
                    ),
                  ),

                  // Login prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppTextStyles.body.copyWith(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isValid) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isValid ? AppColors.primary : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: isValid
              ? const Icon(Icons.check, color: Colors.white, size: 14)
              : null,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTextStyles.body.copyWith(
            fontSize: 14,
            color: isValid ? const Color(0xFF1A1A1A) : Colors.grey[600],
            fontWeight: isValid ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
