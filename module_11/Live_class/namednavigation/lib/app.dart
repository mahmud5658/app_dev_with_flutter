import 'package:flutter/material.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/profile.dart';
import 'package:namednavigation/screen/setting.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/', onGenerateRoute: _getMaterialPageRoute,);
  }

  MaterialPageRoute? _getMaterialPageRoute(RouteSettings settings) {
    Widget? widget;
    switch (settings.name) {
      case HomeScreen.routeName:
        widget = const HomeScreen();
        break;
      case SettingScreen.routeName:
        final args = settings.arguments as ScreenArgument;
        widget = SettingScreen(
          name: args.name,
          age: args.age,
        );
        break;
      case ProfileScreen.routeName:
        String name = settings.arguments as String;
        widget = ProfileScreen(
          name: name,
        );
        break;
    }
    if (widget != null) {
      return MaterialPageRoute(builder: (context) => widget!);
    }
    return null;
  }
}
