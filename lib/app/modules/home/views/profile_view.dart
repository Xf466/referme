import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/modules/home/controllers/profile_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class Content {
  final IconData icon;
  final String title;
  final VoidCallback action;

  Content({required this.icon, required this.title, required this.action});
}

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final _contents = [
    Content(
      icon: Icons.person,
      title: "Account",
      action: () => Get.toNamed(Routes.ACCOUNT),
    ),
    Content(
      icon: Icons.library_books_rounded,
      title: "My Referral Service",
      action: () => Get.toNamed(Routes.MY_REFERRAL),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 56,
                    backgroundColor: Get.theme.primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    '${homeCtrl.fname.value} ${homeCtrl.lname.value}',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(homeCtrl.email.value),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: ListView.builder(
                  itemCount: _contents.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48.0, vertical: 16.0),
                  itemBuilder: (ctx, index) {
                    final content = _contents[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        leading: Icon(content.icon),
                        title: Text(content.title),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: content.action,
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 42.0,
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: ElevatedButton(
                onPressed: controller.logout,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFB33951)),
                ),
                child: const Text('LOGOUT'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
