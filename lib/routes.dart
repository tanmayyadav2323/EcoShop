import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screens.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'features/search/screen/search_screen.dart';

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
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => BottomBar(),
      );
    case AddProductScreen.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddProductScreen(),
      );
    case CategoryDealsScreen.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: routeSettings.arguments as String,
        ),
      );
    case SearchScreen.routename:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: routeSettings.arguments as String,
        ),
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
