class TableTypeModel {
  int? code;
  String? status;
  List<TableTypes>? tableTypes;

  TableTypeModel({this.code, this.status, this.tableTypes});

  TableTypeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['table_types'] != null) {
      tableTypes = <TableTypes>[];
      json['table_types'].forEach((v) {
        tableTypes!.add(new TableTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.tableTypes != null) {
      data['table_types'] = this.tableTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableTypes {
  String? id;
  String? statuss;
  String? tableType;
  String? tableId;
  String? restaurantLocation;
  String? numberOfTables;
  String? personPerTable;
  String? tableDescription;
  String? pricePerPerson;
  String? pricePerTable;
  String? tableImage;
  String? tableFrom;
  String? tableTo;
  String? userId;

  TableTypes(
      {this.id,
        this.statuss,
        this.tableType,
        this.restaurantLocation,
        this.numberOfTables,
        this.personPerTable,
        this.tableDescription,
        this.pricePerPerson,
        this.pricePerTable,
        this.tableImage,
        this.tableFrom,
        this.tableTo,
        this.userId,
        this.tableId,
      });

  TableTypes.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    statuss = json['statuss'];
    tableType = json['table_type'];
    restaurantLocation = json['restaurant_location'];
    numberOfTables = json['number_of_tables'];
    personPerTable = json['person_per_table'];
    tableDescription = json['table_description'];
    pricePerPerson = json['price_per_person'];
    pricePerTable = json['price_per_table'];
    tableImage = json['table_image'];
    tableFrom = json['table_from'];
    tableTo = json['table_to'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['statuss'] = this.statuss;
    data['table_type'] = this.tableType;
    data['restaurant_location'] = this.restaurantLocation;
    data['number_of_tables'] = this.numberOfTables;
    data['person_per_table'] = this.personPerTable;
    data['table_description'] = this.tableDescription;
    data['price_per_person'] = this.pricePerPerson;
    data['price_per_table'] = this.pricePerTable;
    data['table_image'] = this.tableImage;
    data['table_from'] = this.tableFrom;
    data['table_to'] = this.tableTo;
    data['user_id'] = this.userId;
    return data;
  }
}