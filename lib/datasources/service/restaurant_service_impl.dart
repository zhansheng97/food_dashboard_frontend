import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:food_dashboard/datasources/api_client/http_client.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_contract.dart';
import 'package:food_dashboard/domain/entities/restaurant.dart';
import 'package:http/http.dart';

class RestaurantServiceImpl implements IRestaurantService {
  final HttpClient client;

  RestaurantServiceImpl(this.client);

  @override
  Future<List<Restaurant>> getAllRestaurant() async {
    Response response = await client.get("/restaurant/all");

    if (response.statusCode == 200) {
      var jsonDecoded = jsonDecode(response.body) as List;
      List<Restaurant> allRestaurant = jsonDecoded.map<Restaurant>((json) {
        Restaurant restaurant = Restaurant.fromJson(json);
        return restaurant;
      }).toList();
      return allRestaurant;
    } else {
      print("Connection Error");
      throw Exception("Error");
    }
  }

  @override
  Future<Restaurant> addRestaurant(
    Restaurant restaurant,
    Uint8List bytes,
    File file,
  ) async {
    String filename = file.name;
    String base64encode = base64Encode(bytes);
    String fileType = file.type;

    String body = jsonEncode(
      {
        'name': restaurant.name,
        'resType': restaurant.resType,
        'rating': restaurant.rating,
        'price': restaurant.price,
        'distance': restaurant.distance,
        "fileName": filename,
        "fileType": fileType,
        "bytes": base64encode,
      },
    );

    Response response = await client.post("/restaurant/add", body);

    if (response.statusCode == 201) {
      var jsonDecoded = jsonDecode(response.body);
      Restaurant restaurant = Restaurant.fromJson(jsonDecoded);
      print(jsonDecoded);
      return restaurant;
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<void> deleteRestaurant(String id) async {
    Response response = await client.delete("/restaurant/delete/$id");
    if (response.statusCode == 200) {
      print("restaurant $id deleted");
    } else {
      throw Exception("Something went wrong");
    }
  }

  @override
  Future<Restaurant> getRestaurantById(String id) async {
    Response response = await client.get("/restaurant/$id");
    if (response.statusCode == 200) {
      print(response.body);
      var json = jsonDecode(response.body);

      return Restaurant.fromJson(json);
    } else {
      throw Exception("Something went wrong");
    }
  }

  @override
  Future<Restaurant> updateRestaurant(
    String id,
    Restaurant restaurant,
    Uint8List? bytes,
    File? file,
  ) async {
    String body;

    if (bytes != null && file != null) {
      String filename = file.name;
      String base64encode = base64Encode(bytes);
      String fileType = file.type;

      body = jsonEncode(
        {
          'name': restaurant.name,
          'resType': restaurant.resType,
          'rating': restaurant.rating,
          'price': restaurant.price,
          'distance': restaurant.distance,
          "fileName": filename,
          "fileType": fileType,
          "bytes": base64encode,
        },
      );
    } else {
      body = jsonEncode(restaurant.toJson());
    }

    Response response = await client.put("/restaurant/update/$id", body);
    if (response.statusCode == 200) {
      print(response.body);
      var json = jsonDecode(response.body);

      return Restaurant.fromJson(json);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
