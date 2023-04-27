import 'package:flutter/material.dart';

String uri = 'http://192.168.1.3:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color(0xffCAF66F),
      Color(0xffA5E6CE),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = ["1", "2", "3", "4"];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Containers',
      'image': 'assets/images/image 7.png',
    },
    {
      'title': 'SkinCares',
      'image': 'assets/images/image 5.png',
    },
    {
      'title': 'HomeGoods',
      'image': 'assets/images/image 6-1.png',
    },
    {
      'title': 'Packagings',
      'image': 'assets/images/ss.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/image 6.png',
    },
  ];
}
