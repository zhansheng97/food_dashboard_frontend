import 'package:food_dashboard/datasources/api_client/http_client.dart';
import 'package:food_dashboard/datasources/service/auth_service_contract.dart';
import 'package:food_dashboard/datasources/service/auth_service_impl.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_contract.dart';
import 'package:food_dashboard/datasources/service/restaurant_service_impl.dart';
import 'package:food_dashboard/screens/bloc/page_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<Client>(() => Client());

  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPref);

  getIt.registerLazySingleton<HttpClient>(
      () => HttpClient(client: getIt(), sharedPreferences: getIt()));

  getIt.registerLazySingleton<IAuthService>(
      () => AuthServiceImpl(httpClient: getIt(), sharedPreferences: getIt()));

  getIt.registerLazySingleton<IRestaurantService>(
      () => RestaurantServiceImpl(getIt()));

  getIt.registerFactory<PageBloc>(() => PageBloc());
}
