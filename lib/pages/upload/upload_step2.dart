import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/CustomTextField.dart';
import 'upload_success.dart';

class UploadStep2 extends StatelessWidget {
  const UploadStep2({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox(
          width: 80,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        ),
        title: const Text('2/2', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Enter ingredient',
              icon: Icons.local_dining,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: 'Enter ingredient',
              icon: Icons.local_dining,
            ),
            SizedBox(height: height * 0.015),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Ingredient'),
            ),
            SizedBox(height: height * 0.03),
            Text('Steps', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text('Step 1', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            CustomTextField(
              label: 'Tell a little about your food',
              icon: Icons.notes,
              maxLines: 3,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt, color: Colors.grey),
            ),
            SizedBox(height: height * 0.04),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Back',
                    backgroundColor: Colors.white,
                    textColor: AppColors.primary,
                    borderColor: AppColors.primary,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: CustomButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UploadSuccessPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
