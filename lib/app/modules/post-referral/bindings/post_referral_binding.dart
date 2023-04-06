import 'package:get/get.dart';

import '../controllers/post_referral_controller.dart';

class PostReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PostReferralController>(
      PostReferralController(),
    );
  }
}
