import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, 'Comments'),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10.r),
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'User Name : Mohammed Waleed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const HeightSpacer(height: 20),
                const Text(
                  'User Comment : This is a sample comment.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const HeightSpacer(height: 20),
                const Text(
                  'User Rate : This is a sample rate.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const HeightSpacer(height: 70),
                const Text(
                  'Reply : This is a sample reply.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const HeightSpacer(height: 50),
                const CustomTextField(labelText: 'Reply to Comment', maxLines: 5),
                const HeightSpacer(height: 50),
                Center(
                  child: SizedBox(
                    width: 200.w,
                    height: 70.h,
                    child: CustomButton(
                      textButton: 'Reply...',
                      onPressed: () {
                        // Handle reply action
                      },
                    ),
                  ),
                ),
                const HeightSpacer(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
