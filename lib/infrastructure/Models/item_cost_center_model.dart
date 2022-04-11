import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<ItemCostCenter> strRecordFromJson(String str) =>
    List<ItemCostCenter>.from(json.decode(str).map((x) => ItemCostCenter.fromJson(x)));

String strRecordToJson(List<ItemCostCenter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ItemCostCenter {
  ItemCostCenter({
    this.strSubCode,
    this.strName,
  });

  String strSubCode;
  String strName;

  factory ItemCostCenter.fromJson(Map<String, dynamic> json) => ItemCostCenter(
    strSubCode: json["StrSubCode"],
    strName: json["StrName"],
  );

  Map<String, dynamic> toJson() => {
    "StrSubCode": strSubCode,
    "StrName": strName,
  };
}
