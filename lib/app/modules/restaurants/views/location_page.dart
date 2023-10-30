import 'package:bookme/common/widgets/custom_rich_text.dart';
import 'package:bookme/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/string_constant.dart';
import '../../../routes/app_routes.dart';
import '../controllers/location_controller.dart';

class LocationPage extends GetView<LocationController> {
  const LocationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GetX<LocationController>(
          init: LocationController(),
          builder: (_){

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                      child: CustomRichText(
                          label: "$kListOf\n",
                          labelTextStyle: AppTextStyle.mediumTextNormal.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 16
                          ),
                          children: [
                            TextSpan(
                                text: kMalls,
                                style: AppTextStyle.xLargeTextBold.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 30
                                )
                            ),
                          ]
                      ),
                    ),
                    if(controller.locationModel?.data != null && controller.locationModel!.data!.isNotEmpty)
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context,index){
                              final mData = controller.locationModel!.data!.elementAt(index);
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.RESTAURANTS_PAGE,arguments: [mData.name]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: AppColors.greyColor.withOpacity(0.3))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight * 0.5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex: 85,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      image: DecorationImage(
                                                          image: NetworkImage(mData.image!),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                )
                                            ),
                                            const SizedBox(height: 10,),
                                            Expanded(
                                              flex: 15,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  mData.name!,
                                                  style: AppTextStyle.xLargeTextBold.copyWith(
                                                    color: AppColors.mallTitleTextColor,
                                                    fontSize: 22
                                                ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.locationModel!.data!.length,
                          ),
                        )
                    ),
                  ],
                ),
                if(controller.isLoading.value == LocationLoading.parent)
                  const LoadingWidget()
              ],
            );
          }
      );
    });
  }
}
