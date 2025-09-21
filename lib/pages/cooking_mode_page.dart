import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/cooking_timer.dart';
import '../widgets/cooking_step_card.dart';
import '../models/recipe.dart';

class CookingModePage extends StatefulWidget {
  final Recipe recipe;

  const CookingModePage({super.key, required this.recipe});

  @override
  State<CookingModePage> createState() => _CookingModePageState();
}

class _CookingModePageState extends State<CookingModePage> {
  late PageController _pageController;
  int _currentStep = 0;
  int _durationMinutes = 30;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _durationMinutes = _parseDuration(widget.recipe.duration);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _parseDuration(String duration) {
    if (duration.contains('<10')) return 5;
    if (duration.contains('10-30')) return 20;
    if (duration.contains('30-60')) return 45;
    if (duration.contains('>60')) return 90;
    return 30;
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.recipe.steps ?? [];

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cooking Mode',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt, color: AppColors.primary),
            onPressed: _showAllSteps,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: AppColors.primary),
            onPressed: _showIngredients,
          ),
        ],
      ),
      body: Column(
        children: [
          // Timer Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: CookingTimer(
              durationMinutes: _durationMinutes,
              onTimerComplete: _onTimerComplete,
            ),
          ),

          // Progress Indicator
          _buildProgressIndicator(steps.length),

          // Steps
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: CookingStepCard(
                    step: steps[index],
                    stepNumber: index + 1,
                    totalSteps: steps.length,
                    isCurrentStep: index == _currentStep,
                    onNext: index < steps.length - 1 ? _nextStep : null,
                    onPrevious: index > 0 ? _previousStep : null,
                  ),
                );
              },
            ),
          ),

          // Navigation Controls
          _buildNavigationControls(steps.length),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(int totalSteps) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            'Step ${_currentStep + 1} of $totalSteps',
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / totalSteps,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationControls(int totalSteps) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Previous',
              onPressed: _currentStep > 0 ? _previousStep : null,
              backgroundColor: _currentStep > 0
                  ? Colors.grey
                  : Colors.grey.withOpacity(0.3),
              textColor: Colors.white,
              height: 48,
              borderradius: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: _currentStep == totalSteps - 1 ? 'Finish' : 'Next',
              onPressed: _currentStep < totalSteps - 1
                  ? _nextStep
                  : _finishCooking,
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              height: 48,
              borderradius: 24,
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < (widget.recipe.steps?.length ?? 0) - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showAllSteps() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('All Steps'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.recipe.steps?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(widget.recipe.steps![index]),
                onTap: () {
                  Navigator.pop(context);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showIngredients() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ingredients'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.recipe.ingredients?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(widget.recipe.ingredients![index]),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _onTimerComplete() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cooking time is up!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _finishCooking() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cooking Complete!'),
        content: const Text('Congratulations! You have completed the recipe.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
