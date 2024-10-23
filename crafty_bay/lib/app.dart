import 'package:crafty_bay/controller_binder.dart';
import 'package:crafty_bay/presentation/UI/screens/splash_screen.dart';
import 'package:crafty_bay/presentation/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crafty Bay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
          ),
          colorSchemeSeed: ThemeColor.accentColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(
                color: Colors.black87,
                fontSize: 28,
                fontWeight: FontWeight.w700),
            bodyLarge: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w700),
            bodySmall: TextStyle(
                color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
            labelLarge: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
            labelMedium: TextStyle(color: Colors.grey, fontSize: 14),
            labelSmall: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: ThemeColor.accentColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            hintStyle: TextStyle(
              color: ThemeColor.midGrey,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide:
                  const BorderSide(width: 1.5, color: ThemeColor.accentColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide:
                  const BorderSide(width: 1.5, color: ThemeColor.accentColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(width: 1.5, color: Colors.red),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColor.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              fixedSize: const Size.fromWidth(double.maxFinite),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ThemeColor.accentColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(fontSize: 14),
            unselectedLabelStyle: TextStyle(fontSize: 14),
          ),
          cardTheme: CardTheme(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          )),
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
