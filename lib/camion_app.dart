import 'package:camion/generated/l10n.dart';
import 'package:camion/routing/router_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CamionApp extends StatelessWidget {
  const CamionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,

      child: MaterialApp.router(
        routerConfig: RouterGenerator.mainRouting,
        debugShowCheckedModeBanner: false,
        title: 'camion',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('ar'),
        theme: ThemeData(),
      ),
    );
  }
}
