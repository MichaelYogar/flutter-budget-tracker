import 'package:flutter_budget_tracker/api/api.dart';
import 'package:flutter_budget_tracker/api/models/item_model.dart';
import 'package:flutter_budget_tracker/core/core.dart';

class ItemViewModel {


  ItemViewModel();

  Future<List<ItemModel>> getItems() {
    return app<BudgetService>().getItems();
  }
}
