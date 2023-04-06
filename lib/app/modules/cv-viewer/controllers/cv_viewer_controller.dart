import 'package:get/get.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';

class CvViewerController extends GetxController {
  late final String url;
  late final String token;
  final loading = true.obs;
  @override
  void onInit() {
    url = Get.arguments;
    token = Get.find<HomeController>().token.value;
    loading.value = false;
    print(url);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
