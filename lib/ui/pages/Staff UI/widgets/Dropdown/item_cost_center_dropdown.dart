import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class ItemCostCenterDropdown extends StatefulWidget {
  const ItemCostCenterDropdown({Key key}) : super(key: key);

  @override
  _ItemCostCenterDropdownState createState() => _ItemCostCenterDropdownState();
}

class _ItemCostCenterDropdownState extends State<ItemCostCenterDropdown> {
  ItemCostCenterDropdownBloc itemCostCenterDropdownBloc;

  @override
  void initState() {
    itemCostCenterDropdownBloc = ItemCostCenterDropdownBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Container(
        height: 50, width: 343,
        decoration: decorationForms(),
        child: FutureBuilder<List<ItemCostCenter>>(
            future: itemCostCenterDropdownBloc.itemCostCenterData,
            builder: (context, snapshot) {
              return StreamBuilder<ItemCostCenter>(
                  stream: itemCostCenterDropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<ItemCostCenter>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: itemCostCenterDropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<ItemCostCenter>>((e) {
                        return DropdownMenuItem<ItemCostCenter>(
                          value: e,
                          child: Text(e.strName),
                        );
                      })?.toList() ??[],
                    );
                  }
              );
            }
        ),
      ),
    );
  }
}
