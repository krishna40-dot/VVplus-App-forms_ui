import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/department_name_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/department_name_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class DepartmentNameDropdown extends StatefulWidget {
  const DepartmentNameDropdown({Key key}) : super(key: key);

  @override
  _DepartmentNameDropdownState createState() => _DepartmentNameDropdownState();
}

class _DepartmentNameDropdownState extends State<DepartmentNameDropdown> {
  DepartmentNameDropdownBloc _dropdownBloc;

  @override
  void initState() {
    _dropdownBloc = DepartmentNameDropdownBloc();
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
        child: FutureBuilder<List<DepartmentName>>(
            future: _dropdownBloc.departmentNameData,
            builder: (context, snapshot) {
              return StreamBuilder<DepartmentName>(
                  stream: _dropdownBloc.selectedState,
                  builder: (context, item) {
                    return SearchChoices<DepartmentName>.single(
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      underline: "",
                      padding: 1,
                      isExpanded: true,
                      hint: "Search here",
                      value: item.data,
                      displayClearIcon: false,
                      onChanged: _dropdownBloc.selectedStateEvent,
                      items: snapshot?.data
                          ?.map<DropdownMenuItem<DepartmentName>>((e) {
                        return DropdownMenuItem<DepartmentName>(
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
