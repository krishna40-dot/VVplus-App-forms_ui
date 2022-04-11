// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Models/voucher_type_model.dart';


class VoucherTypeRepository {
  Client client = Client();

  Future<List<VoucherType>> getData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.mockDataVoucherTypeURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => VoucherType.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
Future<List<VoucherType>> createUser(String strSubCode,String strName,String Godown) async{
  final response = await http.post(Uri.parse(ApiService.getVoucherTypeURL), body: {
    "StrSubCode": strSubCode,
    "StrName": strName,
    "Godown": Godown,
  });

  if(response.statusCode == 200){
    final String responseString = response.body;
    return strRecordFromJson(responseString);
  }else{
    return null;
  }
}