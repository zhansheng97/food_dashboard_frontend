import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {
  final Client client;
  final SharedPreferences sharedPreferences;

  HttpClient({
    required this.client,
    required this.sharedPreferences,
  });

  static const String BASEURL = "http://localhost:8080/api/v1";

  Future<Response> get(String url) async {
    Uri uri = parseUrl(url);

    if (sharedPreferences.getString("token") != null) {
      String token = sharedPreferences.getString("token")!;

      Response response = await client.get(
        uri,
        headers: {"Authorization": "Bearer $token"},
      );

      return response;
    } else {
      Response response = await client.get(uri);
      return response;
    }
  }

  Future<Response> post(String url, body) async {
    Uri uri = parseUrl(url);
    print(uri);

    if (sharedPreferences.getString("token") != null) {
      String token = sharedPreferences.getString("token")!;
      Response response = await client.post(
        uri,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } else {
      Response response = await client.post(
        uri,
        body: body,
        headers: {"Content-Type": "application/json"},
      );
      return response;
    }
  }

  Future<Response> put(String url, body) async {
    Uri uri = parseUrl(url);

    if (sharedPreferences.getString("token") != null) {
      String token = sharedPreferences.getString("token")!;
      Response response = await client.put(
        uri,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } else {
      Response response = await client.put(
        uri,
        body: body,
        headers: {
          "Content-Type": "application/json",
        },
      );
      return response;
    }
  }

  Future<Response> delete(String url) async {
    Uri uri = parseUrl(url);

    if (sharedPreferences.getString("token") != null) {
      String token = sharedPreferences.getString("token")!;
      Response response = await client.delete(
        uri,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      return response;
    } else {
      Response response = await client.delete(uri);
      return response;
    }
  }

  Uri parseUrl(String url) {
    Uri uri = Uri.parse(BASEURL + url);
    return uri;
  }
}
