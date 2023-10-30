class LoginModel {
  int? code;
  String? status;
  Data? data;
  String? message;

  LoginModel({this.code, this.status, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? fullName;
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
  String? map;
  String? otp;
  String? otpVerified;

  Data(
      {this.id,
        this.fullName,
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
        this.roleId,
        this.map,
        this.otp,
        this.otpVerified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    fullName = json['fullname'];
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
    map = json['map'];
    otp = json['otp'];
    otpVerified = json['otp_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['fullname'] = this.fullName;
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
    data['map'] = this.map;
    data['otp'] = this.otp;
    data['otp_verified'] = this.otpVerified;
    return data;
  }
}