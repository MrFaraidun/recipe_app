import 'package:flutter/material.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

class UploadSuccessPage extends StatelessWidget {
  const UploadSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 60)),
              SizedBox(height: height * 0.02),
              Text(
                'Upload Success',
                style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Your recipe has been uploaded, you can see it on your profile',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.04),
              CustomButton(
                text: 'Back to Home',
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
