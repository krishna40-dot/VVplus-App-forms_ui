import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/indentor_name_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_cost_center_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/Dropdown_Bloc/item_current_status_dropdown_bloc.dart';
import 'package:vvplus_app/Application/Bloc/staff%20bloc/Purchase_Page_Bloc/material_request_entry_page_bloc.dart';
import 'package:vvplus_app/infrastructure/Models/indentor_name_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_cost_center_model.dart';
import 'package:vvplus_app/infrastructure/Models/item_current_status_model.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/form_text.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_containers.dart';
import 'package:vvplus_app/ui/pages/Staff%20UI/widgets/staff_text_style.dart';
import 'package:vvplus_app/ui/widgets/Utilities/raisedbutton_text.dart';
import 'package:vvplus_app/ui/widgets/Utilities/rounded_button.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';


class AddItemContainer extends StatelessWidget {
  final String itemNameText;
  final String orderQtyText;
  final String rateText;
  final String amountText;
  const AddItemContainer({
    Key key,
    this.itemNameText,
    this.orderQtyText,
    this.rateText,
    this.amountText,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        alignment: Alignment.center,
        height: 92,
        width: SizeConfig.getWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: primaryColor3,
          boxShadow: const [
            BoxShadow(
              color: primaryColor5,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(itemNameText,
                      style: containerTextStyle1(),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Qty.:",
                              style: containerTextStyle2(),
                            ),
                            const Text( ""//reqQty,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),

                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Rate:",
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Amount:",
                          style: containerTextStyle2(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4,top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 2,
                        ),
                        Text(orderQtyText,
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(rateText,
                          style: containerTextStyle2(),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(amountText,
                          style: containerTextStyle2(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(icon15),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Text('Edit',
                          style: containerTextStyle8()),
                        ),
                        const SizedBox(height: 2),
                  Text('Inc. Tax',
                  style: containerTextStyle7()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  /*CreateAlertDialouge(BuildContext context){
    TextEditingController reqQty = TextEditingController();
    reqQty.text =orderQtyText ;

    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content:  Column(
          children: <Widget>[
            Text("Edit Item"),
            const SizedBox(height: 5),
            Text('Item'),
            editItemDropdown(),
            Text('Request. Qty'),
            TextField(
              controller: reqQty,
            ),
          ],
        ),
      );
    });
  }
}

class editItemDropdown extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _editItemDropdown();
}

class _editItemDropdown extends State<editItemDropdown>{
  ItemCurrentStatusDropdownBloc dropdownBlocItemCurrentStatus;
  ItemCurrentStatus selectItemCurrentStatus;
  void onDataChange2(ItemCurrentStatus state) {
    setState(() {
      selectItemCurrentStatus= state;
    });
  }

  @override
  Widget build(BuildContext context) {
   return  Padding(
     padding: padding1,
     child: Container(
       height: 52, width: 50,
       decoration: decorationForms(),
       child: FutureBuilder<List<ItemCurrentStatus>>(
           future: dropdownBlocItemCurrentStatus.itemCurrentStatusDropdowndata,
           builder: (context, snapshot) {
             return StreamBuilder<ItemCurrentStatus>(
                 stream: dropdownBlocItemCurrentStatus.selectedState,
                 builder: (context, item) {
                   return SearchChoices<ItemCurrentStatus>.single(
                     icon: const Icon(Icons.keyboard_arrow_down_sharp,size:30),
                     padding: selectItemCurrentStatus!=null ? 2 : 11,
                     isExpanded: true,
                     hint: "Search here",
                     value: selectItemCurrentStatus,
                     displayClearIcon: false,
                     onChanged: onDataChange2,
                     items: snapshot?.data
                         ?.map<DropdownMenuItem<ItemCurrentStatus>>((e) {
                       return DropdownMenuItem<ItemCurrentStatus>(
                         value: e,
                         child: Text(e.strItemName),
                       );
                     })?.toList() ??[],
                   );
                 }
             );
           }
       ),
     ),
   );
  }*/
}


