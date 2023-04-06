import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:referme/app/data/const.dart';
import 'package:referme/app/modules/home/controllers/home_controller.dart';
import 'package:referme/app/routes/app_pages.dart';

class ApplyJobController extends GetxController {
  final file = Rx<File?>(null);
  final isLoading = false.obs;
  late final String token;
  late final Map data;

  @override
  void onInit() {
    token = Get.find<HomeController>().token.value;
    data = Get.arguments;
    super.onInit();
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    return (await dio.Dio().post("${ConstData.serverUrl}/payment",
            data: {
              "name": data['name'],
              "email": data['email'],
              "amount": data['price']
            },
            options: dio.Options(headers: {"Authorization": token})))
        .data;
  }

  void apply() async {
    //doRequest();
    final data = await _createTestPaymentSheet();
    // create some billingdetails
    final billingDetails = BillingDetails(
      name: data['name'],
      email: data['email'],
      phone: '+61412424',
      address: const Address(
        city: 'Melbourne',
        country: 'AU',
        line1: '1 Swaston Street',
        line2: '',
        state: 'Victori',
        postalCode: '3000',
      ),
    ); // mocked data for tests

    // 2. initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Main params
        paymentIntentClientSecret: data['paymentIntent'],
        merchantDisplayName: 'ReferMe',
        // Customer params
        customerId: data['customer'],
        customerEphemeralKeySecret: data['ephemeralKey'],
        // Extra params
        //applePay: PaymentSheetApplePay(
        //merchantCountryCode: 'DE',
        //),
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'AU',
          testEnv: true,
        ),
        style: ThemeMode.dark,
        //appearance: const PaymentSheetAppearance(
        //colors: PaymentSheetAppearanceColors(
        //background: Colors.lightBlue,
        //primary: Colors.blue,
        //componentBorder: Colors.red,
        //),
        //shapes: PaymentSheetShape(
        //borderWidth: 4.0,
        //shadow: PaymentSheetShadowParams(color: Colors.red),
        //),
        //primaryButton: PaymentSheetPrimaryButtonAppearance(
        //shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
        //colors: PaymentSheetPrimaryButtonTheme(
        //light: PaymentSheetPrimaryButtonThemeColors(
        //background: Color.fromARGB(255, 231, 235, 30),
        //text: Color.fromARGB(255, 235, 92, 30),
        //border: Color.fromARGB(255, 235, 92, 30),
        //),
        //),
        //),
        //),
        billingDetails: billingDetails,
      ),
    );
    try {
      await Stripe.instance.presentPaymentSheet();
      // await Stripe.instance.confirmPaymentSheetPayment();
      // Success
      // Upload CV
      doRequest();
    } on StripeException catch (e, _) {
      if (e.error.code == FailureCode.Canceled) {
        Get.dialog(const AlertDialog(
          title: Text("Payment Cancelled"),
          content: Text("Please click order to try again"),
        ));
      } else if (e.error.code == FailureCode.Failed) {
        Get.dialog(const AlertDialog(
          title: Text("Payment Failed"),
          content: Text("Please try again later"),
        ));
      }
    }
  }

  void backToHome() {
    Get.offNamedUntil(Routes.HOME, (route) => false);
  }

  void selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String path = result.files.single.path!;
      file.value = File(path);
    }
  }

  void doRequest() async {
    isLoading.value = !isLoading.value;
    var formData = dio.FormData.fromMap({
      "cv_file": await dio.MultipartFile.fromFile(
        file.value!.path,
        filename: file.value!.path.split('/').last,
        contentType: MediaType('application', 'pdf'),
      ),
      "referral_id": data['refID'],
      // Might get removed later
      "application_status": 'pending'
    });
    try {
      var response = await dio.Dio().post("${ConstData.serverUrl}/application",
          data: formData,
          options: dio.Options(headers: {"Authorization": token}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.dialog(AlertDialog(
          title: const Text("Submitted"),
          content: const Text(
              "Order has successfully been created, please check orders tab on the home page!"),
          actions: [
            OutlinedButton(onPressed: backToHome, child: const Text("Ok"))
          ],
        ));
      }
    } on dio.DioError catch (e, _) {
      var errorMessage = "Unknown error!";

      if (e.response?.statusCode == 401) {
        errorMessage = "Please login again";
        Get.offNamedUntil(Routes.LOGIN, (route) => false);
      }
      Get.dialog(AlertDialog(
        title: const Text("Unable to send data"),
        content: Text(errorMessage),
      ));
    } finally {
      isLoading.value = !isLoading.value;
    }
  }
}
