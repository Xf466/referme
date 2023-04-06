import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class ChangePasswordController extends GetxController {
  final password = "".obs;
  final passwordError = Rx<String?>(null);
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  late final String token;
  late final HomeController c;

  void passwordEdit(String n) => password.value = n;

  @override
  void onInit() {
    c = Get.find<HomeController>();
    token = c.token.value;
    super.onInit();
  }

  void save() {
    var valid = true;

    if (password.value.isEmpty) {
      passwordError.value = "Must not be empty";
      valid = false;
    } else if (password.value.length < 8) {
      passwordError.value = 'Password length must be at least 8';
      valid = false;
    } else {
      passwordError.value = null;
    }

    if (!valid) return;
    doRequest();
  }

  void doRequest() async {
    isLoading.value = !isLoading.value;
    try {
      var response = await Dio().put("${ConstData.serverUrl}/user/update/",
          data: {
            "password": password.value,
          },
          options: Options(headers: {"Authorization": token}));
      if (response.statusCode == 200) {
        await Get.dialog(const AlertDialog(
          title: Text("Success"),
          content: Text("Successfully changed password"),
        ));

        Get.back();
      }
    } on DioError catch (e, _) {
      var errorMessage = "Unknown error!";

      if (e.response?.statusCode == 401) {
        errorMessage = "Please login again";
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
      }
      Get.dialog(AlertDialog(
        title: const Text("Unable to change data"),
        content: Text(errorMessage),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
  }
}
