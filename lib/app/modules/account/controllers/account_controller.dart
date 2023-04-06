import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/account/controllers/change_password_controller.dart';
import 'package:referme/app/modules/account/views/change_password_view.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class AccountController extends GetxController {
  final isDataChanged = false.obs;
  final fname = "".obs;
  final lname = "".obs;
  final email = "".obs;
  final linkedin = "".obs;
  final fnameError = Rx<String?>(null);
  final lnameError = Rx<String?>(null);
  final emailError = Rx<String?>(null);
  final linkedinError = Rx<String?>(null);
  final isLoading = false.obs;
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final linkedinController = TextEditingController();
  late final String token;
  late final HomeController c;

  void fnameEdit(String n) {
    fname.value = n;
    _updateDataChange();
  }

  void lnameEdit(String n) {
    lname.value = n;
    _updateDataChange();
  }

  void emailEdit(String n) {
    email.value = n;
    _updateDataChange();
  }

  void linkedinEdit(String n) {
    linkedin.value = n;
    _updateDataChange();
  }

  @override
  void onInit() {
    c = Get.find<HomeController>();
    token = c.token.value;
    fnameController.text = fname.value = c.fname.value;
    lnameController.text = lname.value = c.lname.value;
    emailController.text = email.value = c.email.value;
    linkedinController.text = linkedin.value = c.linkedin.value;
    super.onInit();
  }

  void _updateDataChange() {
    isDataChanged.value = !(fname.value == c.fname.value &&
        lname.value == c.fname.value &&
        email.value == c.email.value &&
        linkedin.value == c.linkedin.value);
  }

  void save() {
    var valid = true;

    if (fname.value.isEmpty) {
      fnameError.value = "Must not be empty";
      valid = false;
    } else {
      fnameError.value = null;
    }
    if (lname.value.isEmpty) {
      lnameError.value = "Must not be empty";
      valid = false;
    } else {
      lnameError.value = null;
    }
    if (email.value.isEmpty) {
      emailError.value = "Must not be empty";
      valid = false;
    } else {
      emailError.value = null;
    }

    if (!valid) return;
    doRequest();
  }

  void onChangePassword() async {
    Get.put<ChangePasswordController>(ChangePasswordController());
    await Get.to(const ChangePasswordView());
    Get.delete<ChangePasswordController>();
  }

  void doRequest() async {
    isLoading.value = !isLoading.value;
    try {
      var response = await Dio().put("${ConstData.serverUrl}/user/update/",
          data: {
            "firstName": fname.value,
            "lastName": lname.value,
            "email": email.value,
            "linkedinid": linkedin.value
          },
          options: Options(headers: {"Authorization": token}));
      if (response.statusCode == 200) {
        await Get.dialog(const AlertDialog(
          title: Text("Success"),
          content: Text("Successfully updated profile"),
        ));
        c.fname.value = fname.value;
        c.lname.value = lname.value;
        c.email.value = email.value;
        c.linkedin.value = linkedin.value;

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

