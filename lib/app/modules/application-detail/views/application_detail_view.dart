import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/job-details/views/job_details_widget.dart';

import '../controllers/application_detail_controller.dart';

class ApplicationDetailView extends GetView<ApplicationDetailController> {
  const ApplicationDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order Detail'),
          centerTitle: true,
          actions: [
            if (controller.data.status < 2)
              IconButton(
                onPressed: controller.onCancelOrder,
                icon: const Icon(Icons.block_rounded),
              )
          ],
        ),
        floatingActionButton: controller.data.status == 2
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton.extended(
                    onPressed: controller.showProof,
                    label: Text("Check Proof"),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  FloatingActionButton(
                    onPressed: controller.showCV,
                    child: const Icon(Icons.file_open),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  FloatingActionButton(
                    onPressed: controller.rate,
                    child: const Icon(Icons.star),
                  )
                ],
              )
            : FloatingActionButton(
                onPressed: controller.showCV,
                child: const Icon(Icons.file_open),
              ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
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
                      child: Text(controller.data.providerName
                          .split(" ")[1][0]
                          .toUpperCase()),
                    ),
                    Expanded(child: Container()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          controller.data.company,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          controller.data.providerName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
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
                        title: "Provider Description",
                        desc: controller.data.desc),
                    const SizedBox(
                      height: 8,
                    ),
                    JobDetail(
                        title: "Company Address",
                        desc: controller.data.companyAddress),
                    const SizedBox(
                      height: 8,
                    ),
                    JobDetail(
                        title: "Customer Name",
                        desc: controller.data.customerName),
                    const SizedBox(
                      height: 8,
                    ),
                    JobDetail(
                        title: "Referral Provider Name",
                        desc: controller.data.providerName),
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
                                      : controller.data.status == 5
                                          ? "Cancelled"
                                          : "Done",
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
