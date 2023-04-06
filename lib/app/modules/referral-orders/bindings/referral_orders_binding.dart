import 'package:get/get.dart';

import '../controllers/referral_orders_controller.dart';

class ReferralOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferralOrdersController>(
      () => ReferralOrdersController(),
    );
  }
}
