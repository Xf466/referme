import 'package:get/get.dart';

import '../controllers/my_referral_controller.dart';

class MyReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyReferralController>(
      MyReferralController(),
    );
  }
}
