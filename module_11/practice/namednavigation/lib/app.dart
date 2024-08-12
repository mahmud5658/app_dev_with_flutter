import 'package:flutter/material.dart';
import 'package:namednavigation/model/student_model.dart';
import 'package:namednavigation/screen/home.dart';
import 'package:namednavigation/screen/profile.dart';
import 'package:namednavigation/screen/setting.dart';

class NamedNavigation extends StatelessWidget {
  const NamedNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // routes: {
      //   '/': (context) => const HomeScreen(),
      //   '/profile': (context) => const ProfileScreen(),
      //   '/setting': (context) => const SettingScreen(),
      // },
      onGenerateRoute: (settings) {
        Widget? widget;
        switch (settings.name) {
          case HomeScreen.routeName:
            widget = const HomeScreen();
            break;
          case SettingScreen.routeName:
            widget = const SettingScreen();
            break;
          case ProfileScreen.routeName:
          final args = settings.arguments as Student;
            widget =  ProfileScreen(name: args.name,id: args.id,);
            break;
        }
        if (widget != null) {
          return MaterialPageRoute(builder: (context) => widget!);
        }
        return null;
      },
    );
  }
}
