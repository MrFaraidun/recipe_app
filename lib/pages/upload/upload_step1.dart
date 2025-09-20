import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/CustomTextField.dart';
import 'upload_step2.dart';

class UploadStep1 extends StatefulWidget {
  const UploadStep1({super.key});

  @override
  State<UploadStep1> createState() => _UploadStep1State();
}

class _UploadStep1State extends State<UploadStep1> {
  double cookingTime = 30;

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
                overflow: TextOverflow.visible, // just in case
              ),
            ),
          ),
        ),
        title: const Text('1/2', style: TextStyle(color: Colors.black)),
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
            GestureDetector(
              onTap: () {},
              child: Container(
                height: height * 0.22,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Add Cover Photo',
                        style: TextStyle(color: Colors.black87),
                      ),
                      Text(
                        '(up to 12 Mb)',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            CustomTextField(label: 'Food Name', icon: Icons.fastfood),

            SizedBox(height: height * 0.025),
            CustomTextField(
              label: 'Description',
              icon: Icons.description,
              maxLines: 3,
            ),
            SizedBox(height: height * 0.025),
            Text('Cooking Duration (in minutes)', style: AppTextStyles.h3),
            Slider(
              value: cookingTime,
              min: 0,
              max: 60,
              divisions: 3,
              label: cookingTime == 0
                  ? '<10'
                  : cookingTime == 60
                  ? '>60'
                  : cookingTime.toString(),
              activeColor: AppColors.primary,
              onChanged: (val) => setState(() => cookingTime = val),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('<10', style: TextStyle(color: Colors.grey)),
                Text('30', style: TextStyle(color: Colors.grey)),
                Text('>60', style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: height * 0.04),
            CustomButton(
              text: 'Next',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadStep2()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
