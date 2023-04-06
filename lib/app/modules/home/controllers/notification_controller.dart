import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class OrderData {
  String providerName;
  String customerName;
  String company;
  String price;
  String desc;
  String companyAddress;
  String cvID;
  int applicationID;
  int referralID;
  int status;
  String fileName;

  OrderData(
      {required this.providerName,
      required this.company,
      required this.customerName,
      required this.referralID,
      required this.price,
      required this.applicationID,
      required this.desc,
      required this.cvID,
      required this.companyAddress,
      required this.status,
      required this.fileName});

  // replace with name
  OrderData.formJSON(dynamic data)
      : providerName = data['referral_name'].toString().capitalize!,
        customerName = data['application_name'].toString().capitalize!,
        applicationID = data['application_id'],
        referralID = data['referral_id'],
        company = data['company'],
        price = data['price'],
        desc = data['job_description'],
        companyAddress = data['address'],
        status = data['application_status'] == "pending"
            ? 0
            : data['application_status'] == "referring"
                ? 1
                : data['application_status'] == "rating"
                    ? 2
                    : data['application_status'] == "declined"
                        ? 3
                        : data['application_status'] == 'cancelled'
                            ? 5
                            : 4,
        cvID = data['application_file_name'].toString().split(".")[0],
        fileName = data['application_file_name'];
}

class NotificationController extends GetxController {
  late final String token;
  final ongoing = <OrderData>[].obs;
  final done = <OrderData>[].obs;
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
      // TODO: Change route url
      var response = await Dio().get("${ConstData.serverUrl}/applications/me",
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
