import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:referme/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final _storage = const FlutterSecureStorage();
  final token = "".obs;
  final fname = "".obs;
  final lname = "".obs;
  final email = "".obs;
  final linkedin = "".obs;
  final currentPage = 0.obs;

  void changePage(int newPage) {
    currentPage.value = newPage;
  }

  Future<void> getData() async {
    if (token.value != "") {
      return;
    }
    token.value = await _storage.read(key: 'token') ?? "";
    fname.value = await _storage.read(key: 'fname') ?? "";
    lname.value = await _storage.read(key: 'lname') ?? "";
    email.value = await _storage.read(key: 'email') ?? "";
    linkedin.value = await _storage.read(key: 'linkedin') ?? "";
    if (token.value == "") {
      Get.offNamedUntil(Routes.LOGIN, (route) => false);
    }
  }

  @override
  void onInit() async {
    getData();
    super.onInit();
  }
}
