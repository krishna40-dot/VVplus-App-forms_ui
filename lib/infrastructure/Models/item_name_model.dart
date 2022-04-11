import 'dart:convert';

//StrRecord strRecordFromJson(String str) => StrRecord.fromJson(json.decode(str));

//String strRecordToJson(StrRecord data) => json.encode(data.toJson());

List<ItemName> strRecordFromJson(String str) =>
    List<ItemName>.from(json.decode(str).map((x) => ItemName.fromJson(x)));

String strRecordToJson(List<ItemName> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemName {
  ItemName({
    this.strItemCode,
    this.strItemName,
    this.strItemManualCode,
    this.strItemMinStock,
    this.strItemMaxStock,
    this.strItemReorder,
    this.strItemSku,
    this.strItemGroup,
    this.strItemCategory,
    this.strItemType,
    this.strItemDescription,
    this.strItemMaintainStockOn,
  });

  String strItemCode;
  String strItemName;
  String strItemManualCode;
  String strItemMinStock;
  String strItemMaxStock;
  String strItemReorder;
  String strItemSku;
  String strItemGroup;
  String strItemCategory;
  String strItemType;
  String strItemDescription;
  String strItemMaintainStockOn;

  factory ItemName.fromJson(Map<String, dynamic> json) => ItemName(
    strItemCode: json["StrItemCode"],
    strItemName: json["StrItemName"],
    strItemManualCode: json["StrItemManualCode"],
    strItemMinStock: json["StrItemMinStock"],
    strItemMaxStock: json["StrItemMaxStock"],
    strItemReorder: json["StrItemReorder"],
    strItemSku: json["StrItemSKU"],
    strItemGroup: json["StrItemGroup"],
    strItemCategory: json["StrItemCategory"],
    strItemType: json["StrItemType"],
    strItemDescription: json["StrItemDescription"],
    strItemMaintainStockOn: json["StrItemMaintainStockOn"],
  );

  Map<String, dynamic> toJson() => {
    "StrItemCode": strItemCode,
    "StrItemName": strItemName,
    "StrItemManualCode": strItemManualCode,
    "StrItemMinStock": strItemMinStock,
    "StrItemMaxStock": strItemMaxStock,
    "StrItemReorder": strItemReorder,
    "StrItemSKU": strItemSku,
    "StrItemGroup": strItemGroup,
    "StrItemCategory": strItemCategory,
    "StrItemType": strItemType,
    "StrItemDescription": strItemDescription,
    "StrItemMaintainStockOn": strItemMaintainStockOn,
  };
}
