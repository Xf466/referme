import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/modules/home/controllers/notification_controller.dart';
import 'package:referme/app/modules/referral-orders/controllers/referral_orders_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class ReferralOrderDetailsController extends GetxController {
  late final OrderData data;
  late final String token;
  final file = Rx<File?>(null);

  final isLoading = false.obs;

  @override
  void onInit() {
    data = Get.arguments;
    token = Get.find<HomeController>().token.value;
    super.onInit();
  }

  void accept() => sendAcceptRequest("accept");
  void decline() => sendAcceptRequest("decline");

  void completeOrder() async {
    await Get.dialog(const AlertDialog(
      title: Text("Complete Order"),
      content: Text("Please upload proof of verification to complete order"),
    ));
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) {
      return;
    }
    String path = result.files.single.path!;
    file.value = File(path);

    isLoading.value = !isLoading.value;
    var formData = dio.FormData.fromMap({
      "proof_file": await dio.MultipartFile.fromFile(
        file.value!.path,
        filename: file.value!.path.split('/').last,
        contentType: MediaType('application', 'pdf'),
      ),
      "application_id": data.applicationID,
    });
    try {
      var response = await dio.Dio().put(
          "${ConstData.serverUrl}/application/uploadproof",
          data: formData,
          options: dio.Options(headers: {"Authorization": token}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        await Get.dialog(const AlertDialog(
          title: Text("Submitted"),
          content: Text("Sucesfully completed order"),
        ));
        Get.find<ReferralOrdersController>().getData();
        Get.back();
      }
    } on dio.DioError catch (e, _) {
      var errorMessage = "Unknown error!";

      if (e.response?.statusCode == 401) {
        errorMessage = "Please login again";
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
      }
      Get.dialog(AlertDialog(
        title: const Text("Unable to send data"),
        content: Text(errorMessage),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
  }

  void sendAcceptRequest(String isAccept) async {
    isLoading.value = !isLoading.value;
    print(data.applicationID);
    try {
      var response = await dio.Dio().put(
          "${ConstData.serverUrl}/application/$isAccept/${data.applicationID}",
          options: dio.Options(headers: {"Authorization": token}));
      if (response.statusCode == 200) {
        await Get.dialog(const AlertDialog(
          title: Text("Accepted"),
          content: Text("Order Request Accepted"),
        ));
        Get.find<ReferralOrdersController>().getData();
        Get.back();
      }
    } on dio.DioError catch (e, _) {
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

  void showCV() => Get.toNamed(Routes.CV_VIEWER,
      arguments: "${ConstData.serverUrl}/application/cv/${data.cvID}");
}
