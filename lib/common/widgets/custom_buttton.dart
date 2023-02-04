import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.text,
    this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: widget.color),
      child: Text(
        widget.text,
        style: TextStyle(
            color: widget.color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
