
import 'package:bookme/app/modules/reservation/views/reservation_details_dialog.dart';
import 'package:bookme/app/modules/reservation/views/review_page.dart';
import 'package:bookme/common/assets/asset_path.dart';
import 'package:bookme/common/ui.dart';
import 'package:bookme/common/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../common/app_color.dart';
import '../../../../common/app_text_style.dart';
import '../../../../common/string_constant.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../routes/app_routes.dart';
import '../controller/reservations_controller.dart';
import 'package:bookme/app/modules/reservation/model/reservation_model.dart';

class ReservationsPage extends GetView<ReservationsController> {
  const ReservationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GetX<ReservationsController>(
          init: ReservationsController(),
          builder: (_){

            return Stack(
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: 5.0),
                        child: Text(kReservationList,style: AppTextStyle.xLargeTextBold.copyWith(
                            color: AppColors.whiteColor
                        )),
                      ),

                      if(controller.reservationModel?.data != null && controller.reservationModel!.data!.isNotEmpty)
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                            child: ListView.builder(
                              itemBuilder: (context,index){
                                final reservation = controller.reservationModel!.data!.elementAt(index);
                                return InkWell(
                                  onTap: (){
                                    controller.loadReservationDetails(reservation.id!);
                                    Get.dialog(ReservationDialog(size: MediaQuery.of(Get.context!).size,itemPosition: index,));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 5.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          side: BorderSide(color: AppColors.greyColor.withOpacity(0.3))
                                      ),
                                      child: SizedBox(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight * 0.7,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                flex: 60,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    color: AppColors.reservationBoxBackColor,
                                                    image: const DecorationImage(
                                                      image: AssetImage(kReservationCardPng),
                                                      fit: BoxFit.fill
                                                    )
                                                  ),
                                                  padding: const EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5.0),
                                                            decoration: BoxDecoration(
                                                              color: reservation.status == "Approved" ? AppColors.greenTitleColor : AppColors.redColor,
                                                              borderRadius: const BorderRadius.all(Radius.circular(100)),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Icon(Icons.check,color: AppColors.whiteColor,),
                                                                const SizedBox(width: 5.0,),
                                                                Text(
                                                                    reservation.status ?? "",
                                                                    style: AppTextStyle.smallTextBold.copyWith(
                                                                        color: AppColors.whiteColor,
                                                                        fontSize: 14
                                                                    )
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              CustomRichText(
                                                                  label: "$kTable\n",
                                                                  labelTextStyle: AppTextStyle.smallTextNormal.copyWith(
                                                                    fontSize: 14,
                                                                    color: AppColors.labelTextColor
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text: "#${reservation.tableNo ?? ""}",style: AppTextStyle.xLargeTextBold.copyWith(
                                                                      color: AppColors.labelTextColor,
                                                                      fontSize: 22
                                                                    ),

                                                                    )
                                                                  ]
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          if(reservation.status == "Approved" && checkReviewOption(reservation))
                                                          IconButton(
                                                              onPressed: (){
                                                                controller.ratingStars.value = 0.0;
                                                                controller.reviewText.clear();
                                                                Get.toNamed(Routes.REVIEW_PAGE,arguments: [index]);
                                                              },
                                                              icon: Icon(Icons.star,color: AppColors.greenColor,),
                                                            ),
                                                          Spacer(),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text(kReserved,style: AppTextStyle.smallTextNormal.copyWith(
                                                                color: AppColors.labelTextColor,
                                                                fontSize: 14
                                                              ),),
                                                              Text(reservation.reservedOn ?? "",style: AppTextStyle.mediumTextBold.copyWith(
                                                                  color: AppColors.labelTextColor,
                                                                  fontSize: 14
                                                              ),),

                                                            ],
                                                          ),
                                                          const SizedBox(width: 5.0,),
                                                          // Icon(Icons.date_range_outlined,color: AppColors.blackColor,size: 40,),
                                                          SvgPicture.asset(kCalendarSvg),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                            Expanded(
                                                flex: 40,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(height: 5.0,),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: CustomRichText(
                                                                label: "$kTableType\n",
                                                                labelTextStyle: AppTextStyle.smallTextNormal.copyWith(
                                                                    color: AppColors.detailsTextColor,
                                                                    fontSize: 14
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text: reservation.tableTypeName ?? "",style: AppTextStyle.mediumTextBold.copyWith(
                                                                      color: AppColors.labelTextColor,
                                                                      fontSize: 16
                                                                  ),
                                                                  )
                                                                ]
                                                            ),
                                                          ),
                                                          CustomRichText(
                                                            textAlign: TextAlign.end,
                                                              label: "$kGuests\n",
                                                              labelTextStyle: AppTextStyle.smallTextNormal.copyWith(
                                                                  color: AppColors.detailsTextColor,
                                                                  fontSize: 14
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: reservation.noOfGuests ?? "",style: AppTextStyle.mediumTextBold.copyWith(
                                                                    color: AppColors.labelTextColor,
                                                                    fontSize: 16
                                                                ),
                                                                )
                                                              ]
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 10.0,),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: _dateTimeReserved(
                                                                title: kDateReserved,
                                                                fromDateTime: DateTime.parse(reservation.datetimeFrom!),
                                                                toDateTime: DateTime.parse(reservation.datetimeTo!),
                                                              )
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          Expanded(
                                                              child: _dateTimeReserved(
                                                                title: kTimeReserved,
                                                                fromDateTime: DateTime.parse(reservation.datetimeFrom!),
                                                                toDateTime: DateTime.parse(reservation.datetimeTo!),
                                                                isDate: false
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.reservationModel!.data!.length,
                            ),
                          )
                      ),

                    ],
                  ),
                ),
                if(controller.isLoading.value == ReservationsLoading.parent)
                  const LoadingWidget()
              ],
            );

          }
      );
    });
  }

  bool checkReviewOption(Data reservation){
    if(reservation.datetimeTo != null){
      final toDate = DateTime.parse(reservation.datetimeTo!);
      // print("Date______________$toDate");
      // print("Date Compare______________${toDate.compareTo(DateTime.now())}");
      if(toDate.compareTo(DateTime.now()) < 0){
        return true;
      }

    }
    return false;

  }

  Widget _dateTimeReserved({
    required String title,
    required DateTime fromDateTime,
    required DateTime toDateTime,
    bool isDate = true
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,style: AppTextStyle.smallTextNormal.copyWith(
            color: AppColors.detailsTextColor,
            fontSize: 14
        ),),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: AppColors.greySubTitleColor500),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${ isDate ? fromDateTime.month : fromDateTime.hour } ${isDate ? "-" : ":"} ${ isDate ? fromDateTime.day : fromDateTime.minute }",
                  style: AppTextStyle.smallTextBold.copyWith(
                  color: AppColors.labelTextColor,
                    fontSize: 14

              )),
              const SizedBox(width: 2.5,),
              Icon(Icons.arrow_forward_ios,color: AppColors.mallTitleTextColor,size: 14,),
              const SizedBox(width: 2.5,),
              Text("${ isDate ? toDateTime.month : toDateTime.hour } ${isDate ? "-" : ":"} ${ isDate ? toDateTime.day : toDateTime.minute }",style: AppTextStyle.smallTextBold.copyWith(
                  color: AppColors.labelTextColor,
                  fontSize: 14
              )),
            ],
          ),
        )
      ],
    );
  }

}
