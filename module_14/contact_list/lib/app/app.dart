import 'package:contact_list/providers/contact_list_provider.dart';
import 'package:contact_list/themes/appbar_style.dart';
import 'package:contact_list/themes/elevated_button_style.dart';
import 'package:contact_list/themes/textfield_style.dart';
import 'package:contact_list/utils/colors.dart';
import 'package:contact_list/views/homeScreen/home_screen.dart';
import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) { return ContactListProvider(); },
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: ThemeData(
          appBarTheme: AppbarStyle.getAppBarTheme(),
          inputDecorationTheme: TextFieldStyle.getTextFieldStyle(),
          elevatedButtonTheme: ElevatedButtonStyle.getElevatedButtonStyle(),
          scaffoldBackgroundColor: whiteColor,
        ),
      ),
    );
  }
}
