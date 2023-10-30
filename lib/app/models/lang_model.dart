class LangModel {
  String? emailUserName;
  String? password;
  String? forgotPassword;
  String? clickHere;
  String? login;
  String? dontHaveAccount;
  String? signUp;
  String? welcome;
  String? fullName;
  String? userName;
  String? email;
  String? phoneNumber;
  String? conformPassword;
  String? choosePhoto;
  String? loading;
  String? listOf;
  String? locations;
  String? home;
  String? favourites;
  String? reservations;
  String? profile;
  String? available;
  String? restaurants;
  String? details;
  String? reserve;
  String? directions;
  String? call;
  String? menu;
  String? rating;
  String? description;
  String? reserveTable;
  String? checkOurDelicious;
  String? guests;
  String? fromDate;
  String? toDate;
  String? checkAvailability;
  String? cancel;
  String? confirmReservation;
  String? table;
  String? reserved;
  String? tableType;
  String? dateReserved;
  String? reservationList;
  String? timeReserved;
  String? rateYourExperience;
  String? withOurProducts;
  String? wouldYouRate;
  String? anyThing;
  String? comments;
  String? submit;
  String? logout;

  LangModel(
      {this.emailUserName,
        this.password,
        this.forgotPassword,
        this.clickHere,
        this.login,
        this.dontHaveAccount,
        this.signUp,
        this.welcome,
        this.fullName,
        this.userName,
        this.email,
        this.phoneNumber,
        this.conformPassword,
        this.choosePhoto,
        this.loading,
        this.listOf,
        this.locations,
        this.home,
        this.favourites,
        this.reservations,
        this.profile,
        this.available,
        this.restaurants,
        this.details,
        this.reserve,
        this.directions,
        this.call,
        this.menu,
        this.rating,
        this.description,
        this.reserveTable,
        this.checkOurDelicious,
        this.guests,
        this.fromDate,
        this.toDate,
        this.checkAvailability,
        this.cancel,
        this.confirmReservation,
        this.table,
        this.reserved,
        this.tableType,
        this.dateReserved,
        this.reservationList,
        this.timeReserved,
        this.rateYourExperience,
        this.withOurProducts,
        this.wouldYouRate,
        this.anyThing,
        this.comments,
        this.submit,
        this.logout});

  LangModel.fromJson(Map<String, dynamic> json) {
    emailUserName = json['email_user_name'];
    password = json['password'];
    forgotPassword = json['forgot_password'];
    clickHere = json['click_here'];
    login = json['login'];
    dontHaveAccount = json['dont_have_account'];
    signUp = json['sign_up'];
    welcome = json['welcome'];
    fullName = json['full_name'];
    userName = json['user_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    conformPassword = json['conform_password'];
    choosePhoto = json['choose_photo'];
    loading = json['loading'];
    listOf = json['list_of'];
    locations = json['locations'];
    home = json['home'];
    favourites = json['favourites'];
    reservations = json['reservations'];
    profile = json['profile'];
    available = json['available'];
    restaurants = json['restaurants'];
    details = json['details'];
    reserve = json['reserve'];
    directions = json['directions'];
    call = json['call'];
    menu = json['menu'];
    rating = json['rating'];
    description = json['description'];
    reserveTable = json['reserve_table'];
    checkOurDelicious = json['check_our_delicious'];
    guests = json['guests'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    checkAvailability = json['check_availability'];
    cancel = json['cancel'];
    confirmReservation = json['confirm_reservation'];
    table = json['table'];
    reserved = json['reserved'];
    tableType = json['table_type'];
    dateReserved = json['date_reserved'];
    reservationList = json['reservation_list'];
    timeReserved = json['time_reserved'];
    rateYourExperience = json['rate_your_experience'];
    withOurProducts = json['with_our_products'];
    wouldYouRate = json['would_you_rate'];
    anyThing = json['any_thing'];
    comments = json['comments'];
    submit = json['submit'];
    logout = json['logout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_user_name'] = this.emailUserName;
    data['password'] = this.password;
    data['forgot_password'] = this.forgotPassword;
    data['click_here'] = this.clickHere;
    data['login'] = this.login;
    data['dont_have_account'] = this.dontHaveAccount;
    data['sign_up'] = this.signUp;
    data['welcome'] = this.welcome;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['conform_password'] = this.conformPassword;
    data['choose_photo'] = this.choosePhoto;
    data['loading'] = this.loading;
    data['list_of'] = this.listOf;
    data['locations'] = this.locations;
    data['home'] = this.home;
    data['favourites'] = this.favourites;
    data['reservations'] = this.reservations;
    data['profile'] = this.profile;
    data['available'] = this.available;
    data['restaurants'] = this.restaurants;
    data['details'] = this.details;
    data['reserve'] = this.reserve;
    data['directions'] = this.directions;
    data['call'] = this.call;
    data['menu'] = this.menu;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['reserve_table'] = this.reserveTable;
    data['check_our_delicious'] = this.checkOurDelicious;
    data['guests'] = this.guests;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['check_availability'] = this.checkAvailability;
    data['cancel'] = this.cancel;
    data['confirm_reservation'] = this.confirmReservation;
    data['table'] = this.table;
    data['reserved'] = this.reserved;
    data['table_type'] = this.tableType;
    data['date_reserved'] = this.dateReserved;
    data['reservation_list'] = this.reservationList;
    data['time_reserved'] = this.timeReserved;
    data['rate_your_experience'] = this.rateYourExperience;
    data['with_our_products'] = this.withOurProducts;
    data['would_you_rate'] = this.wouldYouRate;
    data['any_thing'] = this.anyThing;
    data['comments'] = this.comments;
    data['submit'] = this.submit;
    data['logout'] = this.logout;
    return data;
  }
}