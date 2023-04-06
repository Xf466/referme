import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/routes/app_pages.dart';

import '../../home/models/referral.dart';

class SearchController extends GetxController {
  final referrals = <Referral>[].obs;
  late final String token;
  final isLoading = false.obs;
  final jobError = Rx<String?>(null);
  final locationError = Rx<String?>(null);
  final companyError = Rx<String?>(null);
  final job = "".obs;
  final location = "".obs;
  final asc = false.obs;
  final company = "".obs;

  void onJobChange(String n) {
    job.value = n;
  }

  void onCompanyChange(String n) {
    company.value = n;
  }

  void onLocationChange(String n) {
    location.value = n;
  }

  void onAscChange(bool n) {
    asc.value = n;
  }

  @override
  void onInit() {
    token = Get.arguments;
    super.onInit();
  }

  void search() async {
    Map<String, String> queryData = {};
    queryData.addIf(job.isNotEmpty, "job_title", job.value);
    queryData.addIf(company.isNotEmpty, "company", company.value);
    queryData.addIf(location.isNotEmpty, "location", location.value);
    queryData['asc'] = asc.value ? "true" : "false";
    isLoading.value = !isLoading.value;
    try {
      var response = await Dio().get("${ConstData.serverUrl}/search/referral/",
          queryParameters: queryData,
          options: Options(headers: {"Authorization": token}));
      if (response.statusCode == 200) {
        referrals.clear();
        for (var element in (response.data as List<dynamic>)) {
          referrals.add(Referral.fromJSON(element as Map));
        }
      }
    } on DioError catch (e, _) {
      print(e);
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
}
