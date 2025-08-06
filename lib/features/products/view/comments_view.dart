import 'package:admin_dashboard/core/functions/custom_app_bar.dart';
import 'package:admin_dashboard/core/widgets/custom_loading.dart';
import 'package:admin_dashboard/core/widgets/custom_text_field.dart';
import 'package:admin_dashboard/core/widgets/height_spacer.dart';
import 'package:admin_dashboard/features/auth/widgets/custom_button.dart';
import 'package:admin_dashboard/features/products/cubit/comments_and_reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentsView extends StatelessWidget {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsAndReviewsCubit, CommentsAndReviewsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CommentsAndReviewsCubit cubit = context.read<CommentsAndReviewsCubit>();
        return Scaffold(
          appBar: buildCustomAppBar(context, 'Comments View'),
          body:
              state is GetCommentsLoading
                  ? const CustomLoading()
                  : cubit.userComments.isEmpty
                  ? Center(
                    child: Text(
                      "No Comments in this Product",
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : ListView.builder(
                    itemCount: cubit.userComments.length,
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
                            Text(
                              'User Name : ${cubit.userComments[index].userName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const HeightSpacer(height: 20),
                            Text(
                              'User Comment : ${cubit.userComments[index].comment ?? "No Comment Yet"}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // const HeightSpacer(height: 20),
                            // const Text(
                            //   'User Rate : This is a sample rate.',
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // ),
                            const HeightSpacer(height: 70),
                            Visibility(
                              visible:
                                  cubit.userComments[index].replay == null
                                      ? false
                                      : true,
                              child: Text(
                                'Reply : ${cubit.userComments[index].replay}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const HeightSpacer(height: 50),
                            const CustomTextField(
                              labelText: 'Reply to Comment',
                              maxLines: 5,
                            ),
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
      },
    );
  }
}
