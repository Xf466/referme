import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/post_referral_controller.dart';

class PostReferralView extends GetView<PostReferralController> {
  const PostReferralView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Referral Service'),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.add,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isLoading.value
              ? Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                  child: const CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.jobEdit,
                          decoration: InputDecoration(
                              errorText: controller.jobError.value,
                              filled: true,
                              label: const Text("Job Title")),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.companyEdit,
                          decoration: InputDecoration(
                              errorText: controller.companyError.value,
                              filled: true,
                              label: const Text("Company")),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          keyboardType: TextInputType.number,
                          onChanged: controller.priceEdit,
                          decoration: InputDecoration(
                              errorText: controller.priceError.value,
                              filled: true,
                              prefix: Text('\$ '),
                              label: const Text("Referral Fee")),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.descEdit,
                          decoration: InputDecoration(
                              errorText: controller.descError.value,
                              filled: true,
                              label: const Text("Description")),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          onChanged: controller.addressEdit,
                          decoration: InputDecoration(
                              errorText: controller.addressError.value,
                              filled: true,
                              label: const Text("Company Location")),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
