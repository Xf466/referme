import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final isPasswordVisible = false.obs;
  final emailError = Rx<String?>(null);
  final passwordError = Rx<String?>(null);
  final email = "".obs;
  final password = "".obs;
  final isLoading = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    if (!doValidate()) return;

    // Change with web implementation

    // Add delay for loading
    isLoading.value = !isLoading.value;
    await Future.delayed(const Duration(seconds: 1));
    try {
      var response =
          await Dio().post("${ConstData.serverUrl}/auth/signin", data: {
        "password": password.value,
        "email": email.value,
      });
      if (response.statusCode == 200) {
        // Register success
        await const FlutterSecureStorage()
            .write(key: "token", value: response.data["accessToken"]);
        await const FlutterSecureStorage()
            .write(key: "fname", value: response.data['firstName']);
        await const FlutterSecureStorage()
            .write(key: "lname", value: response.data['lastName']);
        await const FlutterSecureStorage()
            .write(key: "email", value: email.value);
        await const FlutterSecureStorage()
            .write(key: "linkedin", value: response.data['linkedinid']);
        Get.offNamedUntil(Routes.HOME, (route) => false);
      }
    } on DioError catch (e, _) {
      var errorMessage = "Unknown error!";
      if (e.response?.statusCode == 404 || e.response?.statusCode == 401) {
        errorMessage = "Please check the credentials";
      }
      if (e.response?.statusCode == 403) {
        errorMessage = "Please verify your email";
      }
      Get.dialog(AlertDialog(
        title: const Text("Unable to login"),
        content: Text(errorMessage),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
  }

  void register() {
    Get.offNamedUntil(Routes.REGISTER, (route) => false);
  }

  void emailEdit(String e) {
    email.value = e;
  }

  void passwordEdit(String p) {
    password.value = p;
  }

  bool doValidate() {
    var result = true;
    if (password.value.length < 8) {
      passwordError.value = "Password should at least be 8 characters";
      result = false;
    } else {
      passwordError.value = null;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.value);
    if (!emailValid) {
      emailError.value = "Invalid email";
      result = false;
    } else {
      emailError.value = null;
    }
    return result;
  }
}
