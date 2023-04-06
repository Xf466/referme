import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/modules/account/controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: controller.save, icon: const Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Obx(
          () => controller.isLoading.value
              ? Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  child: const CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => TextField(
                        obscureText: true,
                        onChanged: controller.passwordEdit,
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                            errorText: controller.passwordError.value,
                            filled: true,
                            label: const Text("New Password")),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
