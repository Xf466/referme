import 'package:get/get.dart';

import '../controllers/referral_order_details_controller.dart';

class ReferralOrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferralOrderDetailsController>(
      () => ReferralOrderDetailsController(),
    );
  }
}
