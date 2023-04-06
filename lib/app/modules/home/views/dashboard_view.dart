import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/home/widgets/job_tile.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  "Good Day, ${controller.name.value.capitalizeFirst}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 24),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: controller.search,
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Newest Referral Providers",
            style: TextStyle(fontSize: 42),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () async => controller.getData(),
                    child: ListView.builder(
                        itemCount: controller.referrals.length,
                        itemBuilder: (c, i) =>
                            JobTile(referral: controller.referrals[i])),
                  ),
          ))
        ],
      ),
    ));
  }
}
