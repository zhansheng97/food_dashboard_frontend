import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final IconData icon;
  final String text;

  Category({
    required this.icon,
    required this.text,
  });
}

final List<Category> categories = [
  Category(icon: FontAwesomeIcons.pizzaSlice, text: "Italian"),
  Category(icon: FontAwesomeIcons.utensilSpoon, text: "Asian"),
  Category(icon: FontAwesomeIcons.glassMartini, text: "Bars"),
  Category(icon: FontAwesomeIcons.hamburger, text: "Burgers"),
  Category(icon: FontAwesomeIcons.mugHot, text: "Cafe"),
  Category(icon: FontAwesomeIcons.beer, text: "Pubs"),
  Category(icon: FontAwesomeIcons.seedling, text: "Vegan"),
  Category(icon: FontAwesomeIcons.fish, text: "Seafood"),
];
