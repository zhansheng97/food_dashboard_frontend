import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:food_dashboard/constants.dart';

class LocationCardWidget extends StatelessWidget {
  const LocationCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Stack(
        children: [
          Container(
            height: 250,
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Local advisor",
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: kdefaultPadding / 2),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "beta",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 40,
            top: 40,
            child: CircleAvatar(backgroundColor: kWhiteColor, radius: 3),
          ),
          Positioned(
            right: 60,
            top: 35,
            child: CircleAvatar(
              backgroundColor: kWhiteColor,
              radius: 10,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: Colors.black,
              ),
            ),
          ),
          Positioned(
            left: 45,
            top: 120,
            child: FaIcon(
              FontAwesomeIcons.locationArrow,
              color: Colors.white,
              size: 18,
            ),
          ),
          Positioned(
            right: 80,
            bottom: 150,
            child: CircleAvatar(backgroundColor: kWhiteColor, radius: 3),
          ),
          Positioned(
            right: 40,
            bottom: 90,
            child: CircleAvatar(backgroundColor: kWhiteColor, radius: 3),
          ),
        ],
      ),
    );
  }
}
