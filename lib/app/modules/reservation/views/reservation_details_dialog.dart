
import 'package:bookme/common/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/assets/asset_path.dart';
import '../../../../common/widgets/custom_button.dart';
import '../controller/reservations_controller.dart';

class ReservationDialog extends GetView<ReservationsController> {

  ReservationDialog({Key? key,required this.size,required this.itemPosition}) : super(key: key);
  Size? size;
  int itemPosition;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: SizedBox(
        width: size!.width,
        height: size!.height * 0.6,
        // padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Obx((){
                if(controller.isLoading.value == ReservationsLoading.dialog){

                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );

                }

                if(controller.reservationDetailsModel?.data != null){

                  return Column(
                    children: [
                      Expanded(
                        flex: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                              color: AppColors.reservationBoxBackColor,
                              image: const DecorationImage(
                                    image: AssetImage(kReservationDialogPng),
                                    fit: BoxFit.fill
                              )
                            ),
                            padding: const EdgeInsets.only(left: 10,bottom: 10,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(5.0),
                                    onPressed: (){
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.clear),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Text(kYourReservation,style: AppTextStyle.largeTextBold.copyWith(
                                            color: AppColors.blackColor
                                          ),),
                                        ),
                                        const SizedBox(height: 2.5,),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5.0),
                                          decoration: BoxDecoration(
                                            color: controller.reservationDetailsModel?.data!.status == "Approved" ? AppColors.greenTitleColor : AppColors.redColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.check,color: AppColors.whiteColor,),
                                              const SizedBox(width: 5.0,),
                                              Text(
                                                  controller.reservationDetailsModel?.data!.status ?? "",
                                                  style: AppTextStyle.smallTextBold.copyWith(
                                                      color: AppColors.whiteColor
                                                  )
                                              ),

                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                )
                              ],
                            ),
                          )
                      ),
                      Expanded(
                        flex: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                    kYouCanOnly,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.mediumTextNormal.copyWith(
                                        color: AppColors.blackColor
                                    )
                                ),
                                const SizedBox(height: 10,),
                                _detailsBox(
                                  title: kTableType,
                                  value: "#${controller.reservationDetailsModel?.data?.typeTableId ?? ""}",
                                  constraints: constraints
                                ),
                                const SizedBox(height: 10,),
                                _detailsBox(
                                    title: kNoOfGuests,
                                    value: "#${controller.reservationDetailsModel?.data?.noOfGuests ?? ""}",
                                    constraints: constraints
                                ),
                                const SizedBox(height: 10,),
                                _detailsBox(
                                    title: kFromDate,
                                    value: controller.reservationDetailsModel?.data?.datetimeFrom?.split(" ").first ?? "",
                                    constraints: constraints
                                ),
                                const SizedBox(height: 10,),
                                _detailsBox(
                                    title: kToDate,
                                    value: controller.reservationDetailsModel?.data?.datetimeTo?.split(" ").first ?? "",
                                    constraints: constraints
                                ),
                                const SizedBox(height: 10,),
                                if(controller.reservationDetailsModel!.data!.status == "Approved" && isReservationCancelButtonShow(DateTime.parse(controller.reservationDetailsModel!.data!.reservedOn!)))
                                  CustomButton(
                                      color: AppColors.redColor,
                                      textStyle: AppTextStyle.smallTextBold.copyWith(
                                          color: AppColors.whiteColor
                                      ),
                                      title: kCancel, onPressed:() {
                                    controller.cancelReservation(controller.reservationDetailsModel!.data!.id!);
                                  }
                                  )
                              ],
                            ),
                          )
                      ),
                    ],
                  );

                }

                return Container();
            });
          }
        ),
      ),
    );
  }

  bool isReservationCancelButtonShow(DateTime dateTime){
    int day,hour,minute,sec;
    if(dateTime.hour >= 14 && dateTime.minute >= 0 && dateTime.second >= 0){
      day = dateTime.day + 1;
      hour = (dateTime.hour + 10) - 24;
      minute = dateTime.minute;
      sec = dateTime.second;
    } else {
      day = dateTime.day;
      hour = dateTime.hour + 10;
      minute = dateTime.minute;
      sec = dateTime.second;
    }
    dateTime = DateTime(dateTime.year,dateTime.month,day,hour,minute,sec);
    if(dateTime.compareTo(DateTime.now()) < 0){
      return false;
    } else {
      return true;
    }
  }

  Widget _detailsBox({required String title, required String value, required BoxConstraints constraints}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            title,
            style: AppTextStyle.smallTextNormal.copyWith(
                color: AppColors.blackColor
            )
        ),
        Container(
          width: constraints.maxWidth * 0.4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: AppColors.greySubTitleColor500),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Text(value,style: AppTextStyle.smallTextBold,textAlign: TextAlign.center,),
        ),
      ],
    );
  }

}
