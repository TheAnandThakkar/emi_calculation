import 'package:emi_calculation/utils/app_commons/app_colors.dart';
import 'package:emi_calculation/utils/app_commons/app_routes.dart';
import 'package:emi_calculation/utils/app_commons/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const EmiCalculation());
}

class EmiCalculation extends StatelessWidget {
  const EmiCalculation({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.routes,
          initialRoute: ScreenRoutes.homeScreen,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.backgroundColor,
              surfaceTintColor: AppColors.backgroundColor,
            ),
          ),
        );
      },
    );
  }
}
