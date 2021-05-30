import 'package:cuba_pod/app/app_binding.dart';
import 'package:cuba_pod/app/routes/app_pages.dart';
import 'package:cuba_pod/app/theme/dark_theme.dart';
import 'package:cuba_pod/app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CubaPod extends StatelessWidget {
  final SharedPreferences storage;

  CubaPod({
    required this.storage,
  });

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: "CubaPod",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: lightTheme,
        darkTheme: darkTheme,
        initialBinding: AppBinding(
          storage: storage,
        ),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.size,
      );
}
