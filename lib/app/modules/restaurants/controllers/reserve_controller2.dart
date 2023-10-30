import 'dart:convert';

import 'package:bookme/app/modules/home/controller/home_controller.dart';
import 'package:bookme/app/modules/restaurants/models/table_type_model.dart';
import 'package:bookme/app/modules/restaurants/models/tables_by_table_type_model.dart';
import 'package:bookme/common/extensions.dart';
import 'package:bookme/common/time_schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/string_constant.dart';
import '../../../../common/ui.dart';
import '../../../providers/prefrences.dart';
import '../../login/model/login_model.dart';
import '../models/table_available_model.dart';
import '../repository/restaurant_repository.dart';
import '../../reservation/views/review_page.dart';

enum ReserveLoading { parent, hide, dialog }
class ReserveController2 extends GetxController with _ReserveInitializer{

  int getNumberOfDaysInMonth(DateTime date) {
    DateTime dateTime = DateTime(date.year, date.month, 1);
    DateTime nextMonth = DateTime(date.year, date.month + 1, 1);
    Duration duration = nextMonth.difference(dateTime);
    // Logger.log("${duration.inDays} -- number of days \n ${dateTime.weekday} -- weekday");
    print("getNumberOfDaysInMonth: ${duration.inDays}");
    return duration.inDays;
  }

  void updateFromDatePicker(){
    update([kUpdateFromDatePicker]);
  }

  void updateToDatePicker(){
    update([kUpdateToDatePicker]);
  }

  @override
  void onInit() {
    _restaurantRepository = RestaurantRepository();
    locationTitle.value = Get.arguments[1];
    // loadTableTypes();
    // _init();
    super.onInit();
  }

  /*_init(){
    final currentDateTime = DateTime.now();
    for(int i = 0; i < monthList.length; i++){
      if(i+1 == currentDateTime.month){
        selectedMonth.value = monthList.elementAt(i);
        break;
      }
    }
    final int numberOfDaysInMonth = getNumberOfDaysInMonth(currentDateTime);
    for(int i = 0; i < numberOfDaysInMonth; i++){
      bool isEnable = false;
      final monthIndex = monthList.indexOf(selectedMonth.value);
      if(monthIndex + 1 >= currentDateTime.month){
        if(i+1 >= currentDateTime.day){
          isEnable = true;
        }
      }
      dayItemList.add(DayItem(
          weekday: _getWeekDay(DateTime(currentDateTime.year,currentDateTime.month,i+1).weekday),
          day: i+1,
          enable: isEnable
      ));
    }

    for(int i = 0; i < 24; i++){
      if(i >= currentDateTime.hour){
        for(int j = 0; j < timeSchedule2.length; j++){
          if(timeSchedule2.elementAt(j).contains(i.toString())){
            timeList.add(timeSchedule2.elementAt(j));
          }
        }
      }
    }

    updateDayItem();
    // Future.delayed(Duration(milliseconds: 500),(){
    //   animateTo(numberOfDaysInMonth,currentDayIndex.value);
    // });

  }*/

  /*void onMonthChanged(){
    selectedDayItem.value = DayItem();
    dayItemList.clear();
    final currentDateTime = DateTime.now();
    final monthIndex = monthList.indexOf(selectedMonth.value);
    int day = 1;
    if(monthIndex + 1 == currentDateTime.month){
      day = currentDateTime.day;
    }
    final dateTime = DateTime(currentDateTime.year,monthIndex + 1,day);
    final int numberOfDaysInMonth = getNumberOfDaysInMonth(dateTime);
    for(int i = 0; i < numberOfDaysInMonth; i++){
      bool isEnable = false;
      if(monthIndex + 1 >= currentDateTime.month){
        if(i+1 >= dateTime.day){
          isEnable = true;
        }
      }
      dayItemList.add(DayItem(
          weekday: _getWeekDay(DateTime(dateTime.year,dateTime.month,i+1).weekday),
          day: i+1,
          enable: isEnable
      ));
    }
    selectedTime = [TimeMng(pos: -1,id: 0,),TimeMng(pos: -1,id: 1,),];
    timeList.clear();
    if(monthIndex + 1 >= currentDateTime.month){
      for(int i = 0; i < 24; i++){
        if(i >= (monthIndex + 1 == currentDateTime.month ? currentDateTime.hour : dateTime.hour)){
          for(int j = 0; j < timeSchedule2.length; j++){
            if(timeSchedule2.elementAt(j).contains(i.toString())){
              timeList.add(timeSchedule2.elementAt(j));
            }
          }
        }
      }
    }
    updateDayItem();
    updateTime();
  }*/

