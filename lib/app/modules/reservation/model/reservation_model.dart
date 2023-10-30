class ReservationModel {
  int? code;
  String? status;
  List<Data>? data;

  ReservationModel({this.code, this.status, this.data});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? tableNo;
  String? tableTypeName;
  String? restaurantId;

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
        this.status,
        this.tableNo,
        this.tableTypeName,
        this.restaurantId
      });

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
    tableNo = json['table_no'];
    tableTypeName = json['table_type_name'];
    restaurantId = json['restaurant_id'];
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
    data['table_no'] = this.tableNo;
    data['table_type_name'] = this.tableTypeName;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}