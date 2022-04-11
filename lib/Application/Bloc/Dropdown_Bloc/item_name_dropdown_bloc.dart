import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_name_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/item_name_repository.dart';

class ItemNameDropdownBloc {
  final itemNameDropdownRepository = ItemNameRepository();
  final itemNameDropdownGetData = BehaviorSubject<ItemName>();

  Future<List<ItemName>> itemNameDropdownData;
  Stream<ItemName> get selectedState => itemNameDropdownGetData;
  void selectedStateEvent(ItemName state) => itemNameDropdownGetData.add(state);

  ItemNameDropdownBloc() {
    itemNameDropdownData = itemNameDropdownRepository.getData();
  }

  void dispose() {
    itemNameDropdownGetData.close();
  }
}