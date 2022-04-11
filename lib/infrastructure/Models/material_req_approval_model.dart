import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));
//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<MaterialReqPost> strRecordFromJson(String str) =>
    List<MaterialReqPost>.from(json.decode(str).map((x) => MaterialReqPost.fromJson(x)));

String strRecordToJson(List<MaterialReqPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class MaterialReqPost {
  String indentSubCode;
  String intendDate;
  String itemName;
  String itemSubCode;
  String itemUnit;
  String rate;
  String remarks;
  String reqDate;
  String reqQty;

  MaterialReqPost({
    this.indentSubCode,
    this.intendDate,
    this.itemName,
    this.itemSubCode,
    this.itemUnit,
    this.rate,
    this.remarks,
    this.reqDate,
    this.reqQty,
  });



  factory MaterialReqPost.fromJson(Map<String, dynamic> json) => MaterialReqPost(
    indentSubCode: json["IndentSubCode"],
    intendDate: json["IntendDate"],
    itemName: json["ItemName"],
    itemSubCode: json["ItemSubCode"],
    itemUnit: json["ItemUnit"],
    rate: json["Rate"],
    remarks: json["Remarks"],
    reqDate: json["ReqDate"],
    reqQty: json["ReqQty"],
  );

  Map<String, dynamic> toJson() => {
    "IndentSubCode": indentSubCode,
    "IntendDate": intendDate,
    "ItemName": itemName,
    "ItemSubCode": itemSubCode,
    "ItemUnit": itemUnit,
    "Rate": rate,
    "Remarks": remarks,
    "ReqDate": reqDate,
    "ReqQty": reqQty,
  };
}
