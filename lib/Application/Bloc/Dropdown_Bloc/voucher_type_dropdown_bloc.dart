import 'dart:async';
import 'dart:core';
import 'package:rxdart/rxdart.dart';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';
import 'package:vvplus_app/infrastructure/Repository/voucher_type_repository.dart';

class VoucherTypeDropdownBloc {
  final voucherTypeDropdownRepository = VoucherTypeRepository();
  final voucherTypeDropdownGetData = BehaviorSubject<VoucherType>();

  Future<List<VoucherType>> voucherTypeDropdownData;
  Stream<VoucherType> get selectedState => voucherTypeDropdownGetData;
  void selectedStateEvent(VoucherType state) => voucherTypeDropdownGetData.add(state);

  VoucherTypeDropdownBloc() {
    voucherTypeDropdownData = voucherTypeDropdownRepository.getData();
  }

  void dispose() {
    voucherTypeDropdownGetData.close();
  }
}