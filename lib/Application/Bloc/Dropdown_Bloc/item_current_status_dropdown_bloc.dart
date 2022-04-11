import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Repository/item_current_status_repository.dart';

class ItemCurrentStatusDropdownBloc {
  final itemCurrentStatusDropdownRepository = ItemCurrentStatusRepository();
  final itemCurrentStatusDropdownData = BehaviorSubject<ItemCurrentStatus>();

  Future<List<ItemCurrentStatus>> itemCurrentStatusDropdowndata;
  Stream<ItemCurrentStatus> get selectedState => itemCurrentStatusDropdownData;
  void selectedStateEvent(ItemCurrentStatus state) => itemCurrentStatusDropdownData.add(state);

  ItemCurrentStatusDropdownBloc() {
    itemCurrentStatusDropdowndata = itemCurrentStatusDropdownRepository.getData();
  }

  void dispose() {
    itemCurrentStatusDropdownData.close();
  }
}