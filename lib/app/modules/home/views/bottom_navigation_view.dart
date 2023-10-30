import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/assets/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../controller/home_controller.dart';

class BottomNavigationView extends GetView<HomeController> {

  BottomNavigationView({Key? key}) : super(key: key);

  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      // height: _size.height * 0.12,
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      width: _size.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _menu(
              title: kHome,
              iconSvg: kHomeSvg,
              isActive: controller.selectedPage == 0,
              onTap: (){
                controller.onSelectPage(0);
              }
          ),

          _menu(
              title: kReservations,
              iconSvg: kMenuCalendarSvg,
              isActive: controller.selectedPage == 1,
              onTap: (){
                controller.onSelectPage(1);
              }
          ),
          _menu(

              title: kFavourites,
              iconSvg: kMenuFavouritesSvg,
              isActive: controller.selectedPage == 2,
              onTap: (){
                controller.onSelectPage(2);
              }
          ),

          _menu(
              title: kProfile,
              iconSvg: kMenuProfileSvg,
              isActive: controller.selectedPage == 3,
              onTap: (){
                controller.onSelectPage(3);
              }
          ),
        ],
      ),
    );
  }

  Widget _menu({required String title,required String iconSvg,required Function() onTap,bool isActive = false}){
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconSvg,
              color: isActive ? AppColors.primaryColor : AppColors.greyColor,
            ),
            const SizedBox(height: 2.5,),
            Text(title,style: AppTextStyle.smallTextBold.copyWith(
                color: AppColors.greyColor
            ),),
          ],
        ),
      ),
    );
  }

}
