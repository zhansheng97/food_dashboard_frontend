import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget({
    Key? key,
    this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 800 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return desktop;
        }
        // If width it less then 900 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet ?? desktop;
        }
        // Or less then that we called it mobile
        else {
          return mobile ?? desktop;
        }
      },
    );
  }
}
