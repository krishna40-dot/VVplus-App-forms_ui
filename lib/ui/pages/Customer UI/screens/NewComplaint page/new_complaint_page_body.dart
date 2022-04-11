// ignore_for_file: missing_return, deprecated_member_use, avoid_print

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:vvplus_app/Application/Bloc/Customer_Bloc/NewComplaint_Bloc/new_complaint_bloc.dart';
import 'package:vvplus_app/ui/Pages/Customer%20UI/widgets/text_style_widget.dart';
import 'package:vvplus_app/ui/pages/Customer%20UI/widgets/decoration_widget.dart';
import 'package:vvplus_app/ui/widgets/constants/assets.dart';
import 'package:vvplus_app/ui/widgets/constants/colors.dart';
import 'package:vvplus_app/ui/widgets/constants/size.dart';
import 'package:vvplus_app/ui/widgets/constants/text_feild.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io' as io;
import 'package:path/path.dart' as path;


class NewComplaintPageBody extends StatefulWidget{
  const NewComplaintPageBody({Key key}) : super(key: key);
  @override
  _NewComplaintPageBodyState createState() => _NewComplaintPageBodyState();
}
class _NewComplaintPageBodyState extends State<NewComplaintPageBody>{

  final TextEditingController _name = TextEditingController();
  final TextEditingController _branchAndCity = TextEditingController();
  final TextEditingController _unitNumber = TextEditingController();
  final TextEditingController _problem = TextEditingController();
  File imageFile;
  final _storage = FirebaseStorage.instance;
  String imgUrl;

