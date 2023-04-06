import 'package:get/get.dart';

import 'package:referme/app/modules/home/controllers/dashboard_controller.dart';
import 'package:referme/app/modules/home/controllers/notification_controller.dart';
import 'package:referme/app/modules/home/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
    Get.put<HomeController>(
      HomeController(),
    );
    Get.put<DashboardController>(
      DashboardController(),
    );
  }
}
