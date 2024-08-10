import 'package:flutter/material.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/profile.dart';
import 'package:namednavigation/screen/setting.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: _getMaterailPageRoute
    );
  }

  MaterialPageRoute? _getMaterailPageRoute(RouteSettings settings){
     Widget? widget;
    switch (settings.name) {
      case HomeScreen.routeName:
        widget = const HomeScreen();
        break;
      case SettinScreen.routeName:
        widget = const SettinScreen();
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
