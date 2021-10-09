import 'package:flutter/material.dart';
import 'package:food_dashboard/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const CustomTextButton({
    Key? key,
    required this.text,
    this.color = Colors.black,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 50,
          width: 150,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
