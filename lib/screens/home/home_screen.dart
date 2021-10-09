import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_dashboard/constants.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_contract.dart';
import 'package:food_dashboard/di/get_it.dart';
import 'package:food_dashboard/domain/entities/restaurant.dart';
import 'package:food_dashboard/widgets/category_icon_with_text.dart';
import 'package:food_dashboard/widgets/counter_with_text.dart';
import 'package:food_dashboard/widgets/custom_circle_button.dart';
import 'package:food_dashboard/widgets/custom_text_button.dart';
import 'package:food_dashboard/widgets/restaurant_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double valueKm = 0;
  List<Restaurant>? restaurantList;

  @override
  void initState() {
    super.initState();
    getAllRestaurant();
  }

  getAllRestaurant() async {
    final getItInstance = getIt<IRestaurantService>();
    restaurantList = await getItInstance.getAllRestaurant();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        //* ----------------------------------------------------
        //* This help to unfocus searchfield when click outside
        //* ----------------------------------------------------
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      (size.width < 900)
                          ? Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(Icons.menu, color: Colors.white),
                                ),
                              ),
                            )
                          : Container(
                              width: 350,
                              child: TextField(
                                style: TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  hintText: "Enter your search request...",
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.search,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Spacer(),
                      CustomCircleButton(
                        icon: FontAwesomeIcons.slidersH,
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      CustomTextButton(
                        onTap: () {},
                        text: "Go to Premium",
                      ),
                    ],
                  ),
                  //* ---------------------------------
                  //* ---------------------------------
                  //* ---------------------------------
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Find the best place",
                            style: largestText,
                          ),
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(text: "249 restaurants, "),
                                TextSpan(
                                  text: "choose yours",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      if (size.width > 590) SpecialAndCategoriesCounter(),
                    ],
                  ),
                  if (size.width <= 590) ...[
                    SizedBox(height: 30),
                    SpecialAndCategoriesCounter(),
                  ],
                  //* --------------------------------------------
                  //* Categories Section
                  //* --------------------------------------------
                  const SizedBox(height: 40),
                  CategoryIconWithText(),
                  const SizedBox(height: 30),
                  //*------------------------------------------
                  //* New Restaurant Section
                  //*------------------------------------------
                  Row(
                    children: [
                      Text(
                        "New restaurants",
                        style: largeText,
                      ),
                      Spacer(),
                      Slider(
                        divisions: 10,
                        value: valueKm,
                        onChanged: (value) {
                          setState(() {
                            valueKm = value;
                          });
                        },
                        min: 0,
                        max: 10,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black,
                        label: "$valueKm Km",
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            //* --------------------------------
            //* List of New Restaurant
            //* --------------------------------
            RestaurantList(
              restaurantList: restaurantList ?? cachedRestaurantList,
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialAndCategoriesCounter extends StatelessWidget {
  const SpecialAndCategoriesCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CounterWithText(number: 94, text: "Specials"),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 1,
          height: 50,
          color: Colors.grey.shade300,
        ),
        CounterWithText(number: 23, text: "Delivery"),
      ],
    );
  }
}