  Future<String> saveuserImage(File file) async {
    try {
      Reference ref =
      _storage.ref().child('images/.${file.path}');
      UploadTask task = ref.putFile(File(file.path));
      return await task.then(
            (result) => result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
    }
  }

  _imgFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  _imgFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
    );
  }
  String imageUrl;

  uploadImage() async {

      if (imageFile != null){
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('images/')
            .putFile(imageFile);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
          print(imageUrl);
        });
      } else {
        print('No Path Received');
      }
  }
  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = path.basename(imageFile.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref().child('images').child('chats/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'chats': fileName});
    firebase_storage.UploadTask uploadTask;
    //StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(imageFile.path), metadata);

    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
      print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });



  }
  Future uploadImageToFirebase1(BuildContext context) async {
  //  String fileName = Path.basename(imageFile.path);
   // Reference firebaseStorageRef =
   // FirebaseStorage.instance.ref().child('uploads/$fileName');
   // UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
   // TaskSnapshot taskSnapshot = (await uploadTask.whenComplete) as TaskSnapshot;
  //  taskSnapshot.ref.getDownloadURL().then(
    //      (value) => print("Done: $value"),
   // );
    String fileName = path.basename(imageFile.path);
    Reference reference = _storage.ref('images');
    final TaskSnapshot snapshot = await reference.putFile(imageFile);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = NewComplaintPageBloc();
    return SingleChildScrollView(
          child: Container(
            width: SizeConfig.getWidth(context),
            height: SizeConfig.getHeight(context),
            decoration: const BoxDecoration(
              color: primaryColor3,
            ),
            child: Stack(
              children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 19),
                  Container(
                    height: 50,
                    padding: padding1,
                    decoration: decoration1(),
                    child: StreamBuilder<String>(
                        stream: bloc.outTextField1,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _name,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: bloc.inTextField1,
                            style: simpleTextStyle7(),
                            decoration:InputDecoration(
                              fillColor: primaryColor3,
                              filled: true,
                              enabledBorder: newComplaintTextFieldOutlineBorder(),
                              focusedBorder: newComplaintTextFieldOutlineBorder(),
                              prefix: Padding(padding: newComplaintTextPadding,),
                              hintText: "Name",
                              hintStyle: const TextStyle(color: primaryColor4,),
                              errorText: snapshot.error,
                            ),
                          );
                        }
                    ),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    height: 50,
                    padding: padding1,
                    decoration: decoration1(),
                    child: StreamBuilder<String>(
                        stream: bloc.outTextField2,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _branchAndCity,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: bloc.inTextField2,
                            style: simpleTextStyle7(),
                            decoration:InputDecoration(
                              fillColor: primaryColor3,
                              filled: true,
                              enabledBorder: newComplaintTextFieldOutlineBorder(),
                              focusedBorder: newComplaintTextFieldOutlineBorder(),
                              prefix: Padding(padding: newComplaintTextPadding,),
                              hintText: "Branch and City",
                              hintStyle: const TextStyle(color: primaryColor4,),
                              errorText: snapshot.error,
                            ),
                          );
                        }
                    ),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    height: 50,
                    padding: padding1,
                    decoration: decoration1(),
                    child: StreamBuilder<String>(
                        stream: bloc.outTextField3,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _unitNumber,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: bloc.inTextField3,
                            style: simpleTextStyle7(),
                            decoration:InputDecoration(
                              fillColor: primaryColor3,
                              filled: true,
                              enabledBorder: newComplaintTextFieldOutlineBorder(),
                              focusedBorder: newComplaintTextFieldOutlineBorder(),
                              prefix: Padding(padding: newComplaintTextPadding,),
                              hintText: "Unit Number",
                              hintStyle: const TextStyle(color: primaryColor4,),
                              errorText: snapshot.error,
                            ),
                          );
                        }
                    ),
                  ),
                  const SizedBox(height: 13),
                  Container(
                    height: 97,
                    padding: padding1,
                    decoration: decoration1(),
                    child: StreamBuilder<String>(
                        stream: bloc.outTextField4,
                        builder: (context, snapshot) {
                          return TextFormField(
                            controller: _problem,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: bloc.inTextField4,
                            style: simpleTextStyle7(),
                            maxLines:3,
                            decoration:InputDecoration(
                              fillColor: primaryColor3,
                              filled: true,
                              enabledBorder: newComplaintTextFieldOutlineBorder(),
                              focusedBorder: newComplaintTextFieldOutlineBorder(),
                              prefix: Padding(padding: newComplaintTextPadding,),
                              hintText: textNewComplaint,
                              hintStyle: const TextStyle(color: primaryColor4,),
                              errorText: snapshot.error,
                            ),
                          );
                        }
                    ),
                  ),
                 const SizedBox(height: 18,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      text25,
                      style: simpleTextStyle7(),
                    ),
                  ),
                  const SizedBox(height: 1),
                  Padding(
                    padding: padding1,
                    child: Center(
                      child: Container(
                        height: 52,
                        decoration: decoration3(),
                        child: StreamBuilder(
                            stream: bloc.outDropField1,
                            builder: (context, snapshot) {
                              return SearchChoices.single(
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                iconEnabledColor: textColor3,
                                style: const TextStyle(color: primaryColor2,fontSize: 20),
                                padding: 10,
                                displayClearIcon: false,
                                isExpanded: true,
                                hint: const Text(text22),
                                value: snapshot.data,
                                onChanged: bloc.inDropField1,
                                items:(bloc.names != null && bloc.names.isNotEmpty)
                                    ? bloc.names.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),);}).toList():[],
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3,),
                   Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      text26,
                      style: simpleTextStyle10(
                        Colors.black45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  imageBoxContainer(context),
                  const SizedBox(height: 12),
                  GestureDetector(                                                   //Onpressed
                    onTap: () {uploadImageToFirebase1(context);},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: primaryColor1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        width: SizeConfig.getWidth(context) * .83,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              text24,
                              style: simpleTextStyle1(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ],
            ),
          ),
        );
  }
  Widget imageBoxContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {_showPicker(context);},
      child: imageFile == null
          ? Padding(
          padding: padding1,
          child: DottedBorder(
            color: primaryColor2,
            strokeWidth: 1.5,
            dashPattern: const [10,6],
            child: Container(
              child: Column(
                children:  [
                  Padding(
                      padding: padding5,
                      child: Image.asset(image3)
                  ),
                  Padding(
                      padding: padding6,
                      child: Image.asset(image4)
                  ),
                  Padding(
                    padding: padding7,
                    child: const Text(
                      text23,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              height:140,
              width: double.infinity,
              color:primaryColor3,
            ),
          )
      ):Padding(
        padding: padding1,
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
