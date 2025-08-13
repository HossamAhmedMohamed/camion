import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static const platform = MethodChannel('flutter/share');

  // مشاركة النص بطرق متعددة
  static Future<void> shareText(String text, {String? subject}) async {
    try {
      // المحاولة الأولى: استخدام Share Plus
      await Share.share(text, subject: subject);
    } catch (e) {
      // المحاولة الثانية: استخدام Android Intent
      await shareViaIntent(text);
    }
  }

  // مشاركة عبر Android Intent
  static Future<void> shareViaIntent(String text) async {
    try {
      const intentChannel = MethodChannel('android_intent');
      await intentChannel.invokeMethod('sendIntent', {
        'action': 'android.intent.action.SEND',
        'type': 'text/plain',
        'extra_text': text,
        'chooser_title': 'مشاركة المنتج',
      });
    } catch (e) {
      // المحاولة الأخيرة: نسخ للحافظة
      await _copyToClipboard(text);
    }
  }

  // نسخ النص للحافظة
  static Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Fluttertoast.showToast(
      msg: 'تم نسخ النص - يمكنك لصقه في أي تطبيق',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  // مشاركة عبر WhatsApp
  static Future<void> shareViaWhatsApp(String text) async {
    final whatsappUrl = "whatsapp://send?text=${Uri.encodeComponent(text)}";
    try {
      if (await canLaunchUrlString(whatsappUrl)) {
        await launchUrlString(whatsappUrl);
      } else {
        await _copyToClipboard(text);
      }
    } catch (e) {
      await _copyToClipboard(text);
    }
  }

  // مشاركة عبر Telegram
  static Future<void> shareViaTelegram(String text) async {
    final telegramUrl = "tg://msg?text=${Uri.encodeComponent(text)}";
    try {
      if (await canLaunchUrlString(telegramUrl)) {
        await launchUrlString(telegramUrl);
      } else {
        await _copyToClipboard(text);
      }
    } catch (e) {
      await _copyToClipboard(text);
    }
  }

  // مشاركة عبر رسائل SMS
  static Future<void> shareViaSMS(String text) async {
    final smsUrl = "sms:?body=${Uri.encodeComponent(text)}";
    try {
      if (await canLaunchUrlString(smsUrl)) {
        await launchUrlString(smsUrl);
      } else {
        await _copyToClipboard(text);
      }
    } catch (e) {
      await _copyToClipboard(text);
    }
  }

  // فتح متجر التطبيقات
  static Future<void> shareAppStore() async {
    const playStoreUrl =
        "https://play.google.com/store/apps/details?id=com.example.camion";
    try {
      if (await canLaunchUrlString(playStoreUrl)) {
        await launchUrlString(playStoreUrl);
      }
    } catch (e) {
      await _copyToClipboard(playStoreUrl);
    }
  }
}
