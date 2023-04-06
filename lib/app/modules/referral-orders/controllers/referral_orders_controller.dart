import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/modules/home/controllers/notification_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class ReferralOrdersController extends GetxController {
  late final String token;
  late final int id;
  final ongoing = <OrderData>[].obs;
  final done = <OrderData>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    token = Get.find<HomeController>().token.value;
    id = Get.arguments;
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading.value = !isLoading.value;
    try {
      // TODO: Change route url
      var response = await Dio().get("${ConstData.serverUrl}/applications/$id",
          options: Options(headers: {"Authorization": token}));
      if (response.statusCode == 200) {
        ongoing.clear();
        done.clear();
        for (var element in (response.data as List<dynamic>)) {
          print(element);
          if (element["application_status"] != "done" &&
              element['application_status'] != "declined" &&
              element['application_status'] != "cancelled") {
            ongoing.add(OrderData.formJSON(element));
          } else {
            done.add(OrderData.formJSON(element));
          }
        }
      }
    } on DioError catch (e, _) {
      print(e.response!.data);
      print(e.type);
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
