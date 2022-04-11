import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/screens/purchase%20page/material_request_approval/forms_container_data.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/text_form_field.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';

class MaterialRequestApprovalBody extends StatefulWidget{
  const MaterialRequestApprovalBody({Key key}) : super(key: key);
  @override
  State<MaterialRequestApprovalBody> createState() => MyMaterialRequestApprovalBody();
}
class MyMaterialRequestApprovalBody extends State<MaterialRequestApprovalBody> {
  bool isActive = false;
  bool pressed = false;
  TextEditingController dateinput = TextEditingController();
  final materialRequestApprovalFormKey = GlobalKey<FormState>();
  IndentorNameDropdownBloc _dropdownBloc;
  bool pressAttention = false;
  @override
  void initState() {

    dateinput.text = "";
    _dropdownBloc = IndentorNameDropdownBloc();
    super.initState();
  }
  IndentorName selectIndentorName;
  void onDataChange1(IndentorName state) {
    setState(() {
      selectIndentorName = state;
    });
  }
  Future<void> _refresh() async{
    await Future.delayed(const Duration(milliseconds: 800),() {
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      edgeOffset: 20,
      displacement: 200,
      strokeWidth: 5,
      onRefresh: _refresh,
      child: SingleChildScrollView(
        child: Form(
          key: materialRequestApprovalFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedbox1,
              formsHeadText("Indant Date"),
              Container(
                padding: dateFieldPadding,
                height: dateFieldHeight,
                child: TextFormField(
                  validator: (val){
                    if(val.isEmpty) {
                      return 'Enter Detail';
                    }
                    if(val != dateinput.text) {
                      return 'Enter Correct Detail';
                    }
                    return null;
                  },
                  controller: dateinput,
                  decoration: dateFieldDecoration(),
                  readOnly: true,
                  onTap: () async {
                    DateTime pickedDate = await showDatePicker(
                        context: context, initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101)
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                    } else {
                    }
                  },
                ),
              ),
              formsHeadText("Indant Selection"),
              Padding(
                padding: padding1,
                child: Container(
                  height: 52, width: 343,
                  decoration: decorationForms(),
                  child: FutureBuilder<List<IndentorName>>(
                      future: _dropdownBloc.indentorNameDropdownData,
                      builder: (context, snapshot) {
                        return StreamBuilder<IndentorName>(
                            stream: _dropdownBloc.selectedState,
                            builder: (context, item) {
                              return SearchChoices<IndentorName>.single(
                                icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                                padding: selectIndentorName!=null ? 2 : 11,
                                isExpanded: true,
                                hint: "Search here",
                                value: selectIndentorName,
                                displayClearIcon: false,
                                onChanged: onDataChange1,
                                items: snapshot?.data
                                    ?.map<DropdownMenuItem<IndentorName>>((e) {
                                  return DropdownMenuItem<IndentorName>(
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
              ),
              //SizedBox(height: 10,),
              //const InformationBoxContainer1(),
              //SizedBox(height: 10,),
              //const InformationBoxContainer1(),
              const MaterialApprovalPageContainerData(),
            /*  sizedbox1,
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Approve",(){

                  },roundedButtonHomeColor1)),
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Deny",(){},roundedButtonHomeColor2)),
              Padding(
                  padding: padding4,
                  child: roundedButtonHome2("Wait",(){},roundedButtonHomeColor3)),*/
            ],
          ),
        ),
      ),
    );
  }
}