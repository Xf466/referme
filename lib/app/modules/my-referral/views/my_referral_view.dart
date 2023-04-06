import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/home/widgets/job_tile.dart';
import 'package:referme/app/routes/app_pages.dart';

import '../controllers/my_referral_controller.dart';

class MyReferralView extends GetView<MyReferralController> {
  const MyReferralView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Referrals'),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
            child: controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.referrals.isEmpty
                    ? RefreshIndicator(
                        onRefresh: () async => controller.getData(),
                        child: Stack(
                          children: [
                            ListView(),
                            Container(
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: double.infinity,
                              child: const Text(
                                  "Click the plus button to create a referral"),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async => controller.getData(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: ListView.builder(
                              itemCount: controller.referrals.length,
                              itemBuilder: (c, i) => JobTile(
                                  mine: true,
                                  referral: controller.referrals.elementAt(i))),
                        ),
                      )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed(Routes.POST_REFERRAL, arguments: controller.token),
        child: const Icon(Icons.add),
      ),
    );
  }
}
