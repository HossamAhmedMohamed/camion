import 'package:camion/core/cache/secure_cache_storage.dart';
import 'package:camion/core/services/service_locator.dart';
import 'package:camion/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:camion/routing/app_router.dart';

class AffiliateCheckScreen extends StatefulWidget {
  const AffiliateCheckScreen({super.key});

  @override
  State<AffiliateCheckScreen> createState() => _AffiliateCheckScreenState();
}

class _AffiliateCheckScreenState extends State<AffiliateCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkAffiliateId();
  }

  Future<void> _checkAffiliateId() async {
    try {
      final affiliateId = await sl<SecureCacheHelper>().getData(
        key: 'affiliateId',
      );

      if (!mounted) return;

      if (affiliateId != null && affiliateId.isNotEmpty) {
        GoRouter.of(context).pushReplacement(AppRouter.supplierAccount);
      } else {
        GoRouter.of(context).pushReplacement(AppRouter.supplierWelcome);
      }
    } catch (e) {
      if (mounted) {
        GoRouter.of(context).pushReplacement(AppRouter.supplierWelcome);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator(
color: AppColors.primaryColor,
    )));
  }
}
