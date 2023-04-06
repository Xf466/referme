import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/modules/home/models/referral.dart';
import 'package:referme/app/routes/app_pages.dart';

class JobDetailsController extends GetxController {
  final isLoading = false.obs;
  late final Rx<String> token;
  late final Referral referral;
  late final bool mine;
  late final String email;
  late final String name;

  @override
  void onInit() {
    referral = Get.arguments[0];
    mine = Get.arguments[1];
    var c = Get.find<HomeController>();
    email = c.email.value;
    name = "${c.fname.value} ${c.lname.value}";
    token = c.token;
    super.onInit();
  }

  void order() => Get.toNamed(Routes.APPLY_JOB, arguments: {
        "refID": referral.id,
        "price": int.parse(referral.price.split(".")[0]) * 100,
        "email": email,
        "name": name
      });

  void onDeleteReferral() async {
    try {
      var response = await Dio().delete(
        "${ConstData.serverUrl}/referral/delete/${referral.id}",
        options: Options(headers: {"Authorization": token}),
      );
      if (response.statusCode == HttpStatus.ok) {
        Get.back();
      }
    } on DioError catch (e) {
      var errorMessage = "Unknown error!";
      print(e);

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
}
