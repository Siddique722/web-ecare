import 'package:get/get.dart';

class WalletController extends GetxController {
  // The total earnings from affiliates
  var totalEarnings = 5000.0.obs;

  // Boolean to track if earnings are hidden or visible
  var isHidden = false.obs;

  // Function to toggle the visibility of earnings
  void toggleVisibility() {
    isHidden.value = !isHidden.value;
  }

  // Function to handle withdrawal (for now, just reset total earnings)
  void withdrawEarnings() {
    totalEarnings.value = 0.0; // Reset after withdrawal (or reduce by the withdrawn amount)
  }
}
