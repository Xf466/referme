import 'package:get/get.dart';

import '../controllers/cv_viewer_controller.dart';

class CvViewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CvViewerController>(
      CvViewerController(),
    );
  }
}
