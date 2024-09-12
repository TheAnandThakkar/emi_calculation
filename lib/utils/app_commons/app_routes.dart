import 'package:emi_calculation/ui/emi_screen/emi_screen.dart';
import 'package:emi_calculation/ui/emi_screen/emi_screen_binding.dart';
import 'package:emi_calculation/ui/home/home_screen.dart';
import 'package:emi_calculation/ui/home/home_screen_binding.dart';
import 'package:emi_calculation/utils/app_commons/screen_routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: ScreenRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: ScreenRoutes.emiScreen,
      page: () => const EmiScreen(),
      binding: EmiScreenBinding(),
    ),
  ];
}
