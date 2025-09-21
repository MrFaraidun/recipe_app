import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'custom_button.dart';

class CookingTimer extends StatefulWidget {
  final int durationMinutes;
  final VoidCallback onTimerComplete;

  const CookingTimer({
    super.key,
    required this.durationMinutes,
    required this.onTimerComplete,
  });

  @override
  State<CookingTimer> createState() => _CookingTimerState();
}

class _CookingTimerState extends State<CookingTimer>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _remainingSeconds = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationMinutes * 60;
    _animationController = AnimationController(
      duration: Duration(seconds: _remainingSeconds),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Cooking Timer',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                CircularProgressIndicator(
                  value: _animation.value,
                  strokeWidth: 8,
                  backgroundColor: AppColors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                Center(
                  child: Text(
                    _formatTime(_remainingSeconds),
                    style: AppTextStyles.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: _isRunning ? 'Pause' : 'Start',
                onPressed: _toggleTimer,
                backgroundColor: _isRunning ? Colors.orange : AppColors.primary,
                textColor: Colors.white,
                height: 40,
                borderradius: 20,
              ),
              CustomButton(
                text: 'Reset',
                onPressed: _resetTimer,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                height: 40,
                borderradius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _animationController.stop();
      } else {
        _animationController.forward();
      }
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _remainingSeconds = widget.durationMinutes * 60;
      _animationController.reset();
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
