import 'package:get/get.dart';

import '../modules/addnews/bindings/addnews_binding.dart';
import '../modules/addnews/views/addnews_view.dart';
import '../modules/avatar/bindings/avatar_binding.dart';
import '../modules/avatar/views/avatar_view.dart';
import '../modules/editnews/bindings/editnews_binding.dart';
import '../modules/editnews/views/editnews_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/widgets/splash_screen.dart';
import '../modules/home/views/widgets/test.dart';
import '../modules/home_grid_view/bindings/home_grid_view_binding.dart';
import '../modules/home_grid_view/views/home_grid_view_view.dart';
import '../modules/imagepicker/bindings/imagepicker_binding.dart';
import '../modules/imagepicker/views/imagepicker_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/readme_news/bindings/readme_news_binding.dart';
import '../modules/readme_news/views/readme_news_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/homeScreen',
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/SignUpScreen',
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: '/SplashScreen',
      page: () => SplashScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: '/Test',
      page: () => Test(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.IMAGEPICKER,
      page: () => ImagepickerView(),
      binding: ImagepickerBinding(),
    ),
    GetPage(
      name: _Paths.README_NEWS,
      page: () => ReadmeNewsView(),
      binding: ReadmeNewsBinding(),
    ),
    GetPage(
      name: _Paths.EDITNEWS,
      page: () => EditnewsView(),
      binding: EditnewsBinding(),
    ),
    GetPage(
      name: _Paths.ADDNEWS,
      page: () => AddnewsView(),
      binding: AddnewsBinding(),
    ),
    GetPage(
      name: _Paths.AVATAR,
      page: () => AvatarView(),
      binding: AvatarBinding(),
    ),
    GetPage(
      name: _Paths.HOME_GRID_VIEW,
      page: () => HomeGridViewView(),
      binding: HomeGridViewBinding(),
    ),
  ];
}
