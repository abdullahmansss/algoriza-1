import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double height;
  final double width;
  final VoidCallback onClick;
  final double radius;
  final Color buttonColor;
  final bool isCapitalize;

  const MyButton({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.height = 56.0,
    this.width = double.infinity,
    required this.onClick,
    this.radius = 6.0,
    this.buttonColor = Colors.teal,
    this.isCapitalize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        height: height,
        color: buttonColor,
        onPressed: () {
          onClick();
        },
        child: Text(
          isCapitalize ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
