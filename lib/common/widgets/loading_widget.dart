import 'package:bookme/common/string_constant.dart';
import 'package:flutter/material.dart';

import '../app_color.dart';
import '../app_text_style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints){
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: AppColors.greyColor.withOpacity(0.05),
            child: Center(
                child: Container(
                  width: constraints.maxWidth * 0.8,
                  height: constraints.maxHeight * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        kLoading,
                        style: AppTextStyle.largeTextBold,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05,),
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                )
            ),
          );
        }
    );
  }
}
