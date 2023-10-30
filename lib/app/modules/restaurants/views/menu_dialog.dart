
import 'package:bookme/app/modules/restaurants/controllers/details_controller.dart';
import 'package:bookme/common/app_color.dart';
import 'package:bookme/common/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDialog extends GetView<DetailsController> {
  MenuDialog({Key? key,required this.size}) : super(key: key);
  Size? size;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Container(
        width: size!.width,
        height: size!.height * 0.6,
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
           final vSpace = SizedBox(height: constraints.maxHeight * 0.02,);
           return Column(
             children: [
               Text("Check our testy menu",style: AppTextStyle.largeTextBold,),
               SizedBox(height: constraints.maxHeight * 0.04,),
               Expanded(
                   child: ListView.separated(
                       itemBuilder: (context,index){
                         final menu = controller.menuModel!.menus!.elementAt(index);
                         return Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(menu.itemType!,style: AppTextStyle.mediumTextBold.copyWith(
                               color: AppColors.purpleColor
                             ),),
                             const SizedBox(width: 2.5,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(menu.itemname!,style: AppTextStyle.smallTextNormal.copyWith(
                                     color: AppColors.purpleColor
                                 ),),
                                 const SizedBox(width: 5.0,),
                                 Expanded(
                                     child: SizedBox(
                                       height: 2,
                                       child: DecoratedBox(
                                         decoration: BoxDecoration(color: AppColors.greyColor.withOpacity(0.6)),
                                       ),
                                     )
                                 ),
                                 const SizedBox(width: 5.0,),
                                 Text(menu.price!,style: AppTextStyle.smallTextNormal,),
                               ],
                             ),
                           ],
                         );
                       },
                     separatorBuilder: (context,index){
                         return Divider(
                           color: AppColors.greyColor300,
                         );
                     },
                     itemCount: controller.menuModel!.menus!.length,
                   )
               )
             ],
           );
          },
        ),
      ),
    );
  }
}
