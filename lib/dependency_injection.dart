import 'package:get/get.dart';
import 'controllers/network_controller.dart';
import 'controllers/meals_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<MealController>(MealController(), permanent: true);
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
