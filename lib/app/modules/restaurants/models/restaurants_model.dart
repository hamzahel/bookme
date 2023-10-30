class RestaurantsModel {
  int? code;
  String? status;
  List<Data>? data;
  Data? details;

  RestaurantsModel({this.code, this.status, this.data, this.details});

  RestaurantsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null && json['data'] is List<dynamic>) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } else if(json['data'] != null) {
      details = Data.fromJson(json['data']);
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
  String? fullname;
  String? gender;
  String? username;
  String? email;
  String? pass;
  String? confirmPass;
  String? phone;
  String? restaurantLocation;
  String? restaurantOwnerImage;
  String? restaurantImage;
  String? restaurantDescription;
  String? statuss;
  String? roleId;

  Data(
      {this.id,
        this.fullname,
        this.gender,
        this.username,
        this.email,
        this.pass,
        this.confirmPass,
        this.phone,
        this.restaurantLocation,
        this.restaurantOwnerImage,
        this.restaurantImage,
        this.restaurantDescription,
        this.statuss,
        this.roleId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    fullname = json['fullname'];
    gender = json['gender'];
    username = json['username'];
    email = json['email'];
    pass = json['pass'];
    confirmPass = json['confirm_pass'];
    phone = json['phone'];
    restaurantLocation = json['restaurant_location'];
    restaurantOwnerImage = json['restaurant_owner_image'];
    restaurantImage = json['restaurant_image'];
    restaurantDescription = json['restaurant_description'];
    statuss = json['statuss'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['fullname'] = this.fullname;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['email'] = this.email;
    data['pass'] = this.pass;
    data['confirm_pass'] = this.confirmPass;
    data['phone'] = this.phone;
    data['restaurant_location'] = this.restaurantLocation;
    data['restaurant_owner_image'] = this.restaurantOwnerImage;
    data['restaurant_image'] = this.restaurantImage;
    data['restaurant_description'] = this.restaurantDescription;
    data['statuss'] = this.statuss;
    data['role_id'] = this.roleId;
    return data;
  }
}