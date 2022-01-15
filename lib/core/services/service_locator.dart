import 'package:flutter_budget_tracker/api/api.dart';
import 'package:get_it/get_it.dart';

final app = GetIt.instance;

/// Adds all globally available services to the service locator.
void setUpServiceLocator() {
  app.registerLazySingleton(() => BudgetService());
}
