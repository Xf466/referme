import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/register/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Center(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 32),
                    shrinkWrap: true,
                    children: [
                      Image.asset(
                        './assets/img/logo.png',
                        height: 150,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Column(
                        children: const [
                          Text(
                            "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 32),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Please enter the details below to continue"),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.firstNameEdit,
                          decoration: InputDecoration(
                              errorText: controller.firstNameError.value,
                              filled: true,
                              hintText: "First Name"),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.lastNameEdit,
                          decoration: InputDecoration(
                              errorText: controller.lastNameError.value,
                              filled: true,
                              hintText: "Last Name"),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.emailEdit,
                          decoration: InputDecoration(
                              errorText: controller.emailError.value,
                              filled: true,
                              hintText: "Email Address"),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.passwordEdit,
                          obscureText: !controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Password',
                              errorText: controller.passwordError.value,
                              suffixIcon: IconButton(
                                  onPressed: controller.togglePassword,
                                  icon: const Icon(Icons.remove_red_eye))),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.passwordConfirmEdit,
                          obscureText:
                              !controller.isPasswordConfirmVisible.value,
                          decoration: InputDecoration(
                              filled: true,
                              hintText: 'Confirm Password',
                              errorText: controller.passwordConfirmError.value,
                              suffixIcon: IconButton(
                                  onPressed: controller.togglePasswordConfirm,
                                  icon: const Icon(Icons.remove_red_eye))),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        onChanged: controller.linkedinEdit,
                        decoration: const InputDecoration(
                            filled: true,
                            hintText: "LinkedIn Profile (Optional)"),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
                child: Column(
                  children: [
                    SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.register,
                            child: const Text("Register")),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Get.theme.textTheme.button,
                        ),
                        TextButton(
                            onPressed: controller.login,
                            child: const Text("Login"))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Obx(
            () => Container(
              child: !controller.isLoading.value
                  ? Container()
                  : Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: Center(
                        child: Card(
                          elevation: 10,
                          child: Container(
                            width: 100,
                            color: Colors.white,
                            height: 100,
                            padding: const EdgeInsets.all(32),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    ));
  }
}
