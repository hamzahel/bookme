import 'package:bookme/app/modules/restaurants/controllers/details_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/ui.dart';
import 'package:bookme/common/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/assets/asset_path.dart';
import '../../../routes/app_routes.dart';

class MenuPage extends GetView<DetailsController> {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
         return Container(
           width: constraints.maxWidth,
           height: constraints.maxHeight,
           margin: EdgeInsets.only(top: constraints.maxHeight * 0.05,right: 15,left: 15,bottom: 15),
           decoration: BoxDecoration(
             borderRadius: const BorderRadius.all(Radius.circular(15)),
             image: DecorationImage(
                 image: NetworkImage(Get.arguments),
                 fit: BoxFit.cover
             ),
           ),
           child: Container(
             padding: const EdgeInsets.all(15),
             decoration: BoxDecoration(
               borderRadius: const BorderRadius.all(Radius.circular(15)),
               color: AppColors.blackColor.withOpacity(0.5),
             ),
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
                     SvgPicture.asset(kMenu2Svg),

                   ],
                 ),
                 const SizedBox(height: 10,),
                 Text("Check Our Delicious",style: AppTextStyle.smallTextNormal.copyWith(
                   color: AppColors.subTitleTextColor,
                   fontSize: 14
                 ),),
                 Text("Menu",style: AppTextStyle.xxLargeTextBold.copyWith(
                   color: AppColors.subTitleTextColor,
                   fontSize: 28
                 ),),
                 Expanded(
                     child: ListView.builder(
                       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                         itemBuilder: (context,index){
                           final menu = controller.menuModel!.menus!.elementAt(index);
                           return Container(
                             margin: const EdgeInsets.only(bottom: 10.0),
                             child: Row(
                               children: [
                                 // Container(
                                 //   padding: const EdgeInsets.all(15),
                                 //   decoration: BoxDecoration(
                                 //     borderRadius: const BorderRadius.all(Radius.circular(10)),
                                 //     color: AppColors.whiteColor
                                 //   ),
                                 //   child: Icon(Icons.favorite,color: AppColors.primaryColor,),
                                 // ),
                                 SvgPicture.asset(
                                     kMenu1Svg,
                                     width: 50,
                                     height: 50,
                                 ),
                                 const SizedBox(width: 15,),
                                 Expanded(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       const SizedBox(height: 10,),
                                       Text(menu.itemType!,style: AppTextStyle.mediumTextBold.copyWith(
                                         color: AppColors.subTitleTextColor,
                                         fontSize: 18
                                       ),),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text(menu.itemname!,style: AppTextStyle.smallTextNormal.copyWith(
                                             color: AppColors.subTitleTextColor,
                                             fontSize: 14
                                           ),),
                                           Text("Rs ${menu.price!}",style: AppTextStyle.smallTextNormal.copyWith(
                                             color: AppColors.subTitleTextColor,
                                             fontSize: 14
                                           ),),
                                         ],
                                       ),
                                       Divider(color: AppColors.mallTitleTextColor,thickness: 1.0,),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           );
                         },
                         itemCount: controller.menuModel!.menus!.length,
                     )
                 ),
                 const SizedBox(height: 15,),
                 Align(
                   alignment: Alignment.center,
                   child: CustomButton(
                   contentPadding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                       textStyle: AppTextStyle.mediumTextBold.copyWith(
                           color: AppColors.whiteColor,
                           fontSize: 16
                       ),
                   title: "Reserve A Table",
                   onPressed: (){
                     Get.toNamed(Routes.RESERVE_PAGE2,arguments: [controller.restaurantsModel?.details?.id,controller.restaurantsModel?.details?.restaurantLocation,'nav-3']);
                   }
                   ),
                 )
               ],
             ),
           ),
         );
        },
      ),
    );
  }
}
