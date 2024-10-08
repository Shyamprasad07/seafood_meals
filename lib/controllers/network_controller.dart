import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'meals_controller.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final MealController mealController = Get.find();

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(
          'PLEASE CONNECT TO THE INTERNET',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red[400]!,
        mainButton: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.cancel, color: Colors.white),
        ),
        icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35),
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.rawSnackbar(
          messageText: const Text(
            'Back online',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          isDismissible: true,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green[400]!,
          snackStyle: SnackStyle.GROUNDED,
        );
        Get.closeCurrentSnackbar();
      }

      mealController.fetchMeals();
    }
  }
}
