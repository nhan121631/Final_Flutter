import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:banhang/route/app_page.dart';
import 'package:banhang/route/app_route.dart';
import 'package:banhang/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPage.list,
      initialRoute: AppRoute.dashboard,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      
    );
  }
}
