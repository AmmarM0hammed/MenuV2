import 'dart:io';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuv2/function/theme.dart';
import 'package:menuv2/model/CategoryModels.dart';
import 'package:menuv2/model/FoodModels.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:unicons/unicons.dart';
import 'package:uuid/uuid.dart';

import '../function/craeteFolder.dart';

class UploadScreen extends StatefulWidget {
  UploadScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  //TODO for Database dropdown
  CategoryView _categoryView = new CategoryView();
  List<Map> category = [];
  String? selectItem;

  Future<String> getData() async {
    category = await _categoryView.getData();
    setState(() {});
    return "Sec";
  }

  // TODO for inputText Contorller

  final _formKey = new GlobalKey<FormState>();

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _price = new TextEditingController();
  final TextEditingController _disc = new TextEditingController();

  // TODO image picker

  File? imageTemp;
  String? newImagePath;
  Future pickImage() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.imageTemp = imageTemp;
        print(this.imageTemp!.path);
      });
    } on PlatformException catch (e) {
      print("Fiald pic image : $e");
    }
  }

  // TODO upload Image to local file
  Future uploadImage() async {
    var res = await Permission.storage.request();

    if (res.isGranted) {
      final folderLocation = await createFolder("menuImage/");
      var uuid = Uuid();
      final imageuuid = uuid.v4() + ".jpg";
      if (imageTemp != null) {
        final File saveImage =
            await imageTemp!.copy(folderLocation + imageuuid);
        setState(() {
          newImagePath = saveImage.path;
        });
      }
    }
  }

  // TODO Submit form
  formSubmit() async {
    if (imageTemp == null) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "يجب اختيار صورة",
        desc: "",
        buttons: [
          DialogButton(
            color: Colors.green,
            child: Text(
              "فهمت",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          ),
        ],
      ).show();
    } else {
      if (_formKey.currentState!.validate()) {
        print("Submit");
        await uploadImage();
        print(newImagePath);
        MenuAdd _menuSQL = new MenuAdd(
            name: _name.value.text,
            price: _price.value.text,
            disc: _disc.value.text,
            category: selectItem!,
            image: newImagePath!);
        var state = _menuSQL.addMenu();

        if (state != null) {
          _name.clear();
          _price.clear();
          _disc.clear();

          //  imageTemp = null;
          // newImagePath = "";

          Alert(
            context: context,
            type: AlertType.success,
            title: "تم الرفع بنجاح",
            desc: "",
            buttons: [
              DialogButton(
                color: Colors.green,
                child: Text(
                  "فهمت",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 120,
              ),
            ],
          ).show();

          view();
        }
      }
    }
  }

  // ! JUST DEBUG !
  Future view() async {
    MenuView _menu = new MenuView(category: "بيتزا");
    print(await _menu.getData());
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              JK_AppBar(
                  title: "اضافة طبق",
                  icon: UniconsLine.angle_left,
                  onPress: () {
                    Navigator.pop(context);
                  }),
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: JK_Input(
                        text: " اسم الطبق",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        backgroundColor: JK_LigtWhite,
                        borderRadius: 50,
                        borderColor: JK_Primery,
                        rightIcon: Icon(
                          UniconsLine.restaurant,
                          color: JK_Primery,
                        ),
                        maxLength: 20,
                        controler: _name,
                        validator: (value) {
                          if (value!.isEmpty) return "اسم الطبق مطلوب";
                        },
                        
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: JK_Input(
                        text: "السعر",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        backgroundColor: JK_LigtWhite,
                        borderRadius: 50,
                        borderColor: JK_Primery,
                        rightIcon: Icon(
                          UniconsLine.dollar_alt,
                          color: JK_Primery,
                        ),
                        maxLength: 20,
                        controler: _price,
                        validator: (value) {
                          if (value!.isEmpty) return " السعر مطلوب";
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: JK_Input(
                        text: "الوصف",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                        backgroundColor: JK_LigtWhite,
                        borderRadius: 25,
                        borderColor: JK_Primery,
                        maxLine: 6,
                        maxLength: 100,
                        controler: _disc,
                        validator: (value) {
                          if (value!.isEmpty) return "الوصف  مطلوب";
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    dropdownCategory(),
                    SizedBox(height: 15),

                    //? Select Image
                    Center(
                      child: InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: JK_White,
                            border: Border.all(color: JK_Primery),
                          ),
                          child: (imageTemp == null)
                              ? Icon(
                                  UniconsLine.camera_plus,
                                  size: 40,
                                  color: JK_Primery,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.file(imageTemp!),
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: 50),
                    JK_Button(
                        width: 250,
                        text: "اضافة",
                        backgroundColor: JK_Primery,
                        borderRadius: 50,
                        borderColor: JK_Primery,
                        textColor: JK_White,
                        onPress: () {
                          formSubmit();
                          view();
                        }),
                    SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding dropdownCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField2(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: JK_Primery),
              borderRadius: BorderRadius.circular(50),
            ),
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: JK_Primery),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          isExpanded: true,
          hint: const Text(
            'القسم',
            style: TextStyle(fontSize: 16),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 30,
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.only(left: 20, right: 20),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          items: category.map((item) {
            return new DropdownMenuItem(
              child: new Text(item['name']),
              value: item['name'].toString(),
            );
          }).toList(),
          validator: (value) {
            if (value == null) {
              return 'الرجاء اختار القسم.';
            }
          },
          onChanged: (value) {
            setState(() {
              selectItem = value.toString();
            });
          },
          onSaved: (value) {
            selectItem = value.toString();
          },
        ),
      ),
    );
  }
}
