class TablesByTableTypeModel {
  int? code;
  String? status;
  List<TablesByTableType>? tablesByTableType;

  TablesByTableTypeModel({this.code, this.status, this.tablesByTableType});

  TablesByTableTypeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['tables_by_table_type'] != null) {
      tablesByTableType = <TablesByTableType>[];
      json['tables_by_table_type'].forEach((v) {
        tablesByTableType!.add(new TablesByTableType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.tablesByTableType != null) {
      data['tables_by_table_type'] =
          this.tablesByTableType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TablesByTableType {
  String? id;
  String? tableId;
  String? tableNo;
  String? availabilityFrom;
  String? availabilityTo;
  String? personsPerTable;
  String? status;
  String? addedOn;
  Null? updatedOn;

  TablesByTableType(
      {this.id,
        this.tableId,
        this.tableNo,
        this.availabilityFrom,
        this.availabilityTo,
        this.personsPerTable,
        this.status,
        this.addedOn,
        this.updatedOn});

  TablesByTableType.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    tableId = json['table_id'];
    tableNo = json['table_no'];
    availabilityFrom = json['availability_from'];
    availabilityTo = json['availability_to'];
    personsPerTable = json['persons_per_table'];
    status = json['status'];
    addedOn = json['added_on'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['table_id'] = this.tableId;
    data['table_no'] = this.tableNo;
    data['availability_from'] = this.availabilityFrom;
    data['availability_to'] = this.availabilityTo;
    data['persons_per_table'] = this.personsPerTable;
    data['status'] = this.status;
    data['added_on'] = this.addedOn;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}