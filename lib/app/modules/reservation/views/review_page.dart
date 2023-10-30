import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:bookme/common/widgets/custom_text_field.dart';
import 'package:bookme/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controller/reservations_controller.dart';

class ReviewPage extends GetView<ReservationsController> {

  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context,constraints){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                color: AppColors.primaryColor
                            ),
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(top: 10,bottom: 5.0),
                            child: Icon(Icons.arrow_back_ios_outlined,color: AppColors.whiteColor,),
                          ),
                        ),
                        Text(kRateYourExperience,style: AppTextStyle.xLargeTextBold.copyWith(
                            color: AppColors.blackColor
                        ),),
                        Text(kWithOurProducts,style: AppTextStyle.mediumTextNormal.copyWith(
                            color: AppColors.greyColor
                        ),),
                        SizedBox(height: constraints.maxHeight * 0.05,),
                        Text(kWouldYouRate,style: AppTextStyle.mediumTextNormal.copyWith(
                            color: AppColors.greyColor
                        ),),
                        const SizedBox(height: 10,),
                        Obx(()=>RatingBar.builder(
                          initialRating: controller.ratingStars.value,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: constraints.maxWidth * 0.07,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(Icons.star,
                            color: AppColors.rattingColor,
                          ),
                          onRatingUpdate: (rating) {
                            controller.ratingStars.value = rating;
                          },
                        )),
                        SizedBox(height: constraints.maxHeight * 0.05,),
                        Text(kAnyThing,style: AppTextStyle.mediumTextNormal.copyWith(
                            color: AppColors.greyColor
                        ),),
                        const SizedBox(height: 10,),
                        Obx(()=> CustomTextFieldWidget2(
                          controller: controller.reviewText,
                          labelText: kComments,
                          maxLine: 3,
                          enabled: controller.ratingStars.value > 0.0,
                          isErrorFound: false,
                          enableConstraints: false,
                        )),
                        SizedBox(height: constraints.maxHeight * 0.05,),
                        Obx(()=> CustomButton(
                            color: controller.ratingStars.value > 0.0 ? AppColors.primaryColor : AppColors.greyColor300,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                            title: kSubmit, onPressed: (){
                              controller.addReview(Get.arguments[0]);
                           })),
                        SizedBox(height: constraints.maxHeight * 0.6,),
                      ],
                    ),
                  ),
                  Obx((){
                    if(controller.isLoading.value == ReservationsLoading.review){
                      return const LoadingWidget();
                    }
                    return Container();
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
