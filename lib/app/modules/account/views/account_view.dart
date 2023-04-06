import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        actions: [
          Obx(() {
            return IconButton(
                onPressed:
                    (controller.isDataChanged.value) ? controller.save : null,
                icon: const Icon(Icons.save));
          }),
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
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => TextField(
                        onChanged: controller.fnameEdit,
                        controller: controller.fnameController,
                        decoration: InputDecoration(
                            errorText: controller.fnameError.value,
                            filled: true,
                            label: const Text("First Name")),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => TextField(
                        onChanged: controller.lnameEdit,
                        controller: controller.lnameController,
                        decoration: InputDecoration(
                            errorText: controller.lnameError.value,
                            filled: true,
                            label: const Text("Last Name")),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => TextField(
                        onChanged: controller.emailEdit,
                        controller: controller.emailController,
                        decoration: InputDecoration(
                            errorText: controller.emailError.value,
                            filled: true,
                            label: const Text("Email")),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => TextField(
                        onChanged: controller.linkedinEdit,
                        controller: controller.linkedinController,
                        decoration: InputDecoration(
                            errorText: controller.linkedinError.value,
                            filled: true,
                            label: const Text("LinkedIn")),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 45,
                      child: OutlinedButton(
                        onPressed: controller.onChangePassword,
                        child: const Text('Change Password'),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

