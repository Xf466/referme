import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/post_success_controller.dart';

class PostSuccessView extends GetView<PostSuccessController> {
  const PostSuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostSuccessView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PostSuccessView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
