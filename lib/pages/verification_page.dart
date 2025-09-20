import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/widgets/CustomTextField.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage>
    with TickerProviderStateMixin {
  final List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  late AnimationController _timerController;
  late Animation<int> _timerAnimation;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: const Duration(seconds: 192), // 3:12
      vsync: this,
    );
    _timerAnimation = IntTween(begin: 192, end: 0).animate(_timerController);
    _timerController.forward();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timerController.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

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
                'Check your email',
                style: AppTextStyles.h1.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'We\'ve sent the code to your email',
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // OTP Input boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: index == 3
                            ? AppColors.primary
                            : Colors.grey[300]!,
                        width: index == 3 ? 2 : 1,
                      ),
                    ),
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTextStyles.h2.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          focusNodes[index - 1].requestFocus();
                        }
                        setState(() {});
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // Timer
              AnimatedBuilder(
                animation: _timerAnimation,
                builder: (context, child) {
                  return Text(
                    'code expires in: ${_formatTime(_timerAnimation.value)}',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),

              const Spacer(),

              // Verify/Next button
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomButton(
                  text: _isCodeComplete() ? 'Next' : 'Verify',
                  onPressed: _isCodeComplete()
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NewPasswordPage(),
                            ),
                          );
                        }
                      : null,
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  height: 56,
                  borderradius: 24,
                ),
              ),

              // Send again button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CustomButton(
                  text: 'Send again',
                  onPressed: () {
                    _timerController.reset();
                    _timerController.forward();
                  },
                  backgroundColor: Colors.transparent,
                  textColor: Colors.grey[700]!,
                  borderColor: Colors.grey[300]!,
                  borderWidth: 1,
                  height: 56,
                  borderradius: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isCodeComplete() {
    return controllers.every((controller) => controller.text.isNotEmpty);
  }
}

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  bool get hasSixChars => passwordController.text.length >= 6;
  bool get hasNumber => passwordController.text.contains(RegExp(r'\d'));

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
                'Reset your password',
                style: AppTextStyles.h1.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Please enter your new password',
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // New password input
              CustomTextField(
                label: '',
                controller: passwordController,
                hintText: '••••••••',
                icon: Icons.lock_outline,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
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
                  _buildRequirement('Atleast 6 characters', hasSixChars),
                  const SizedBox(height: 12),
                  _buildRequirement('Contains a number', hasNumber),
                ],
              ),

              const Spacer(),

              // Done button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CustomButton(
                  text: 'Done',
                  onPressed: hasSixChars && hasNumber
                      ? () {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      : null,
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  height: 56,
                  borderradius: 24,
                ),
              ),
            ],
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
