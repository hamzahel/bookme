class TableAvailableModel {
  int? code;
  String? status;
  String? message;
  List<Tables>? tables;

  TableAvailableModel({this.code, this.status, this.message, this.tables});

  TableAvailableModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['tables'] != null) {
      tables = <Tables>[];
      json['tables'].forEach((v) {
        tables!.add(new Tables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tables != null) {
      data['tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tables {
  String? tableType;
  String? id;
  String? tableId;
  String? tableNo;
  String? availabilityFrom;
  String? availabilityTo;
  String? personsPerTable;
  String? status;
  String? addedOn;
  String? updatedOn;
  String? availability;

  Tables(
      {this.tableType,
        this.id,
        this.tableId,
        this.tableNo,
        this.availabilityFrom,
        this.availabilityTo,
        this.personsPerTable,
        this.status,
        this.addedOn,
        this.updatedOn,
        this.availability});

  Tables.fromJson(Map<String, dynamic> json) {
    tableType = json['table_type'];
    id = json['ID'];
    tableId = json['table_id'];
    tableNo = json['table_no'];
    availabilityFrom = json['availability_from'];
    availabilityTo = json['availability_to'];
    personsPerTable = json['persons_per_table'];
    status = json['status'];
    addedOn = json['added_on'];
    updatedOn = json['updated_on'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['table_type'] = this.tableType;
    data['ID'] = this.id;
    data['table_id'] = this.tableId;
    data['table_no'] = this.tableNo;
    data['availability_from'] = this.availabilityFrom;
    data['availability_to'] = this.availabilityTo;
    data['persons_per_table'] = this.personsPerTable;
    data['status'] = this.status;
    data['added_on'] = this.addedOn;
    data['updated_on'] = this.updatedOn;
    data['availability'] = this.availability;
    return data;
  }
}