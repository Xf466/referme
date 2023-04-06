import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:get/get.dart';

import '../controllers/cv_viewer_controller.dart';

class CvViewerView extends GetView<CvViewerController> {
  const CvViewerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Viewer'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loading.value
            ? const Center(child: CircularProgressIndicator())
            : const PDF().cachedFromUrl(
                controller.url,
                headers: {
                  "Authorization": controller.token,
                },
                placeholder: (progress) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (error) => Center(child: Text(error.toString())),
              ),
      ),
    );
  }
}
