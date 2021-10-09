import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CustomCircleButton({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          child: RotatedBox(
              quarterTurns: 1,
              child: FaIcon(
                icon,
                size: 20,
              )),
        ),
      ),
    );
  }
}
