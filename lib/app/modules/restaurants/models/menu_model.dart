class MenuModel {
  int? code;
  String? status;
  List<Menus>? menus;

  MenuModel({this.code, this.status, this.menus});

  MenuModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.menus != null) {
      data['menus'] = this.menus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menus {
  String? iD;
  String? restaurantLocation;
  String? itemname;
  String? itemType;
  String? itemDescription;
  String? price;
  String? statuss;
  String? chefName;
  String? chefImage;
  String? itemimage;
  String? userId;

  Menus(
      {this.iD,
        this.restaurantLocation,
        this.itemname,
        this.itemType,
        this.itemDescription,
        this.price,
        this.statuss,
        this.chefName,
        this.chefImage,
        this.itemimage,
        this.userId});

  Menus.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    restaurantLocation = json['restaurant_location'];
    itemname = json['itemname'];
    itemType = json['item_type'];
    itemDescription = json['item_description'];
    price = json['price'];
    statuss = json['statuss'];
    chefName = json['chef_name'];
    chefImage = json['chef_image'];
    itemimage = json['itemimage'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ID'] = this.iD;
    data['restaurant_location'] = this.restaurantLocation;
    data['itemname'] = this.itemname;
    data['item_type'] = this.itemType;
    data['item_description'] = this.itemDescription;
    data['price'] = this.price;
    data['statuss'] = this.statuss;
    data['chef_name'] = this.chefName;
    data['chef_image'] = this.chefImage;
    data['itemimage'] = this.itemimage;
    data['user_id'] = this.userId;
    return data;
  }
}