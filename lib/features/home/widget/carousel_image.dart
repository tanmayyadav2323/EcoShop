import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Builder(
            builder: (context) => Image.asset(
                  "assets/images/$i.png",
                  fit: BoxFit.cover,
                  height: 400,
                ));
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }
}
