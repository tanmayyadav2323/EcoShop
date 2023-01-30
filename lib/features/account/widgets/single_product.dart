import 'package:flutter/material.dart';

class SingelProduct extends StatelessWidget {
  final String image;
  const SingelProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(
          width: 100,
          padding: EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}
