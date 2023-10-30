import 'package:bookme/app/modules/restaurants/controllers/tables_controller.dart';
import 'package:bookme/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../models/restaurants_model.dart';

class TablesPage extends StatelessWidget {

  const TablesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: Get.arguments[0],
          child: Text("${Get.arguments[0].toString().split("/").first} Tables",style: AppTextStyle.largeTextBold.copyWith(
              color: AppColors.whiteColor
          ),),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(Get.context!);
          },
          icon: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,),
        ),
      ),
      body: LayoutBuilder(
          builder: (context, constraints){
            return GetBuilder<TablesController>(
                builder: (_){
                  return Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){},
                          child: Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.4,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColors.blackColor.withOpacity(0.85),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(color: AppColors.primaryColor,width: 1.5),
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: AppColors.greyColor,
                              //       offset: const Offset(0,0),
                              //       spreadRadius: 0,
                              //       blurRadius: 0
                              //   )
                              // ]
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  flex: 80,
                                  child: Container(
                                    // width: constraints.maxWidth,
                                    // height: constraints.maxHeight * 0.4,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(13),
                                        topLeft: Radius.circular(13),
                                        bottomLeft:  Radius.circular(14),
                                        bottomRight: Radius.circular(14),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(_list.elementAt(index).restaurantImage!),
                                          fit: BoxFit.cover
                                      ),

                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // width: constraints.maxWidth,
                                          // height: constraints.maxHeight * 0.1,
                                          bottom: 10,
                                          right: 0,
                                          left: 0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.1,vertical: 5.0),
                                              decoration: BoxDecoration(
                                                  color: AppColors.blackColor.withOpacity(0.5),
                                                  borderRadius:  BorderRadius.all(
                                                      Radius.circular(constraints.maxWidth * 0.1)
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: AppColors.blackColor.withOpacity(0.5),
                                                        offset: const Offset(0,0),
                                                        spreadRadius: 5,
                                                        blurRadius: 5
                                                    )
                                                  ]
                                              ),
                                              child: Column(
                                                // alignment: WrapAlignment.center,
                                                // crossAxisAlignment: WrapCrossAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(_list.elementAt(index).fullname!,style: AppTextStyle.largeTextBold.copyWith(
                                                      color: AppColors.whiteColor
                                                  ),textAlign: TextAlign.center,),
                                                  const SizedBox(height: 2.5,),
                                                  _getPlace(title: Get.arguments[1],status: "Available")
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: _list.length,
                    ),
                  );
                }
            );

          }),
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
}


List<Data> _list = [
  Data(
      fullname: "Natural View Table",
      restaurantImage: "http://bookme.hassantraders.org/Uploaded-Restaurant-image/T1.jpeg"
  ),
  Data(
      fullname: "Indoor Table",
      restaurantImage: "http://bookme.hassantraders.org/Uploaded-Restaurant-image/T2.jpg"
  ),
];