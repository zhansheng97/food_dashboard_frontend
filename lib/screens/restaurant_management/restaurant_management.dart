import 'package:flutter/material.dart';
import 'package:food_dashboard/constants.dart';
import 'package:food_dashboard/datasources/api_client/http_client.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_contract.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_impl.dart';
import 'package:food_dashboard/di/get_it.dart';
import 'package:food_dashboard/domain/entities/restaurant.dart';
import 'package:food_dashboard/main.dart';
import 'package:food_dashboard/screens/restaurant_management/custom_dialog.dart';
import 'package:food_dashboard/screens/restaurant_management/edit_dialog.dart';
import 'package:http/http.dart';

class RestaurantManagement extends StatefulWidget {
  const RestaurantManagement({Key? key}) : super(key: key);

  @override
  _RestaurantManagementState createState() => _RestaurantManagementState();
}

class _RestaurantManagementState extends State<RestaurantManagement> {
  List<Restaurant>? allRestaurant;

  final restaurantService = getIt<IRestaurantService>();

  @override
  void initState() {
    super.initState();
    getAllRestaurant();
  }

  getAllRestaurant() async {
    allRestaurant = await restaurantService.getAllRestaurant();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 60,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Restaurant Management",
            style: largestText,
          ),
          const SizedBox(height: kdefaultPadding),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowHeight: 70,
                columns: [
                  ...tableTitle
                      .map(
                        (title) => DataColumn(
                          label: Text(
                            title,
                            style: largeText.copyWith(fontSize: 18),
                          ),
                        ),
                      )
                      .toList(),
                  DataColumn(
                    label: Text(
                      "Actions",
                      style: largeText.copyWith(fontSize: 18),
                    ),
                    onSort: (columnIndex, ascending) {},
                  ),
                ],
                rows: [
                  if (allRestaurant != null)
                    ...allRestaurant!.map(
                      (restaurant) => DataRow(
                        cells: [
                          DataCell(
                            Text(restaurant.id!),
                          ),
                          DataCell(
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Container(
                                height: 50,
                                width: 60,
                                child: Image.network(
                                  restaurant.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              restaurant.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataCell(
                            Text(restaurant.resType),
                          ),
                          DataCell(
                            Text(restaurant.rating),
                          ),
                          DataCell(
                            Text(restaurant.price),
                          ),
                          DataCell(
                            Text(restaurant.distance),
                          ),
                          DataCell(
                            Row(
                              children: [
                                ActionButton(
                                  text: "View",
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialog(
                                          restaurant: restaurant,
                                          dialogTitle: "Restaurant Details",
                                          buttonText: "Confirm",
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  color: Colors.blue,
                                ),
                                ActionButton(
                                  text: "Edit",
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditDialog(
                                          restaurant: restaurant,
                                        );
                                      },
                                    );
                                  },
                                  color: Colors.green[400]!,
                                ),
                                ActionButton(
                                  text: "Delete",
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomDialog(
                                          restaurant: restaurant,
                                          dialogTitle: "Delete Restaurant",
                                          buttonText: "Delete",
                                          onTap: () {
                                            restaurantService.deleteRestaurant(
                                                restaurant.id!);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
