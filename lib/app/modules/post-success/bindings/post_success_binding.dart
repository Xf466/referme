import 'package:get/get.dart';

import '../controllers/post_success_controller.dart';

class PostSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostSuccessController>(
      () => PostSuccessController(),
    );
  }
}
