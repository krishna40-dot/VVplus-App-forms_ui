import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'package:vvplus_app/data_source/api/api_services.dart';
import 'dart:async';
import 'package:vvplus_app/infrastructure/Models/material_request_entry_post_data_model.dart';


class MaterialRequestEntryPostDataRepository {
  Client client = Client();

  Future<List<MaterialRequestEntryPostData>> getData() async {
    try {
      final response = await client.get(Uri.parse(ApiService.mockDataPostMaterialRequestEntryURL));
      final items = (jsonDecode(response.body) as List)
          .map((e) => MaterialRequestEntryPostData.fromJson(e))
          .toList();
      return items;
    } catch (e) {
      rethrow;
    }
  }
}
Future<List<MaterialRequestEntryPostData>> createUser(String strSubCode,String strName) async{
  final response = await http.post(Uri.parse(ApiService.mockDataPostMaterialRequestEntryURL), body: {
    "StrSubCode": strSubCode,
    "StrName": strName,
  });

  if(response.statusCode == 200){
    final String responseString = response.body;
    return materialRequestEntryPostDataFromJson(responseString);
  }else{
    return null;
  }
}