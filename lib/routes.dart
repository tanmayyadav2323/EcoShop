import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/home/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AuthScreen(),
      );
    case HomeScreen.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Scaffold(
          body: Text("Error Page "),
        ),
      );
  }
}
