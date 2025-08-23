import 'package:camion/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PaymentWebViewPage extends StatefulWidget {
  final String checkoutUrl;
  // final String orderId;

  const PaymentWebViewPage({
    super.key,
    required this.checkoutUrl,
    // required this.orderId,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
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
            initialUrlRequest: URLRequest(
              url: WebUri(
                widget.checkoutUrl,
              ),
            ),
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

               
              if (url != null) {
                String urlString = url.toString();

                // إذا كان URL يحتوي على success
                if (urlString.contains('success') ||
                    urlString.contains('payment_intent') ||
                    urlString.contains('payment_status=paid')) {
                  _handlePaymentSuccess();
                }

               
                if (urlString.contains('cancel') ||
                    urlString.contains('failed') ||
                    urlString.contains('payment_status=failed')) {
                  _handlePaymentFailure();
                }
              }
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
                      "Payment page is loading, please wait...",
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

  void _handlePaymentSuccess() {
    // إظهار رسالة نجاح
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Successful payment "),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // العودة للصفحة الرئيسية أو صفحة الطلبات بعد ثانيتين
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        GoRouter.of(
          context,
        ).pushReplacement(AppRouter.selectingFromBottomNavBar);
      }

      // يمكنك إضافة navigation لصفحة الطلبات هنا
      // Navigator.pushReplacementNamed(context, '/orders');
    });
  }

  void _handlePaymentFailure() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Payment failed"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );

    // العودة للصفحة السابقة
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        GoRouter.of(context).pop();
      }
    });
  }

  // void _showExitDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("تأكيد الخروج"),
  //         content: const Text("هل تريد إلغاء عملية الدفع والخروج؟"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               GoRouter.of(context).pop(); // إغلاق الحوار
  //             },
  //             child: const Text("لا"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               GoRouter.of(context).pop(); // إغلاق الحوار
  //               GoRouter.of(context).pop(); // العودة للصفحة السابقة
  //             },
  //             child: const Text("نعم", style: TextStyle(color: Colors.red)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
