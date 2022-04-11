import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/material_request_entry_post_data_model.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Repository/material_request_entry_data_repository.dart';

class MaterialRequestEntryPostDataBloc {
  final materialRequestEntryPostDataRepository = MaterialRequestEntryPostDataRepository();
  final materialRequestEntryPostGetData = BehaviorSubject<MaterialRequestEntryPostData>();

  Future<List<MaterialRequestEntryPostData>> materialRequestEntryPostData;
  Stream<MaterialRequestEntryPostData> get selectedState => materialRequestEntryPostGetData;
  void selectedStateEvent(MaterialRequestEntryPostData state) => materialRequestEntryPostGetData.add(state);

  MaterialRequestEntryPostDataBloc() {
    materialRequestEntryPostData = materialRequestEntryPostDataRepository.getData();
  }

  void dispose() {
    materialRequestEntryPostGetData.close();
  }
}