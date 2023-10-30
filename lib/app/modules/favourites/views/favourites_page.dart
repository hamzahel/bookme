import 'package:bookme/common/string_constant.dart';
import 'package:bookme/common/ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/builder_ids.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_rich_text.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../routes/app_routes.dart';
import '../controller/favourites_controller.dart';

class FavouritesPage extends GetView<FavouritesController> {

  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          return GetX<FavouritesController>(
              init: FavouritesController(),
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
                            CustomRichText(
                                label: "$kAvailable\n",
                                labelTextStyle: AppTextStyle.mediumTextNormal.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 16
                                ),
                                children: [
                                  TextSpan(
                                      text: kFavourites,
                                      style: AppTextStyle.xLargeTextBold.copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 30
                                      )
                                  ),
                                ]
                            ),
                            if(controller.favouriteModel?.data != null && controller.favouriteModel!.data!.isNotEmpty)
                              Expanded(child: Container(
                                padding: const EdgeInsets.only(top: 10,right: 5.0,left: 5.0),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context,index){
                                    final mData = controller.favouriteModel!.data!.elementAt(index);
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 7.5),
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
                                          height: constraints.maxHeight * 0.35,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                                      color: AppColors.whiteColor,
                                                      image: DecorationImage(
                                                          image: NetworkImage(mData.restaurantDetail!.restaurantImage!),
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
                                                            getStatus(status: mData.restaurantDetail!.statuss!),
                                                            InkWell(
                                                              onTap: (){
                                                                controller.addDeleteFavourites(mData.restaurantDetail!.id!);
                                                              },
                                                              child: CircleAvatar(
                                                                backgroundColor: AppColors.whiteColor,
                                                                child: Icon(
                                                                  Icons.favorite,color: AppColors.primaryColor,size: 24,),
                                                                radius: 18,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(mData.restaurantDetail!.fullname!,style: AppTextStyle.largeTextBold.copyWith(
                                                            color: AppColors.whiteColor,
                                                            fontSize: 22
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              // Container(
                                              //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5.0),
                                              //   child: Row(
                                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //     children: [
                                              //       CustomButton(
                                              //         title: "Details",
                                              //         onPressed: (){
                                              //           Get.toNamed(Routes.DETAILS_PAGE, arguments: [mData.restaurantDetail!.restaurantImage,mData.restaurantDetail!.id]);
                                              //         },
                                              //         color: AppColors.whiteColor,
                                              //         textStyle: AppTextStyle.mediumTextBold.copyWith(
                                              //             color: AppColors.blackColor,
                                              //             fontSize: 12
                                              //         ),
                                              //         contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 15),
                                              //       ),
                                              //       CustomButton(
                                              //         title: "Reserve",
                                              //         onPressed: (){
                                              //           Get.toNamed(Routes.RESERVE_PAGE2,arguments: [mData.restaurantDetail!.id,mData.restaurantDetail!.restaurantLocation]);
                                              //         },
                                              //         color: AppColors.primaryColor,
                                              //         textStyle: AppTextStyle.mediumTextBold.copyWith(
                                              //             color: AppColors.whiteColor,
                                              //             fontSize: 14
                                              //         ),
                                              //         contentPadding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 15),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: controller.favouriteModel!.data!.length,
                                ),
                              )),
                          ],
                        ),
                      ),
                      if(controller.isLoading.value == FavouritesLoading.parent)
                        const LoadingWidget()
                    ],
                  ),
                );
              }
          );
        });
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
