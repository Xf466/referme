import '../controllers/referral_order_details_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/job-details/views/job_details_widget.dart';

class ReferralOrderDetailsView extends GetView<ReferralOrderDetailsController> {
  const ReferralOrderDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Referral Order Detail'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.showCV,
          child: const Icon(Icons.file_open),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            CircleAvatar(
                              backgroundColor: Get.theme.primaryColor,
                              child: Text(controller.data.customerName
                                  .split(" ")[1][0]),
                            ),
                            Expanded(child: Container()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  controller.data.company,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  controller.data.providerName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 8,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            JobDetail(
                                title: "Referral Fee",
                                desc: "\$${controller.data.price}"),
                            const SizedBox(
                              height: 8,
                            ),
                            JobDetail(
                              title: "Order Status",
                              desc: controller.data.status == 0
                                  ? "Awaiting Approval"
                                  : controller.data.status == 1
                                      ? "Proccessing"
                                      : controller.data.status == 2
                                          ? "Awaiting Review"
                                          : controller.data.status == 3
                                              ? "Rejected"
                                              : "Done",
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      if (controller.data.status == 1)
                        ElevatedButton(
                            onPressed: controller.completeOrder,
                            child: const Text("Complete Order")),
                      if (controller.data.status == 0)
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: controller.accept,
                                child: const Text("Accept Order")),
                            const SizedBox(
                              width: 4,
                            ),
                            ElevatedButton(
                                onPressed: controller.decline,
                                child: const Text("Decline Order")),
                          ],
                        )
                    ],
                  ),
                ),
        ));
  }
}