  /*void onDayChanged(){
    selectedTableType.value = TableTypes();
    selectedTablesByTableType.value = TablesByTableType();
    selectedTime = [TimeMng(pos: -1,id: 0,),TimeMng(pos: -1,id: 1,),];
    final currentDateTime = DateTime.now();
    final monthIndex = monthList.indexOf(selectedMonth.value);
    if(monthIndex + 1 == currentDateTime.month){
      timeList.clear();
      final dateTime = DateTime(currentDateTime.year,monthIndex + 1,selectedDayItem.value.day!);
      for(int i = 0; i < 24; i++){
        if(i >= (selectedDayItem.value.day == currentDateTime.day ? currentDateTime.hour : dateTime.hour)){
          for(int j = 0; j < timeSchedule2.length; j++){
            if(timeSchedule2.elementAt(j).contains(i.toString())){
              timeList.add(timeSchedule2.elementAt(j));
            }
          }
        }
      }
    }
    updateDayItem();
    updateTime();
  }*/

  void calendarAnimateTo(numberOfDaysInMonth,int index){
    calendarScrollController.animateTo((calendarScrollController.position.maxScrollExtent / numberOfDaysInMonth) * (index + 1),
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease);
  }

  void parentAnimateTo(){
    parentScrollController.animateTo(parentScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.ease);
  }

  /*@override
  Future<void> loadTableTypes() async {
    try{
      isLoading.value = ReserveLoading.parent;
      final response = await _restaurantRepository.tableType("&restaurant_id=${Get.arguments[0]}");
      if(response != null){
        tableTypeModel = TableTypeModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("loadTableTypes Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReserveLoading.hide;
    }
    return Future.value();
  }*/

