import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<DepartmentName> strRecordFromJson(String str) =>
    List<DepartmentName>.from(json.decode(str).map((x) => DepartmentName.fromJson(x)));

String strRecordToJson(List<DepartmentName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DepartmentName {
  DepartmentName({
    this.strSubCode,
    this.strName,
  });

  String strSubCode;
  String strName;

  factory DepartmentName.fromJson(Map<String, dynamic> json) => DepartmentName(
    strSubCode: json["StrSubCode"],
    strName: json["StrName"],
  );

  Map<String, dynamic> toJson() => {
    "StrSubCode": strSubCode,
    "StrName": strName,
  };
}
