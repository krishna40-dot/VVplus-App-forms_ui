import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));

//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<ItemCurrentStatus> strRecordFromJson(String str) =>
    List<ItemCurrentStatus>.from(json.decode(str).map((x) => ItemCurrentStatus.fromJson(x)));

String strRecordToJson(List<ItemCurrentStatus> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemCurrentStatus {
  ItemCurrentStatus({
    this.strItemName,
    this.strCostCenterName,
    this.dblQty,
    this.strUnit,
  });

  String strItemName;
  String strCostCenterName;
  String dblQty;
  String strUnit;

  factory ItemCurrentStatus.fromJson(Map<String, dynamic> json) => ItemCurrentStatus(
    strItemName: json["StrItemName"],
    strCostCenterName: json["StrCostCenterName"],
    dblQty: json["DblQty"],
    strUnit: json["StrUnit"],
  );

  Map<String, dynamic> toJson() => {
    "StrItemName": strItemName,
    "StrCostCenterName": strCostCenterName,
    "DblQty": dblQty,
    "StrUnit": strUnit,
  };
}
