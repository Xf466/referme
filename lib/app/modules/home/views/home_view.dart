import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/home/views/dashboard_view.dart';
import 'package:referme/app/modules/home/views/notification_view.dart';
import 'package:referme/app/modules/home/views/profile_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              backgroundColor: Get.theme.primaryColor,
              unselectedItemColor: Colors.grey.withOpacity(0.6),
              selectedItemColor: Colors.white,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              iconSize: 32,
              currentIndex: controller.currentPage.value,
              onTap: controller.changePage,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: "Notifications"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_box), label: "Profile"),
              ]),
        ),
        body: Obx(
          () => SafeArea(
            child: controller.currentPage.value == 0
                ? const DashboardView()
                : controller.currentPage.value == 1
                    ? const NotificationView()
                    : ProfileView(),
          ),
        ));
  }
}
