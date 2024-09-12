import 'package:emi_calculation/ui/emi_screen/emi_screen_controller.dart';
import 'package:get/get.dart';

class EmiScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmiScreenController());
  }
}
