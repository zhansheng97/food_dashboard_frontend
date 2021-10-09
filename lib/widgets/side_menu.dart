import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_dashboard/constants.dart';
import 'package:food_dashboard/domain/entities/menu.dart';
import 'package:food_dashboard/screens/bloc/page_bloc.dart';
import 'package:food_dashboard/widgets/location_card.dart';
import 'package:food_dashboard/widgets/menu_item.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int currentSelectedIndex = 0;
  bool isHovered = false;
  int? currentHoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "I",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.favorite,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                "Food",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.purple,
                  Colors.pink,
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/images/Joaquin_Phoenix.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Welcome",
            style: TextStyle(color: kGreyColor),
          ),
          const SizedBox(height: 10),
          Text(
            "John Miles",
            style: TextStyle(
                color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 20),
          ...menuList
              .asMap()
              .map((index, item) => MapEntry(
                  index,
                  MenuItem(
                    text: item.title,
                    icon: item.icon,
                    onTap: () {
                      setState(() {
                        currentSelectedIndex = index;
                        context
                            .read<PageBloc>()
                            .add(ChangePageEvent(index: currentSelectedIndex));
                      });
                    },
                    isSeleted: index == currentSelectedIndex,
                    onHover: (value) {
                      if (value) {
                        setState(() {
                          currentHoveredIndex = index;
                        });
                      } else {
                        setState(() {
                          currentHoveredIndex = null;
                        });
                      }
                    },
                    isHovered: currentHoveredIndex == index,
                  )))
              .values
              .toList(),
          Spacer(),
          LocationCardWidget(),
        ],
      ),
    );
  }
}
