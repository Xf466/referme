import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:referme/app/modules/home/models/referral.dart';
import 'package:referme/app/routes/app_pages.dart';

class JobTile extends StatelessWidget {
  final Referral referral;
  final bool mine;
  const JobTile({required this.referral, this.mine = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        // TODO: Added id data passing to the details page
        onTap: () =>
            Get.toNamed(Routes.JOB_DETAILS, arguments: [referral, mine]),
        child: Card(
          elevation: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // TODO:// change this to user initial
                      CircleAvatar(
                        backgroundColor: Get.theme.primaryColor,
                        child: Text(referral.lastName[0].toUpperCase()),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            referral.company,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Text(referral.title)
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(referral.rating == 0
                          ? "No rating"
                          : referral.rating.toString()),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(Icons.star)
                    ],
                  )
                ]),
          ),
        ),
      );
}
