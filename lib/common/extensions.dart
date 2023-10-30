import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {
  String toDateFormat(){
    return DateFormat("yyyy-MM-dd HH:mm").format(this);
  }
}
extension DateTimeStringFormat on String {
  String toDateFormat(){
    return DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(this));
  }
  String toDateTime(){
    return DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(this));
  }
}
