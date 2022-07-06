import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qube/dashboard/dashboard.dart';
import 'package:qube/dashboard/support/kcolors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  notificationBarTransparent();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/dashboard',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: KColors.background,
        appBarTheme: AppBarTheme(
            color: KColors.background,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: KColors.title,
            ),
            titleTextStyle: TextStyle(
              color: KColors.title,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )),
      ),
      getPages: [
        GetPage(name: '/dashboard', page: () => Dashboard()),
      ],
    ),
  );
}

///This Function Makes AppBar transparent.
void notificationBarTransparent() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
