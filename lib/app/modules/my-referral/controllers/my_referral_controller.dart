import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/modules/home/models/referral.dart';
import 'package:referme/app/routes/app_pages.dart';

class MyReferralController extends GetxController {
  late final String token;
  final referrals = <Referral>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    token = Get.find<HomeController>().token.value;
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading.value = !isLoading.value;
    try {
      var response = await Dio().get("${ConstData.serverUrl}/get/referrals/me",
          options: Options(headers: {"Authorization": token}));
      if (response.statusCode == 200) {
        referrals.clear();
        for (var element in (response.data as List<dynamic>)) {
          referrals.add(Referral.fromJSON(element as Map));
        }
      }
    } on DioError catch (e, _) {
      var errorMessage = "Unknown error!";
      if (e.response?.statusCode == 401) {
        errorMessage = "Please login again";
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
      }
      Get.dialog(AlertDialog(
        title: const Text("Unable to get data"),
        content: Text(errorMessage),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
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