  @override
  Future<void> loadTablesByTableType(id) async {
    try{
      tablesByTableTypeModel = null;
      isLoading.value = ReserveLoading.dialog;
      final response = await _restaurantRepository.tablesByTableType("&table_type_id=$id");
      if(response != null){
        tablesByTableTypeModel = TablesByTableTypeModel.fromJson(response);
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("loadTablesByTableType Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReserveLoading.hide;
    }
    return Future.value();
  }

  @override
  Future<void> addReserve() async {
    try{
      isLoading.value = ReserveLoading.parent;
      // final currentDateTime = DateTime.now();
      // final month = monthList.indexOf(selectedMonth.value) + 1;
      // final day = selectedDayItem.value.day;
      Map<String,dynamic> body = {
        "date_from" : fromDateTime!.toDateFormat(),
        "date_to" : toDateTime!.toDateFormat(),
        "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
        "type_id" : selectedTable.value.tableId,
        "table_id" : selectedTable.value.id,
        "no_of_guests" : guestsCount.toString()
      };
      final response = await _restaurantRepository.addReserve(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          goBack();
          Get.find<HomeController>().onSelectPage(1);
          successSnackBar("${response['message']}");
        } else if(response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        } else {
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("loadTablesByTableType Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReserveLoading.hide;
    }
    return Future.value();
  }

  void goBack(){
    switch(Get.arguments[2]){
      case "nav-1":
        Get.back();
        Get.back();
        break;
      case "nav-2":
        Get.back();
        Get.back();
        Get.back();
        break;
      case "nav-3":
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        break;
      default:
        Get.back();
        break;
    }
  }

  @override
  Future<void> addWaiting(Tables table) async {
    try{
      Get.back();
      isLoading.value = ReserveLoading.parent;
      // final currentDateTime = DateTime.now();
      // final month = monthList.indexOf(selectedMonth.value) + 1;
      // final day = selectedDayItem.value.day;
      Map<String,dynamic> body = {
        "waiting_from" : fromDateTime!.toDateFormat(),
        "waiting_to" : toDateTime!.toDateFormat(),
        "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
        "table_id" : table.tableId,
        "table_type_id" : table.id,
        // "no_of_guests" : guestsCount.toString()
      };
      final response = await _restaurantRepository.addWaiting(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          successSnackBar("${response['message']}");
        } else if(response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        } else {
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("addWaiting Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReserveLoading.hide;
    }
    return Future.value();
  }

  @override
  Future<void> checkAvailability() async {
    try{
      isLoading.value = ReserveLoading.parent;
      Map<String,dynamic> body = {
        "date_from" : fromDateTime!.toDateFormat(),
        "date_to" : toDateTime!.toDateFormat(),
        // "user_id" : LoginModel.fromJson(jsonDecode(Preferences.getAuth!)).data!.id!,
        "restaurant_id" : Get.arguments[0],
        "location" : Get.arguments[1],
      };
      final response = await _restaurantRepository.checkAvailability(body);
      if(response != null){
        if(response['status'] != null && response['status'] == "success"){
          tableAvailableModel = TableAvailableModel.fromJson(response);
          successSnackBar("${response['message']}");
        } else if(response['status'] != null && response['message'] != null) {
          errorSnackBar("${response['message']}");
        } else {
          Get.log(kSomeThingWentWrong,isError: true);
          errorSnackBar(kSomeThingWentWrong);
        }
      } else {
        Get.log(kSomeThingWentWrong,isError: true);
        errorSnackBar(kSomeThingWentWrong);
      }
    }catch(error) {
      Get.log("checkAvailability Error: $error",isError: true);
      errorSnackBar(kSomeThingWentWrong);
    } finally {
      isLoading.value = ReserveLoading.hide;
    }
    return Future.value();
  }

  void errorSnackBar(String message){
    if(!Get.isSnackbarOpen){
      Get.showSnackbar(Ui.ErrorSnackBar(message: message));
    }
  }
  void successSnackBar(String message){
    if(!Get.isSnackbarOpen){
      Get.showSnackbar(Ui.SuccessSnackBar(message: message));
    }
  }

  void updateDayItem(){
    update([kUpdateDayItem]);
  }
  void updateTime(){
    update([kUpdateTime]);
  }

}

mixin _ReserveInitializer{
  late RestaurantRepository _restaurantRepository;
  final isLoading = ReserveLoading.hide.obs;
  DateTime? fromDate;
  DateTime? toDate;
  final calendarScrollController = ScrollController();
  final parentScrollController = ScrollController();
  final guestsCount = 1.obs;
  // final selectedMonth = "Jan".obs;
  // List<String> monthList = ["Jan","Feb","March","April","May","June","July","Aug","Sep","Oct","Nov","Dec"];
  // List<DayItem> dayItemList = [];
  // final selectedDayItem = DayItem().obs;
  // List<String> timeList = [];
  // List<TimeMng> selectedTime = [TimeMng(pos: -1,id: 0,),TimeMng(pos: -1,id: 1,),];
  TableTypeModel? tableTypeModel;
  final selectedTableType = TableTypes().obs;
  TablesByTableTypeModel? tablesByTableTypeModel;
  final selectedTablesByTableType = TablesByTableType().obs;
  final locationTitle = "".obs;

  DateTime? fromDateTime;
  DateTime? toDateTime;
  TableAvailableModel? tableAvailableModel;
  final selectedTable = Tables().obs;


  // Future<void> loadTableTypes();
  Future<void> loadTablesByTableType(id);
  Future<void> addReserve();
  Future<void> addWaiting(Tables table);
  Future<void> checkAvailability();

}

const kUpdateFromDatePicker = "update_from_date_picker";
const kUpdateToDatePicker = "update_to_date_picker";
const kUpdateDayItem = "update_day_item";
const kUpdateTime = "update_time";

String _getWeekDay(int day){
  switch(day){
    case 1:
      return "Mon";
    case 2:
      return "Tues";
    case 3:
      return "Wed";
    case 4:
      return "Thurs";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    default:
      return "Sun";
  }
}

class DayItem {
  String? weekday;
  int? day;
  bool? enable;
  DayItem({this.weekday,this.day,this.enable});
}

class TimeMng{
  int? pos;
  int? id;
  TimeMng({this.id, this.pos,});
}

