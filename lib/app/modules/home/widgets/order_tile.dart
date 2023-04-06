import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:referme/app/routes/app_pages.dart';

class OrderTile extends StatelessWidget {
  late final String name;
  late final String company;
  late final int status;
  late final VoidCallback callback;
  late final bool mine;

  void showDetail() {
    callback();
  }

  OrderTile(
      {required this.name,
      required this.company,
      required this.mine,
      required this.status,
      required this.callback});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: Get.theme.primaryColor,
          child: status == 0
              ? const Icon(Icons.timer)
              : status == 1
                  ? const Icon(Icons.run_circle)
                  : status == 2
                      ? const Icon(Icons.done_all)
                      : status == 3
                          ? const Icon(Icons.error)
                          : status == 5
                              ? const Icon(Icons.block)
                              : const Icon(Icons.stars)),
      title: Text(company),
      subtitle: Text(name),
      onTap: showDetail,
      trailing: Chip(
        label: Text(status == 0
            ? "Waiting Approval"
            : status == 1
                ? "Referring"
                : status == 2
                    ? "Awaiting Rating"
                    : status == 3
                        ? "Rejected"
                        : status == 5
                            ? "Cancelled"
                            : "Done"),
      ),
    );
  }
}
