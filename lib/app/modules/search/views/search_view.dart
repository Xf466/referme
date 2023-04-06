import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:referme/app/modules/home/widgets/job_tile.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => SwitchListTile(
                  title: const Text("Sort by cheapest price"),
                  value: controller.asc.value,
                  onChanged: controller.onAscChange)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => TextField(
                    onChanged: controller.onJobChange,
                    decoration: InputDecoration(
                        hintText: "Manager",
                        label: const Text('Position'),
                        filled: true,
                        errorText: controller.jobError.value,
                        suffixIcon: const Icon(Icons.search)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => TextField(
                    onChanged: controller.onLocationChange,
                    decoration: InputDecoration(
                        label: const Text("Location"),
                        hintText: "Melbourne",
                        filled: true,
                        errorText: controller.locationError.value,
                        suffixIcon: const Icon(Icons.location_pin)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () => TextField(
                    onChanged: controller.onCompanyChange,
                    decoration: InputDecoration(
                        label: const Text("Company"),
                        hintText: "Target Catcher",
                        filled: true,
                        errorText: controller.companyError.value,
                        suffixIcon: const Icon(Icons.cases_rounded)),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: controller.search, child: const Text("Search")),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: controller.referrals.length + 1,
                        itemBuilder: (c, i) => i == 0
                            ? Text(
                                "Found ${controller.referrals.length}",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w400),
                              )
                            : JobTile(
                                referral:
                                    controller.referrals.elementAt(i - 1))),
              ))
            ],
          ),
        ));
  }
}
