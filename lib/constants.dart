import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kGreyColor = Colors.grey;
const double kdefaultPadding = 20;
const Color kWhiteColor = Colors.white;
Color? kLightGreyColor = Colors.grey[500];

TextStyle largestText = GoogleFonts.montserrat(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle largeText = GoogleFonts.montserrat(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

TextStyle normalText = GoogleFonts.montserrat(fontSize: 12);

TextStyle normalGreyText = GoogleFonts.montserrat(
  fontSize: 12,
  color: Colors.grey.shade600,
);

TextStyle normalBoldText = GoogleFonts.montserrat(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

List<String> tableTitle = [
  "ID",
  "Image",
  "Name",
  "Category",
  "Rating",
  "Price",
  "Distance",
];
