import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final isPasswordVisible = false.obs;
  final isPasswordConfirmVisible = false.obs;
  final linkedin = "".obs;
  final firstNameError = Rx<String?>(null);
  final lastNameError = Rx<String?>(null);
  final emailError = Rx<String?>(null);
  final passwordError = Rx<String?>(null);
  final passwordConfirmError = Rx<String?>(null);
  final email = "".obs;
  final password = "".obs;
  final passwordConfirm = "".obs;
  final firstName = "".obs;
  final lastName = "".obs;
  final isLoading = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void togglePasswordConfirm() {
    isPasswordConfirmVisible.value = !isPasswordConfirmVisible.value;
  }

  void register() async {
    if (!doValidate()) return;

    // Change with web implementation

    // Add delay for loading
    isLoading.value = !isLoading.value;
    await Future.delayed(const Duration(seconds: 1));
    try {
      var response =
          await Dio().post("${ConstData.serverUrl}/auth/signup", data: {
        "firstName": firstName.value,
        "lastName": lastName.value,
        "password": password.value,
        "email": email.value,
        "linkedinid": linkedin.value
      });
      if (response.statusCode == 201) {
        // Register success
        await Get.dialog(const AlertDialog(
          title: Text("Success"),
          content: Text("Please verify your email and login to continue"),
        ));
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
      }
    } on DioError catch (e, _) {
      var errorMessage = "Unknown error!";
      if (e.response?.statusCode == 400) {
        if (e.response?.data["message"] ==
            "Email is taken and already in use") {
          errorMessage = "Email is taken, please choose another email";
        } else {
          errorMessage = "Please check the credentials";
        }
      }
      Get.dialog(AlertDialog(
        title: const Text("Unable to register"),
        content: Text(errorMessage),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
  }

  void passwordConfirmEdit(String e) {
    passwordConfirm.value = e;
  }

  void linkedinEdit(String e) {
    linkedin.value = e;
  }

  void login() {
    Get.offNamedUntil(Routes.LOGIN, (route) => false);
  }

  void emailEdit(String e) {
    email.value = e;
  }

  void passwordEdit(String p) {
    password.value = p;
  }

  void firstNameEdit(String n) {
    firstName.value = n;
  }

  void lastNameEdit(String n) {
    lastName.value = n;
  }

  bool doValidate() {
    var result = true;
    if (firstName.value.length < 3) {
      firstNameError.value = "First name should be at least 3 characters";
      result = false;
    } else {
      firstNameError.value = null;
    }
    if (lastName.value.length < 3) {
      lastNameError.value = "Last name should be at least 3 characters";
      result = false;
    } else {
      lastNameError.value = null;
    }
    if (password.value != passwordConfirm.value) {
      passwordError.value = "Password should be the same";
      passwordConfirmError.value = "Password should be the same";
      result = false;
    } else if (password.value.length < 8) {
      passwordError.value = "Password should at least be 8 characters";
      result = false;
    } else {
      passwordError.value = null;
      passwordConfirmError.value = null;
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
