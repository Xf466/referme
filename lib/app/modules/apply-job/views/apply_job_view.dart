import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/apply_job_controller.dart';

class ApplyJobView extends GetView<ApplyJobController> {
  const ApplyJobView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Service'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Flex(
                    direction: Axis.vertical,
                    children: [
                      const Text(
                          "Please choose a resume below to be used on the referral request"),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: controller.selectFile,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.4),
                                  width: 1)),
                          child: Column(children: [
                            Icon(
                              Icons.file_open,
                              size: 48,
                              color: Get.theme.primaryColor,
                            ),
                            Obx(() => Text(controller.file.value == null
                                ? "Select File"
                                : controller.file.value!.path.split("/").last))
                          ]),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      SizedBox(
                        height: 38,
                        width: double.infinity,
                        child: Obx(
                          () => ElevatedButton(
                              onPressed: controller.file.value == null
                                  ? null
                                  : controller.apply,
                              child: const Text("Order & Pay")),
                        ),
                      )
                    ],
                  ),
          ),
        ));
  }
}
