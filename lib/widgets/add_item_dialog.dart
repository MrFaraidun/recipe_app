import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/CustomTextField.dart';

class AddItemDialog extends StatefulWidget {
  final String? initialValue;
  final String title;

  const AddItemDialog({super.key, this.initialValue, this.title = 'Add Item'});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: AppTextStyles.h3.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
      content: CustomTextField(
        label: 'Item name',
        controller: _controller,
        icon: Icons.shopping_cart,
        borderColor: AppColors.border,
        focusedBorderColor: AppColors.primary,
        borderradius: 12,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          ),
        ),
        CustomButton(
          text: 'Add',
          onPressed: _controller.text.isNotEmpty ? _addItem : null,
          backgroundColor: AppColors.primary,
          textColor: Colors.white,
          height: 36,
          borderradius: 18,
        ),
      ],
    );
  }

  void _addItem() {
    Navigator.pop(context, _controller.text.trim());
  }
}
