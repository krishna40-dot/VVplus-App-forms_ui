import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';

import 'package:vvplus_app/infrastructure/Models/material_req_approval_model.dart';


class MaterialReqApprovalRepository {
  Client client = Client();

  Future<List<MaterialReqPost>> fetchPostData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.materialReqPostURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => MaterialReqPost.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
Future<List<MaterialReqPost>> createUser(String indentSubCode,String intendDate,String itemName,String itemSubCode,String itemUnit,String rate,String remarks,String reqDate,String reqQty) async {
  final response = await http.post(Uri.parse(ApiService.materialReqPostURL), body: {
    "IndentSubCode": indentSubCode,
    "IntendDate": intendDate,
    "ItemName": itemName,
    "ItemSubCode": itemSubCode,
    "ItemUnit": itemUnit,
    "Rate": rate,
    "Remarks": remarks,
    "ReqDate": reqDate,
    "ReqQty": reqQty,
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return strRecordFromJson(responseString);
  } else {
    return null;
  }
}
