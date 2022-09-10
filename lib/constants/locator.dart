import 'package:fungimobil/data/api_client.dart';
import 'package:fungimobil/data/preferences_helper.dart';
import 'package:fungimobil/repository/auth_repository.dart';
import 'package:fungimobil/repository/table_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton<ApiClient>(ApiClient());
  locator.registerSingleton<PreferencesHelper>(PreferencesHelper());
  locator.registerSingleton<AuthRepository>(AuthRepository());
  locator.registerSingleton<TableRepository>(TableRepository());
}