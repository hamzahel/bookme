import 'package:bookme/app/modules/restaurants/views/google_map.dart';
import 'package:bookme/app/modules/restaurants/views/menu_dialog.dart';
import 'package:bookme/app/modules/restaurants/views/menu_page.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:bookme/common/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/assets/asset_path.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../routes/app_routes.dart';
import '../controllers/details_controller.dart';

class DetailsPage extends GetView<DetailsController> {

  DetailsPage({Key? key}) : super(key: key);

  late Size _size;

  @override
  Widget build(BuildContext context) {

    _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GetX<DetailsController>(
                builder: (_){
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16,left: 16,top: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  image: DecorationImage(
                                      image: NetworkImage(Get.arguments[0]),
                                      fit: BoxFit.cover
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              Get.back();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                                  color: AppColors.whiteColor
                                              ),
                                              padding: const EdgeInsets.all(5),
                                              // margin: const EdgeInsets.only(left: 10,top: 10,bottom: 5.0),
                                              child: Icon(Icons.arrow_back_ios_outlined,color: AppColors.primaryColor,),
                                            ),
                                          ),
                                          const Spacer(),
                                          CircleAvatar(
                                            backgroundColor: AppColors.whiteColor,
                                            radius: constraints.maxWidth * 0.06,
                                            child: CachedNetworkImage(
                                              imageUrl: controller.restaurantsModel?.details?.restaurantOwnerImage ?? "",
                                              placeholder: (context, url) => const CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => SvgPicture.asset(kUser1Svg),
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        controller.restaurantsModel?.details?.fullname ?? "",
                                        style: AppTextStyle.xxLargeTextBold.copyWith(
                                          color: AppColors.whiteColor,
                                          fontSize: 22
                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                      Row(
                                        children: [
                                          SvgPicture.asset(kLocationSvg),
                                          const SizedBox(width: 5.0,),
                                          Text(
                                            controller.restaurantsModel?.details?.restaurantLocation ?? "",
                                            style: AppTextStyle.mediumTextNormal.copyWith(
                                                color: AppColors.subTitleTextColor,
                                                fontSize: 16
                                            )
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 36,
                                    child: _iconButton(
                                      iconData: kDirectionsSvg,
                                      title: kDirections,
                                      onTap: (){}
                                  ),),
                                  const SizedBox(width: 5,),
                                  Flexible(flex: 32,child: _iconButton(
                                      iconData: kCallSvg,
                                      title: kCall,
                                      onTap: (){}
                                  ),),
                                  const SizedBox(width: 5,),
                                  Flexible(flex: 34,child: _iconButton(
                                      iconData: kMenuSvg,
                                      title: kMenu,
                                      onTap: (){
                                        if(controller.restaurantsModel?.details != null && controller.menuModel?.menus != null && controller.menuModel!.menus!.isNotEmpty){
                                          Get.to(()=>MenuPage(),arguments: Get.arguments[0]);
                                        }
                                      }
                                  ),),

                                ],
                              ),
                              const SizedBox(height: 10,),
                              Text(kRating,style: AppTextStyle.mediumTextNormal.copyWith(
                                color: AppColors.detailsTextColor,
                                fontSize: 16
                              ),),
                              const SizedBox(height: 5,),
                              RatingBar.builder(
                                initialRating: 5,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: constraints.maxWidth * 0.05,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(Icons.star,
                                  color: AppColors.rattingColor,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              const SizedBox(height: 10,),
                              Text(kDescription,style: AppTextStyle.xxLargeTextBold.copyWith(
                                  color: AppColors.detailsTextColor,
                                  fontSize: 22
                              ),),
                              const SizedBox(height: 5,),
                              Text(
                                controller.restaurantsModel?.details?.restaurantDescription ?? "",
                                style: AppTextStyle.mediumTextNormal.copyWith(
                                  color: AppColors.detailsTextColor,
                                  fontSize: 14
                                ),
                              ),
                              const SizedBox(height: 5.0,),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                    width: constraints.maxWidth,
                                    height: constraints.maxHeight * 0.32,
                                    child: const GoogleMapWidget()
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.15,),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: constraints.maxHeight * 0.05,
                        right: 0,
                        left: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                              textStyle: AppTextStyle.mediumTextBold.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 16
                              ),
                              title: kReserveTable,
                              onPressed: (){
                                Get.toNamed(Routes.RESERVE_PAGE2,arguments: [controller.restaurantsModel?.details?.id,controller.restaurantsModel?.details?.restaurantLocation,'nav-2']);
                              }
                          ),
                        ),
                      ),

                      if(controller.isLoading.value == DetailsLoading.parent)
                        const LoadingWidget()
                    ],
                  );
                }
            );
          },
        ),
      ),
    );

  }

  Widget _iconButton({required String iconData,required String title,required Function() onTap}){

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              offset: const Offset(0,1),
              spreadRadius: 0.5,
              blurRadius: 0.5
            )
          ]
        ),
        padding: const EdgeInsets.symmetric(vertical: 7.5,horizontal: 12.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconData,width: 16,height: 16,),
            const SizedBox(width: 2.5,),
            Text(title,style: AppTextStyle.smallTextNormal.copyWith(
              color: AppColors.greyColor,
              fontSize: 12
            ),)
          ],
        ),
      ),
    );

  }

}
