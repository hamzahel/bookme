
import 'package:bookme/app/modules/restaurants/views/waiting_dialog.dart';
import 'package:bookme/common/widgets/custom_button.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/assets/asset_path.dart';
import '../../../../common/string_constant.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../controllers/reserve_controller2.dart';

class ReservePage2 extends GetView<ReserveController2>{

  ReservePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const verticalSpace = SizedBox(height: 10,);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GetX<ReserveController2>(
                builder: (_){
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                    color: AppColors.primaryColor
                                ),
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.only(top: 10,bottom: 5.0),
                                child: Icon(Icons.arrow_back_ios_outlined,color: AppColors.whiteColor,),
                              ),
                            ),
                            Text(kReserveTable,style: AppTextStyle.xLargeTextBold.copyWith(
                                color: AppColors.labelTextColor,
                                fontSize: 28
                            ),),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(kLocationSvg,color: AppColors.labelTextColor,),
                                const SizedBox(width: 5.0,),
                                Text(
                                  controller.locationTitle.value,
                                  style: AppTextStyle.mediumTextNormal.copyWith(
                                    color: AppColors.labelTextColor,
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: controller.parentScrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    verticalSpace,
                                    verticalSpace,
                                    verticalSpace,
                                    SizedBox(
                                        width: constraints.maxWidth,
                                        child: _guests()
                                    ),
                                    verticalSpace,

                                    SizedBox(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight * 0.25,
                                      child: _checkAvailabilityBox(constraints),
                                    ),
                                    verticalSpace,
                                    verticalSpace,


                                    if(controller.tableAvailableModel?.tables != null && controller.tableAvailableModel!.tables!.isNotEmpty)
                                      Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        alignment: WrapAlignment.center,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        runAlignment: WrapAlignment.center,
                                        children: [
                                          for(int i = 0; i < controller.tableAvailableModel!.tables!.length; i++)
                                            InkWell(
                                              onTap: (){
                                                if(controller.tableAvailableModel!.tables!.elementAt(i).availability == "yes"){
                                                  controller.selectedTable.value = controller.tableAvailableModel!.tables!.elementAt(i);
                                                } else {
                                                  Get.dialog(WaitingDialog(size: MediaQuery.of(Get.context!).size,
                                                      tables: controller.tableAvailableModel!.tables!.elementAt(i)));
                                                }
                                              },
                                              child: Obx((){
                                                final table = controller.selectedTable.value;
                                                return Stack(
                                                  children: [
                                                    Container(
                                                      // width: constraints.maxWidth * 0.35,
                                                      // height: constraints.maxHeight * 0.15,
                                                      padding: const EdgeInsets.all(12.5),
                                                      decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          color: table.id == controller.tableAvailableModel!.tables!.elementAt(i).id ? AppColors.greenColor :
                                                          controller.tableAvailableModel!.tables!.elementAt(i).availability == "yes" ? AppColors.greyColor300 : AppColors.redColor,
                                                          border: Border.all(
                                                              color: table.id == controller.tableAvailableModel!.tables!.elementAt(i).id ? AppColors.primaryColor : AppColors.greyColor300
                                                          )
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            kTableReservationSvg,
                                                              color: table.id == controller.tableAvailableModel!.tables!.elementAt(i).id || controller.tableAvailableModel!.tables!.elementAt(i).availability == "no" ? AppColors.whiteColor : AppColors.primaryColor
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          Text(
                                                            controller.tableAvailableModel!.tables!.elementAt(i).tableType!,
                                                            style: AppTextStyle.xSmallTextBold.copyWith(
                                                                color: table.id == controller.tableAvailableModel!.tables!.elementAt(i).id || controller.tableAvailableModel!.tables!.elementAt(i).availability == "no" ?
                                                                AppColors.whiteColor : AppColors.labelTextColor
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 5,
                                                        right: 5,
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.5),
                                                          decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                            border: Border.all(
                                                                color: table.id == controller.tableAvailableModel!.tables!.elementAt(i).id || controller.tableAvailableModel!.tables!.elementAt(i).availability == "no" ? AppColors.whiteColor : AppColors.blackColor
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(controller.tableAvailableModel!.tables!.elementAt(i).tableNo!,style: AppTextStyle.xxSmallTextBold.copyWith(
                                                                color: table.id == controller.tableAvailableModel!.tables!.elementAt(i).id || controller.tableAvailableModel!.tables!.elementAt(i).availability == "no" ?
                                                                AppColors.whiteColor : AppColors.labelTextColor
                                                            ),),
                                                          ),
                                                        )
                                                    )
                                                  ],
                                                );
                                              }),
                                            )
                                        ],
                                      ),

                                    verticalSpace,
                                    verticalSpace,
                                    verticalSpace,
                                    verticalSpace,
                                    if(controller.tableAvailableModel?.tables != null && controller.tableAvailableModel!.tables!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                      child: Row(

                                        children: [
                                          Expanded(
                                              flex: 40,
                                              child: CustomButton(
                                            title: kCancel,
                                            color: AppColors.whiteColor,
                                            onPressed: (){
                                              Get.back();
                                            },
                                            textStyle: AppTextStyle.mediumTextNormal.copyWith(
                                                color: AppColors.blackColor
                                            ),
                                          )
                                          ),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            flex: 60,
                                            child: CustomButton(title: kConfirmReservation,
                                              onPressed: (){
                                              if(controller.tableAvailableModel?.tables != null && controller.tableAvailableModel!.tables!.isNotEmpty){
                                                if(controller.selectedTable.value.id != null){
                                                  if(controller.selectedTable.value.availability == "yes"){
                                                    controller.addReserve();
                                                  }
                                                } else {
                                                  controller.errorSnackBar(kPleaseSelectTable);
                                                }
                                              }
                                            },
                                              textStyle: AppTextStyle.mediumTextNormal.copyWith(
                                                  color: AppColors.whiteColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(controller.isLoading.value == ReserveLoading.parent)
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

  Widget _guests(){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kGuests,style: AppTextStyle.mediumTextBold.copyWith(
            fontSize: 16,
            color: AppColors.labelTextColor
          ),),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
              border: Border.all(color: AppColors.mallTitleTextColor),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    if(controller.guestsCount.value > 1){
                      controller.guestsCount.value--;
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Icon(Icons.remove,color: AppColors.mallTitleTextColor,size: 14,),
                  ),
                ),
                const SizedBox(width: 10,),
                Obx(()=>Text("${controller.guestsCount.value}",style: AppTextStyle.mediumTextBold.copyWith(
                    fontSize: 16,
                    color: AppColors.labelTextColor
                ),)),
                const SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    controller.guestsCount.value++;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Icon(Icons.add,color: AppColors.mallTitleTextColor,size: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkAvailabilityBox(BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColors.whiteColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(kFromDate,style: AppTextStyle.mediumTextBold.copyWith(
                color: AppColors.labelTextColor,
                fontSize: 16
              ),),
              GetBuilder<ReserveController2>(
               id: kUpdateFromDatePicker,
               builder: (_){
                 return _dateTimePicker(
                   constraints,
                   initialDateTime: controller.fromDateTime,
                   onDateTimeChanged: (value){
                     controller.fromDateTime = value;
                     controller.updateFromDatePicker();
                   },
                 );
               },
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(kToDate,style: AppTextStyle.mediumTextBold.copyWith(
                  color: AppColors.labelTextColor,
                  fontSize: 16
              ),),
              GetBuilder<ReserveController2>(
               id: kUpdateToDatePicker,
               builder: (_){
                 return _dateTimePicker(
                   constraints,
                   initialDateTime: controller.toDateTime,
                   onDateTimeChanged: (value){
                     controller.toDateTime = value;
                     controller.updateToDatePicker();
                   },
                 );
               },
              )
            ],
          ),
          const SizedBox(height: 10,),
          CustomButton(
              title: kCheckAvailability,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              textStyle: AppTextStyle.mediumTextBold.copyWith(
                color: AppColors.labelTextColor,
                fontSize: 14
              ),
              color: AppColors.mallTitleTextColor,
              onPressed: (){
                if(controller.fromDateTime != null && controller.toDateTime != null){
                  controller.checkAvailability();
                } else if(controller.fromDateTime == null && controller.toDateTime == null){
                  controller.errorSnackBar(kPleaseSelectFromToDate);
                } else if(controller.fromDateTime == null){
                  controller.errorSnackBar(kPleaseSelectFromDate);
                } else if(controller.toDateTime == null){
                  controller.errorSnackBar(kPleaseSelectToDate);
                }
              }
          )
        ],
      ),
    );
  }

  _dateTimePicker(BoxConstraints constraints,{DateTime? initialDateTime, required Function(DateTime) onDateTimeChanged}){
    return Container(
      width: constraints.maxWidth * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(color: AppColors.mallTitleTextColor)
      ),
      child: Row(
        children: [
          Expanded(
            child: DateTimePicker(
              type: DateTimePickerType.dateTime,
              enabled: true,
              textAlign: TextAlign.center,
              dateMask: 'yyyy-MM-dd HH:mm',
              initialDate: initialDateTime ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2121),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              style: AppTextStyle.mediumTextNormal.copyWith(
                  color: AppColors.labelTextColor,
                  fontSize: 14
              ),
              selectableDayPredicate: (date) {
                final currentDateTime = DateTime.now();
                if(date.year < currentDateTime.year){
                  return false;
                } else if(date.year == currentDateTime.year && date.month < currentDateTime.month) {
                  return false;
                } else if(date.month == currentDateTime.month && date.day < currentDateTime.day){
                  return false;
                }
                return true;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "YYYY-MM-dd HH:MM",
                hintStyle: AppTextStyle.mediumTextNormal.copyWith(
                    color: AppColors.mallTitleTextColor,
                    fontSize: 14
                ),
                isDense: true,

              ),
              onChanged: (value){
                onDateTimeChanged(DateTime.parse(value));
              },
              maxLines: 1,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_outlined,size: 22,),
        ],
      ),
    );
  }




}
