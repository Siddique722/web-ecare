import 'dart:js' as js;

void startRazorpayPaymentOnWeb(Map<String, dynamic> options) {
  print("Starting Razorpay payment on web...");
  js.context.callMethod('Razorpay', [js.JsObject.jsify(options)])?.callMethod('open');
}