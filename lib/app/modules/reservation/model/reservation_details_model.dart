class ReservationDetailsModel {
  int? code;
  String? status;
  Data? data;

  ReservationDetailsModel({this.code, this.status, this.data});

  ReservationDetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? tableId;
  String? typeTableId;
  String? datetimeFrom;
  String? datetimeTo;
  String? noOfGuests;
  String? reservedOn;
  String? updatedOn;
  String? status;

  Data(
      {this.id,
        this.userId,
        this.tableId,
        this.typeTableId,
        this.datetimeFrom,
        this.datetimeTo,
        this.noOfGuests,
        this.reservedOn,
        this.updatedOn,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    userId = json['user_id'];
    tableId = json['table_id'];
    typeTableId = json['type_table_id'];
    datetimeFrom = json['datetime_from'];
    datetimeTo = json['datetime_to'];
    noOfGuests = json['no_of_guests'];
    reservedOn = json['reserved_on'];
    updatedOn = json['updated_on'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['user_id'] = this.userId;
    data['table_id'] = this.tableId;
    data['type_table_id'] = this.typeTableId;
    data['datetime_from'] = this.datetimeFrom;
    data['datetime_to'] = this.datetimeTo;
    data['no_of_guests'] = this.noOfGuests;
    data['reserved_on'] = this.reservedOn;
    data['updated_on'] = this.updatedOn;
    data['status'] = this.status;
    return data;
  }
}