import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:dio/dio.dart' as dio;
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/modules/home/controllers/notification_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class ApplicationDetailController extends GetxController {
  late final OrderData data;
  final isLoading = false.obs;
  late final String token;

  void onCancelOrder() async {
    try {
      isLoading.value = !isLoading.value;
      await Future.delayed(const Duration(seconds: 1));
      final token = Get.find<HomeController>().token.value;
      var response = await Dio().put(
        "${ConstData.serverUrl}/application/cancel/${data.applicationID}",
        options: Options(
          headers: {"Authorization": token},
        ),
      );
      if (response.statusCode == 200) {
        final notificationController = Get.find<NotificationController>();
        if (!notificationController.isClosed) {
          notificationController.getData();
        }
        isLoading.value = !isLoading.value;
        Get.back();
      }
    } on DioError catch (e, _) {
      var errorMessage = "Unknown error!";
      Get.dialog(AlertDialog(
        title: const Text("Unable to cancel order"),
        content: Text(e.message),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
  }

  @override
  void onInit() {
    data = Get.arguments;
    token = Get.find<HomeController>().token.value;
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

  void showCV() => Get.toNamed(Routes.CV_VIEWER,
      arguments: "${ConstData.serverUrl}/application/cv/${data.cvID}");
  void showProof() => Get.toNamed(Routes.CV_VIEWER,
      arguments:
          "${ConstData.serverUrl}/application/proof/${data.applicationID}");
  void rate() {
    Get.dialog(RatingDialog(
      initialRating: 4.0,
      // your app's name?
      title: const Text(
        'Rate current order',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      enableComment: false,
      // encourage your user to leave a high rating?
      message: const Text(
        'Tap a star to set your rating',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      submitButtonText: 'Submit',
      onSubmitted: (res) async {
        isLoading.value = !isLoading.value;
        try {
          var response =
              await dio.Dio().post("${ConstData.serverUrl}/rating/create",
                  data: {
                    "referral_id": data.referralID,
                    "application_id": data.applicationID,
                    "rating_score": res.rating,
                    "rating_feedback": ""
                  },
                  options: dio.Options(headers: {"Authorization": token}));
          if (response.statusCode == 200 || response.statusCode == 201) {
            await Get.dialog(const AlertDialog(
              title: Text("Rated"),
              content: Text("Thank you for providing rating"),
            ));
            Get.find<NotificationController>().getData();
            Get.back();
          }
        } on dio.DioError catch (e, _) {
          print(e);
          print(e.response!.data);
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
      },
    ));
  }
}
