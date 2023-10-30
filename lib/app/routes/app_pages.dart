import 'package:bookme/app/modules/forgot-password/binding/forgot_password_binding.dart';
import 'package:bookme/app/modules/forgot-password/views/forgot_password_page.dart';
import 'package:bookme/app/modules/home/binding/home_binding.dart';
import 'package:bookme/app/modules/home/views/home_page.dart';
import 'package:bookme/app/modules/login/binding/login_binding.dart';
import 'package:bookme/app/modules/otp/binding/otp_binding.dart';
import 'package:bookme/app/modules/otp/views/otp_page.dart';
import 'package:bookme/app/modules/profile/binding/profile_binding.dart';
import 'package:bookme/app/modules/profile/views/profile_page.dart';
import 'package:bookme/app/modules/reservation/views/review_page.dart';
import 'package:bookme/app/modules/restaurants/bindings/details_binding.dart';
import 'package:bookme/app/modules/restaurants/bindings/tables_binding.dart';
import 'package:bookme/app/modules/restaurants/views/details_page.dart';
import 'package:bookme/app/modules/restaurants/views/tables_page.dart';
import 'package:bookme/app/modules/root/binding/root_binding.dart';
import 'package:bookme/app/modules/sign-up/binding/signup_binding.dart';
import 'package:bookme/app/modules/sign-up/views/signup_page.dart';
import 'package:get/get.dart';


import '../modules/login/views/login_page.dart';
import '../modules/restaurants/bindings/reserve_binding2.dart';
import '../modules/restaurants/bindings/restaurants_binding.dart';
import '../modules/restaurants/views/reserve_page2.dart';
import '../modules/restaurants/views/restaurants_page.dart';
import '../modules/root/views/root_page.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(name: Routes.ROOT, page: () => RootPage(),binding: RootBinding()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage(),binding: LoginBinding()),
    GetPage(name: Routes.OTP, page: () => OtpPage(),binding: OtpBinding()),
    GetPage(name: Routes.SIGNUP, page: () => SignUpPage(),binding: SignUpBinding()),
    GetPage(name: Routes.FORGOTPASSWORD, page: () => ForgotPasswordPage(),binding: ForgotPasswordBinding()),
    GetPage(name: Routes.HOME, page: () => HomePage(),binding: HomeBinding()),
    GetPage(name: Routes.RESTAURANTS_PAGE, page: () => RestaurantsPage(),binding: RestaurantsBinding()),
    GetPage(name: Routes.TABLES_PAGE, page: () => TablesPage(),binding: TablesBinding()),
    GetPage(name: Routes.DETAILS_PAGE, page: () => DetailsPage(),binding: DetailsBinding()),
    GetPage(name: Routes.RESERVE_PAGE2, page: () => ReservePage2(),binding: ReserveBinding2()),
    GetPage(name: Routes.PROFILE_PAGE, page: () => ProfilePage(),binding: ProfileBinding()),
    GetPage(name: Routes.REVIEW_PAGE, page: () => ReviewPage()),
  ];

}