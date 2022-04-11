import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<IndentorName> strRecordFromJson(String str) =>
    List<IndentorName>.from(json.decode(str).map((x) => IndentorName.fromJson(x)));

String strRecordToJson(List<IndentorName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class IndentorName {
  IndentorName({
    this.strSubCode,
    this.strName,
  });

  String strSubCode;
  String strName;

  factory IndentorName.fromJson(Map<String, dynamic> json) => IndentorName(
    strSubCode: json["StrSubCode"],
    strName: json["StrName"],
  );

  Map<String, dynamic> toJson() => {
    "StrSubCode": strSubCode,
    "StrName": strName,
  };
}
