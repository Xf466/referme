import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/modules/home/models/referral.dart';
import 'package:referme/app/routes/app_pages.dart';

import 'package:referme/app/modules/home/controllers/home_controller.dart';

import '../../../data/const.dart';

class DashboardController extends GetxController {
  Rx<String> name = "".obs;
  Rx<String> token = "".obs;
  final referrals = <Referral>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    await Get.find<HomeController>().getData();
    name.value = Get.find<HomeController>().fname.value;
    token = Get.find<HomeController>().token;
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading.value = !isLoading.value;
    try {
      var response = await Dio().get("${ConstData.serverUrl}/get/referrals/",
          options: Options(headers: {"Authorization": token.value}));
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

  void search() => Get.toNamed(Routes.SEARCH, arguments: token.value);
}
