import 'package:bookme/app/modules/restaurants/controllers/restaurants_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:bookme/common/ui.dart';
import 'package:bookme/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_text_style.dart';
import '../../../../common/builder_ids.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_rich_text.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../routes/app_routes.dart';

class RestaurantsPage extends GetView<RestaurantsController> {

  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints){
            return GetX<RestaurantsController>(
                builder: (_){
                  return Padding(
                    padding: const EdgeInsets.only(right: horizontalPadding,left: horizontalPadding,top: 10),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth,
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
                              const SizedBox(height: 5.0,),
                              CustomRichText(
                                  label: "$kAvailable\n",
                                  labelTextStyle: AppTextStyle.mediumTextNormal.copyWith(
                                      color: AppColors.labelTextColor,
                                      fontSize: 16
                                  ),
                                  children: [
                                    TextSpan(
                                        text: kRestaurants,
                                        style: AppTextStyle.xLargeTextBold.copyWith(
                                            color: AppColors.labelTextColor,
                                            fontSize: 30
                                        )
                                    ),
                                  ]
                              ),
                              if(controller.restaurantsModel?.data != null && controller.restaurantsModel!.data!.isNotEmpty)
                                Expanded(child: Container(
                                  padding: const EdgeInsets.only(top: 10,right: 5.0,left: 5.0),
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context,index){
                                      final mData = controller.restaurantsModel!.data!.elementAt(index);
                                      final isFavouriteId = controller.favouriteList.firstWhere((element) => element == mData.id,orElse: ()=> "");

                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 5.0),
                                        child: Card(
                                          elevation: 2.0,
                                          color: AppColors.whiteColor,
                                          shadowColor: AppColors.whiteColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                              // side: BorderSide(color: AppColors.greyColor.withOpacity(0.3))
                                          ),
                                          child: SizedBox(
                                            width: constraints.maxWidth,
                                            height: constraints.maxHeight * 0.3,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                                        color: AppColors.whiteColor,
                                                      image: DecorationImage(
                                                            image: NetworkImage(mData.restaurantImage!),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              getStatus(status: mData.statuss!),
                                                              InkWell(
                                                                onTap: (){
                                                                  controller.addDeleteFavourites(mData.id!);
                                                                },
                                                                child: CircleAvatar(
                                                                  backgroundColor: isFavouriteId.isEmpty ? AppColors.transparent : AppColors.whiteColor,
                                                                  child: Icon(
                                                                    Icons.favorite,color: isFavouriteId.isEmpty ?
                                                                  AppColors.whiteColor : AppColors.primaryColor,size: 24,),
                                                                  radius: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Text(mData.fullname!,style: AppTextStyle.largeTextBold.copyWith(
                                                              color: AppColors.whiteColor,
                                                              fontSize: 22
                                                          ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CustomButton(
                                                        title: kDetails,
                                                        onPressed: (){
                                                          Get.toNamed(Routes.DETAILS_PAGE, arguments: [mData.restaurantImage,mData.id]);
                                                        },
                                                        color: AppColors.whiteColor,
                                                        textStyle: AppTextStyle.mediumTextBold.copyWith(
                                                            color: AppColors.blackColor,
                                                          fontSize: 12
                                                        ),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 15),
                                                      ),
                                                      CustomButton(
                                                        title: kReserve,
                                                        onPressed: (){
                                                          Get.toNamed(Routes.RESERVE_PAGE2,arguments: [mData.id,mData.restaurantLocation,'nav-1']);
                                                        },
                                                        color: AppColors.primaryColor,
                                                        textStyle: AppTextStyle.mediumTextBold.copyWith(
                                                            color: AppColors.whiteColor,
                                                          fontSize: 14
                                                        ),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: controller.restaurantsModel!.data!.length,
                                  ),
                                )),
                            ],
                          ),
                        ),
                        if(controller.isLoading.value == RestaurantsLoading.parent)
                          const LoadingWidget()
                      ],
                    ),
                  );
                }
            );
          }),
      ),
    );
  }

  Widget _getPlace({required String title, required String status}){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.5),

      // decoration: BoxDecoration(
      //   borderRadius: const BorderRadius.all(Radius.circular(25)),
      //   color: AppColors.whiteColor.withOpacity(0.8),
      // ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$title | ",style: AppTextStyle.smallTextBold.copyWith(
              color: AppColors.purpleColor
          ),),
          Text(status,style: AppTextStyle.smallTextBold.copyWith(
              color: AppColors.greenTitleColor
          ),),
        ],
      ),
    );
  }

  Widget getStatus({required String status}) {

    Color? color;
    if(status == "Available"){
      color = AppColors.greenColor;
    } else if(status == "Partially Reserved") {
      color = AppColors.partiallyReservedColor;
    } else {
      color = AppColors.greyColor;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
      child: Center(child: Text(status,style: AppTextStyle.mediumTextNormal.copyWith(
          color: color == AppColors.partiallyReservedColor ? AppColors.blackColor : AppColors.whiteColor,
        fontSize: 14
      ),)),
    );
  }

}
