import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/home/widgets/order_tile.dart';
import 'package:referme/app/modules/referral-orders/controllers/referral_orders_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class ReferralOrdersView extends GetView<ReferralOrdersController> {
  const ReferralOrdersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Service Orders"),
            bottom: const TabBar(tabs: [
              Tab(
                text: "On Going",
              ),
              Tab(text: "Completed")
            ]),
          ),
          body: TabBarView(children: [
            Obx(
              () => controller.isLoading.value
                  ? Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      child: const CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async => controller.getData(),
                      child: Obx(
                        () => ListView.separated(
                            itemBuilder: (c, i) => OrderTile(
                                mine: true,
                                callback: () => Get.toNamed(
                                    Routes.REFERRAL_ORDER_DETAILS,
                                    arguments: controller.ongoing[i]),
                                status: controller.ongoing[i].status,
                                name: controller.ongoing[i].company,
                                company: controller.ongoing[i].customerName),
                            separatorBuilder: ((context, index) =>
                                const Divider()),
                            itemCount: controller.ongoing.length),
                      ),
                    ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      child: const CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () async => controller.getData(),
                      child: Obx(
                        () => ListView.separated(
                            itemBuilder: (c, i) => OrderTile(
                                mine: true,
                                callback: () => Get.toNamed(
                                    Routes.REFERRAL_ORDER_DETAILS,
                                    arguments: controller.done[i]),
                                status: controller.done[i].status,
                                name: controller.done[i].providerName,
                                company: controller.done[i].company),
                            separatorBuilder: ((context, index) =>
                                const Divider()),
                            itemCount: controller.done.length),
                      ),
                    ),
            )
          ])),
    );
  }
}
