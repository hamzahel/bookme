import 'package:bookme/app/modules/home/controller/home_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:bookme/common/assets/asset_path.dart';
import 'package:bookme/common/string_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrawerView extends GetView<HomeController> {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const vSpace = SizedBox(
      height: 5.0,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _widgetBox(
                      title: kHome,
                      iconData: kHomeSvg,
                      constraints: constraints,
                      onTap: () {
                        controller.drawerController.value =
                            AdvancedDrawerValue.hidden();
                        controller.onSelectPage(0);
                      }),
                  vSpace,
                  _widgetBox(
                      title: kReservations,
                      iconData: kMenuFavouritesSvg,
                      constraints: constraints,
                      onTap: () {
                        controller.drawerController.value =
                            AdvancedDrawerValue.hidden();
                        controller.onSelectPage(1);
                      }),
                  vSpace,
                  _widgetBox(
                      title: kFavourites,
                      iconData: kMenuCalendarSvg,
                      constraints: constraints,
                      onTap: () {
                        controller.drawerController.value =
                            AdvancedDrawerValue.hidden();
                        controller.onSelectPage(2);
                      }),
                ],
              ),
            ),
            Positioned(
                top: constraints.maxHeight * 0.1,
                left: constraints.maxWidth * 0.15,
                child: GetBuilder<HomeController>(
                    id: kUpdateProfileWidget,
                    builder: (_) {
                      return Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.loginModel?.data?.fullName ?? "N/A",
                                style: AppTextStyle.xLargeTextBold
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              Text(
                                kCustomer,
                                style: AppTextStyle.mediumTextNormal.copyWith(
                                  color: AppColors.whiteColor.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.toNamed(Routes.PROFILE_PAGE);
                              // controller.drawerController.showDrawer();
                            },
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: controller.loginModel?.data
                                        ?.restaurantOwnerImage ??
                                    "",
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Container(
                                    color: AppColors.whiteColor,
                                    // child: Center(child: Icon(Icons.person,size: constraints.maxHeight * 0.035,color: AppColors.primaryColor,))
                                    child: Center(
                                      child: SvgPicture.asset(kProfileSvg),
                                    )),
                                fit: BoxFit.fill,
                                width: constraints.maxHeight * 0.07,
                                height: constraints.maxHeight * 0.07,
                              ),
                            ),
                          ),
                        ],
                      );
                    }))
          ],
        );
      },
    );
  }

  Widget _widgetBox({
    required BoxConstraints constraints,
    required String iconData,
    required String title,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Container(
        width: constraints.maxWidth * 0.7,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: AppColors.whiteColor)),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              child: SvgPicture.asset(
                iconData,
                color: AppColors.primaryColor,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: AppTextStyle.mediumTextNormal
                  .copyWith(color: AppColors.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
