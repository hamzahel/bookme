import 'package:bookme/app/modules/home/controller/home_controller.dart';
import 'package:bookme/app/modules/home/views/bottom_navigation_view.dart';
import 'package:bookme/app/modules/home/views/drawer_view.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/assets/asset_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/builder_ids.dart';
import '../../favourites/views/favourites_page.dart';
import '../../profile/views/profile_page.dart';
import '../../reservation/views/reservations_page.dart';
import '../../restaurants/views/location_page.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);
  late Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetBuilder<HomeController>(
        id: kHomeBuilderId,
        builder: (_){
          return AdvancedDrawer(
            controller: controller.drawerController,
            backdropColor: AppColors.drawerBackgroundColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Scaffold(
              bottomNavigationBar: BottomNavigationView(),
              backgroundColor: AppColors.primaryColor,
              body: SafeArea(
                child: Column(
                  children: [
                    /// Header
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                      ),
                      padding: const EdgeInsets.only(top: 10,right: 5,left: 10),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 5,),
                          IconButton(
                              onPressed: (){
                                controller.drawerController.showDrawer();
                              },
                              icon: Icon(Icons.menu,size: 35,color: AppColors.whiteColor,),
                            padding: const EdgeInsets.all(5.0),
                       ),
                          const Spacer(),
                          Visibility(
                            visible: controller.selectedPage != 3,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: controller.loginModel?.data?.restaurantOwnerImage ?? "",
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Container(
                                    color: AppColors.whiteColor,
                                    child: Center(child: SvgPicture.asset(kProfileSvg)),
                                ),
                                fit: BoxFit.fill,
                                width: _size.height * 0.06,
                                height: _size.height * 0.06,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 85,
                        child: _pages.elementAt(controller.selectedPage).widget
                    ),

                  ],
                ),
              ),
            ),
            drawer: const DrawerView(),
          );
        },
      ),
    );
  }

}

class MenuItem{
  Widget widget;
  String title;
  MenuItem(this.widget,this.title);
}

List<MenuItem> _pages = [
  MenuItem(
    const LocationPage(),
    "Restaurants"
  ),
  MenuItem(
      const ReservationsPage(),
      "Reservations"
  ),
  MenuItem(
    FavouritesPage(),
    "Favourites"
  ),
  MenuItem(
      ProfilePage(),
      "Profile"
  ),
];
