import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                        height: 24,
                      ),
                      Column(
                        children: const [
                          Text(
                            "Login Now",
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
                          onChanged: controller.emailEdit,
                          decoration: InputDecoration(
                              errorText: controller.emailError.value,
                              filled: true,
                              hintText: "Email Address"),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
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
                                : controller.login,
                            child: const Text("Login")),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Get.theme.textTheme.button,
                        ),
                        TextButton(
                            onPressed: controller.register,
                            child: const Text("Register"))
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
