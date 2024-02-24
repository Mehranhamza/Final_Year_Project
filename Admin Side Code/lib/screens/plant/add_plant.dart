import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class add_plant extends StatefulWidget {
  const add_plant({super.key});

  @override
  State<add_plant> createState() => _add_plantState();
}

class _add_plantState extends State<add_plant> {
  TextEditingController PlantIDController = TextEditingController();
  TextEditingController PlantNameController = TextEditingController();
  TextEditingController PlantDescriptionController = TextEditingController();
  TextEditingController PlantPriceController = TextEditingController();
  TextEditingController PlantTempratureController = TextEditingController();

  bool _isImagePicked = false;
  bool _is3dModelPicked = false;
  bool _isdataUploaded = false;
  FilePickerResult? _Plant_Image;
  FilePickerResult? _3D_Model;
  String? SeasonType;
  String? _Plant_Image_URL;
  String? _3D_Model_URL;
  Future<void> AddData() async {
    setState(() {
      _isdataUploaded = true;
    });
    if (_3D_Model != null) {
      Reference root = FirebaseStorage.instance.ref();
      Reference DIR = root.child('3D_Models');
      Reference ModelDIR = DIR.child('${_3D_Model!.files.first.name}');
      if (kIsWeb) {
        List<int> bytes = await _3D_Model!.files.first.bytes ?? [];
        await ModelDIR.putData(Uint8List.fromList(bytes));

        _3D_Model_URL = await ModelDIR.getDownloadURL();
      }
    }
    if (_Plant_Image != null) {
      Reference root = FirebaseStorage.instance.ref();
      Reference DIR = root.child('Plant_Images');
      Reference ImageDIR = DIR.child('${_Plant_Image!.files.first.name}');
      if (kIsWeb) {
        List<int> bytes = await _Plant_Image!.files.first.bytes ?? [];
        await ImageDIR.putData(Uint8List.fromList(bytes));

        _Plant_Image_URL = await ImageDIR.getDownloadURL();
      }
    }

    //Cloud FireStore

    await FirebaseFirestore.instance
        .collection('Plants')
        .doc('All_Seasons')
        .collection('$SeasonType')
        .doc('${PlantNameController.text}')
        .set({
      'Plant_ID': PlantIDController.text,
      'Plant_Name': PlantNameController.text,
      'Plant_Description': PlantDescriptionController.text,
      'Plant_Price': PlantPriceController.text,
      'Plant_Image_URL': _Plant_Image_URL,
      'Temprature': double.parse(PlantTempratureController.text),
      'Model_Name': PlantNameController.text,
      'Model_URL': _3D_Model_URL
    });

    setState(() {
      _isdataUploaded = false;
      PlantIDController.clear();
      PlantNameController.clear();
      PlantDescriptionController.clear();
      PlantPriceController.clear();
      PlantTempratureController.clear();
      SeasonType = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Season',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF86A7FC))),
                    onPressed: () {
                      SeasonType = 'Winter';
                    },
                    icon: Image.asset(
                      'icons/winter.png',
                      height: 50,
                      width: 50,
                    ),
                    label: Text(
                      'winter'.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFCEDEBD))),
                    onPressed: () {
                      SeasonType = 'Spring';
                    },
                    icon: Image.asset(
                      'icons/spring.png',
                      height: 50,
                      width: 50,
                    ),
                    label: Text(
                      'spring'.toUpperCase(),
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFFFDD95))),
                    onPressed: () {
                      SeasonType = 'Summer';
                    },
                    icon: Image.asset(
                      'icons/summer.png',
                      height: 50,
                      width: 50,
                    ),
                    label: Text(
                      'Summer'.toUpperCase(),
                      style: TextStyle(color: Colors.black),
                    )),
                TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFFF9800))),
                    onPressed: () {
                      SeasonType = 'Autumn';
                    },
                    icon: Image.asset(
                      'icons/autumn.png',
                      height: 50,
                      width: 50,
                    ),
                    label: Text(
                      'autumn'.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: 300,
                        child: TextField(
                          controller: PlantIDController,
                          decoration: InputDecoration(
                              icon: Image.asset(
                                'icons/id.png',
                                height: 50,
                                width: 50,
                              ),
                              border: OutlineInputBorder(),
                              label: Text("Enter plant id".toUpperCase())),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Container(
                        width: 400,
                        child: TextField(
                          controller: PlantNameController,
                          decoration: InputDecoration(
                              icon: Image.asset(
                                'icons/name.png',
                                height: 50,
                                width: 50,
                              ),
                              border: OutlineInputBorder(),
                              label: Text("Enter plant Name".toUpperCase())),
                        ))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  children: [
                    Container(
                        width: 400,
                        child: TextField(
                          controller: PlantDescriptionController,
                          decoration: InputDecoration(
                              icon: Image.asset(
                                'icons/desc.png',
                                height: 50,
                                width: 50,
                              ),
                              border: OutlineInputBorder(),
                              label: Text(
                                  "Enter plant Description".toUpperCase())),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    Container(
                        width: 400,
                        child: TextField(
                          controller: PlantPriceController,
                          decoration: InputDecoration(
                              icon: Image.asset(
                                'icons/price.png',
                                height: 50,
                                width: 50,
                              ),
                              border: OutlineInputBorder(),
                              label: Text("Enter plant price".toUpperCase())),
                        )),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                    width: 400,
                    child: TextField(
                      controller: PlantTempratureController,
                      decoration: InputDecoration(
                          icon: Image.asset(
                            'icons/temprature.png',
                            height: 50,
                            width: 50,
                          ),
                          border: OutlineInputBorder(),
                          label: Text("temprature in celcius".toUpperCase())),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Row(
                  children: [
                    TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF65B741)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isImagePicked = true;
                          });
                          FilePickerResult? image =
                              await FilePicker.platform.pickFiles();
                          setState(() {
                            _Plant_Image = image;
                            _isImagePicked = false;
                          });
                        },
                        icon: Image.asset(
                          'icons/plantimage.png',
                          height: 50,
                          width: 50,
                        ),
                        label: Text('Pick Plant image'.toUpperCase())),
                    SizedBox(
                      width: 5,
                    ),
                    _isImagePicked == true
                        ? SpinKitCircle(
                            color: Colors.green,
                          )
                        : Container(
                            height: 0,
                          )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        TextButton.icon(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF65B741)),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () async {
                              setState(() {
                                _is3dModelPicked = true;
                              });
                              FilePickerResult? model =
                                  await FilePicker.platform.pickFiles();
                              setState(() {
                                _3D_Model = model;
                                _is3dModelPicked = false;
                              });
                            },
                            icon: Image.asset(
                              'icons/3dPlant.png',
                              height: 50,
                              width: 50,
                            ),
                            label: Text('Pick 3d Model'.toUpperCase())),
                        _is3dModelPicked == true
                            ? SpinKitCircle(
                                color: Colors.green,
                              )
                            : Container(
                                height: 0,
                              ),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isdataUploaded == true
                            ? Center(
                                child: SpinKitDoubleBounce(
                                  color: Colors.red,
                                ),
                              )
                            : Container(
                                height: 0,
                              )
                      ],
                    ))
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: AddData,
                child: Text(
                  'Add plant'.toUpperCase(),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
