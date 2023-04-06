import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:referme/app/modules/job-details/views/job_details_widget.dart';
import 'package:referme/app/routes/app_pages.dart';

import '../controllers/job_details_controller.dart';

class JobDetailsView extends GetView<JobDetailsController> {
  const JobDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Referral Provider Details'),
          centerTitle: true,
        ),
        body: Obx(() {
          return (controller.isLoading.value)
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
                              child: Text(controller.referral.lastName[0]
                                  .toUpperCase()),
                            ),
                            Expanded(child: Container()),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  controller.referral.title,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  controller.referral.company,
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
                                desc: "\$${controller.referral.price}"),
                            const SizedBox(
                              height: 8,
                            ),
                            JobDetail(
                                title: "Job Description",
                                desc: controller.referral.desc),
                            const SizedBox(
                              height: 8,
                            ),
                            JobDetail(
                                title: "Company Address",
                                desc: controller.referral.address),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      // TODO: add delete referrla
                      if (controller.mine)
                        Column(children: [
                          SizedBox(
                            height: 32,
                            width: double.infinity,
                            child: ElevatedButton(
                              child: const Text("Check Orders"),
                              onPressed: () => Get.toNamed(
                                  Routes.REFERRAL_ORDERS,
                                  arguments: controller.referral.id),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 32,
                            child: OutlinedButton(
                              onPressed: controller.onDeleteReferral,
                              child: const Text("Delete"),
                            ),
                          ),
                        ])
                      else
                        SizedBox(
                          height: 32,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: controller.order,
                              child: const Text("Order Service")),
                        )
                    ],
                  ),
                );
        }));
  }
}
