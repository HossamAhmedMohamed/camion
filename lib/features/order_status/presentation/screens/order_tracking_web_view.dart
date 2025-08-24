import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTrackingWebView extends StatefulWidget {
  const OrderTrackingWebView({super.key, required this.orderTrackingUrl});
  final String orderTrackingUrl;
  @override
  State<OrderTrackingWebView> createState() => _OrderTrackingWebViewState();
}

class _OrderTrackingWebViewState extends State<OrderTrackingWebView> {
  InAppWebViewController? webViewController;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   toolbarHeight: 50.h,
      // ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.orderTrackingUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });

              // if (url != null) {
              //   String urlString = url.toString();

              //   // // إذا كان URL يحتوي على success
              //   // if (urlString.contains('success') ||
              //   //     urlString.contains('payment_intent') ||
              //   //     urlString.contains('payment_status=paid')) {
              //   //   _handlePaymentSuccess();
              //   // }

              //   // if (urlString.contains('cancel') ||
              //   //     urlString.contains('failed') ||
              //   //     urlString.contains('payment_status=failed')) {
              //   //   _handlePaymentFailure();
              //   // }
              // }
            },
            // onReceivedError: (controller, request, error) {
            //   setState(() {
            //     isLoading = false;
            //   });

            //   ScaffoldMessenger.of(context).showSnackBar(
            //     const SnackBar(
            //       content: Text("حدث خطأ في تحميل صفحة الدفع"),
            //       backgroundColor: Colors.red,
            //     ),
            //   );
            // },
          ),

          // Loading Indicator
          if (isLoading)
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Order Tracking Loading...",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
