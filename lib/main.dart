import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51LnhqfBQ0vHyEVutEajqPuk9oa4ZLYAmGwUVxQidQzABl5RytDISEcq4F4rslM2Ml9LDRigdKfuPr4X7QyC8oahu00K0H01bmT";
  var referemeTheme = ThemeDecoder.decodeThemeData(
      json.decode(await rootBundle.loadString('assets/theme.json')));

  runApp(
    GetMaterialApp(
      title: "RefereMe",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: referemeTheme,
    ),
  );
}
