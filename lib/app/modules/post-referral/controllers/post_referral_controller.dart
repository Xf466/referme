import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/routes/app_pages.dart';

class PostReferralController extends GetxController {
  final job = "".obs;
  final company = "".obs;
  final price = "".obs;
  final desc = "".obs;
  final skill = "".obs;
  final address = "".obs;
  final jobError = Rx<String?>(null);
  final companyError = Rx<String?>(null);
  final priceError = Rx<String?>(null);
  final descError = Rx<String?>(null);
  final skillError = Rx<String?>(null);
  final addressError = Rx<String?>(null);
  final isLoading = false.obs;
  late final String token;

  void jobEdit(String n) => job.value = n;
  void companyEdit(String n) => company.value = n;
  void priceEdit(String n) => price.value = n;
  void descEdit(String n) => desc.value = n;
  void skillEdit(String n) => skill.value = n;
  void addressEdit(String n) => address.value = n;

  @override
  void onInit() {
    token = Get.arguments;
    super.onInit();
  }

  void add() {
    var valid = true;

    if (job.value.isEmpty) {
      jobError.value = "Must not be empty";
      valid = false;
    } else {
      jobError.value = null;
    }
    if (company.value.isEmpty) {
      companyError.value = "Must not be empty";
      valid = false;
    } else {
      companyError.value = null;
    }
    if (price.value.isEmpty) {
      priceError.value = "Must not be empty";
      valid = false;
    } else {
      priceError.value = null;
    }
    if (desc.value.isEmpty) {
      descError.value = "Must not be empty";
      valid = false;
    } else {
      descError.value = null;
    }

    if (!valid) return;
    doRequest();
  }

  void doRequest() async {
    isLoading.value = !isLoading.value;
    try {
      var response = await Dio().post("${ConstData.serverUrl}/referral/create",
          data: {
            "job_title": job.value,
            "price": price.value,
            "job_description": desc.value,
            "company": company.value,
            "address": address.value
          },
          options: Options(headers: {"Authorization": token}));
      if (response.statusCode == 201) {
        await Get.dialog(const AlertDialog(
          title: Text("Success"),
          content: Text("Successfully created a new referral posting"),
        ));
        Get.back();
      }
    } on DioError catch (e, _) {
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
