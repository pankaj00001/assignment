import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/helper.dart';

import 'dateModel.dart';

class homePage extends StatefulWidget {
   homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  bool _isLoading=true;
  File? myImage;
  List<dateModel> _yearList=[
    new dateModel(year:"2021", value:false),
    new dateModel(year:"2020", value:false),
    new dateModel(year:"2019", value:false),
    new dateModel(year:"2018", value:false),
    new dateModel(year:"2017", value:false),
    new dateModel(year:"2016", value:false),
    new dateModel(year:"2015", value:false),
    new dateModel(year:"2014", value:false),
    new dateModel(year:"2013", value:false),
    new dateModel(year:"2012", value:false),
  ];

  List<dateModel> _genderList=[
    new dateModel(gender: "Female", value: false),
    new dateModel(gender: "Male", value: false),
    new dateModel(gender: "Other", value: false),

  ];
  int i=1;
  TextEditingController name = new TextEditingController(text: "P");
  TextEditingController _superVisiorText = new TextEditingController();
  TextEditingController _departmentText = new TextEditingController();
  TextEditingController _whatNoText = new TextEditingController();
  TextEditingController _dojText = new TextEditingController();
  TextEditingController _emailText = new TextEditingController();
  TextEditingController _whatNoText2 = new TextEditingController();
  TextEditingController _mobileNoText = new TextEditingController();
  TextEditingController _genderText = new TextEditingController();
  TextEditingController _facebookText = new TextEditingController();
  TextEditingController _instagaramText = new TextEditingController();
  TextEditingController _twitterText = new TextEditingController();
  TextEditingController _linkedinText = new TextEditingController();
  TextEditingController _higherQualText = new TextEditingController();
  TextEditingController _collegeNameText = new TextEditingController();
  TextEditingController _passingText = new TextEditingController();
  TextEditingController _uploadPhotoText = new TextEditingController();

  PermissionStatus permissionStatus = PermissionStatus.denied;


  Permission? permission;

  String? imageUrl;
  void _ListenForPermission()async{
    final status = await Permission.storage.status; //help to get that the permision status
    //set state help to find the value is changing
    setState(() {
      permissionStatus = status;
    });

    //now checking the status
    switch(status){
      case PermissionStatus.denied:
        requestForPermission();
        break;

      case PermissionStatus.granted:
      //do nothing
        break;

      case PermissionStatus.limited:
        Navigator.pop(context);
        break;
      case PermissionStatus.restricted:
        Navigator.pop(context);
        break;
      case PermissionStatus.permanentlyDenied:
        Navigator.pop(context);
        break;
    }
  }
// requesting for the permission..means app run and the it checks the storage permission..and if it denied then it run this code..
//   and run till it denied..and storing the permission into it

  Future<void> requestForPermission()async{
    final status = await Permission.storage.request();
    setState(() {
      permissionStatus = status;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*sizeWidth=MediaQuery.of(context).size.width;
    sizeHeight=MediaQuery.of(context).size.height;*/
    print(permissionStatus);
    _ListenForPermission();
    _isLoading=false;
    _getdata("https://seedcrm.seedwill.co/public/api/flutter-screening/user/p123");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignmnt'),
      ),
      body: _isLoading?
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _widgetFirst(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    _widgetGeneral(),
                     Divider(
                      height: 3,
                      color: Colors.grey,
                    ),
                    _widgetInformation(),
                    _widgetEducational(),
                  _widgetSocial(),
                    SizedBox(
                      height: 20,
                    ),
                    _widgetButton(),
                    /* Divider(
                      height: 3,
                      thickness: 3,
                      color: Colors.grey,
                    ),*/
                  ],
                ),
              ),
            ),

          ],
        ),
      ):
      Container(
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            backgroundColor: Colors.blue,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }

  _widgetFirst() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.2,
            color: Colors.purple,
          ),
        ),

        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height*0.13,
              color: Colors.black,
              margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*0.14,
                left: 30,
                /*bottom: 20*/
            ),
              child: Stack(
                children: [
                  myImage==null?
                  Image.asset('asset/oneplus.png',fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height*0.13,
                  )
                      :Image.file(myImage!,fit: BoxFit.fill, width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height*0.13,),
                   Positioned(
                    bottom: 0.1,
                      // right: 1,
                      left: 21,
                      child: MaterialButton(onPressed:null,
                      child: Icon(Icons.edit,color: Colors.black,size: 20,),)
                  )
                ],
              ),
            ),
             SizedBox(width: 10,),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.09,
                /*left: 30,*/
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text("${name.text}$i", style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    decoration: TextDecoration.none
                  ),),
                  Text("#123455",style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.14),
          alignment: Alignment.bottomRight,
          child: MaterialButton(
            onPressed:null,
            child: Icon(Icons.clear,color: Colors.white,size: 20,),
          )
        )
      ],
    );
  }

  _widgetGeneral() {
   /* FocusNode myFocusNode = new FocusNode();*/
    return Container(
      margin:  EdgeInsets.only(left: 10,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: TextFormField(

                  decoration:  InputDecoration(
                    labelText: 'SuperVision',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  controller: _superVisiorText,
                  validator: (value){
                    if(value==null){
                      'SuperVision Cannot be null';
                    }
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: TextFormField(
                  decoration:  InputDecoration(
                      labelText: 'Department',
                    labelStyle: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  controller: _departmentText,
                  validator: (value){
                    if(value==null){
                      'SuperVision Cannot be null';
                    }
                  },
                ),
              ),
            ],
          ),

           SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.4,
            child: TextFormField(
              decoration:  InputDecoration(
                  labelText: 'WhatsApp No',
                labelStyle: TextStyle(
                  fontSize: 12,
                ),
              ),
              inputFormatters: [
                new LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.number,
              controller: _whatNoText,
              validator: (value){
                if(value==null){
                  return 'SuperVision Cannot be null';
                } else if (value.length != 10) {
                  return 'Enter Valid Number';
                }
              },
            ),
          ),

          Container(
            margin:  EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text("Personal Information" , style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15
                ),
                ),
                Container(
                  child: InkWell(
                    onTap: (){

                    },
                    child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.blue,),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _widgetInformation() {
    return Card(
      margin:  EdgeInsets.only(top: 5,left: 2),
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),*/
      elevation: 2,
      shadowColor: Colors.grey,
      child: Container(
        margin:  EdgeInsets.only(right: 5,left: 5),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Enter Email',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    controller: _emailText,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value==null){
                        'Email Cannot be null';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _mobileNoText,
                    validator: (value){
                      if(value==null){
                        'Mobile Number Cannot be null';
                      }
                    },
                  ),
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'WhatsApp No',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _whatNoText2,
                    validator: (value){
                      if(value==null){
                        'WhatsApp No Cannot be null';
                      }
                    },
                  ),
                ),

                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15,left: 2),
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Text('Select Gender', style: TextStyle(
                          fontSize: 12
                      ),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      // margin: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black38)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_genderText.text}'),
                          Container(
                            height: 30,
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: (){
                                _getGender();
                              },
                              child: Icon(Icons.keyboard_arrow_down,size: 25,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),


              ],
            ),


            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15,left: 2),
                  width: MediaQuery.of(context).size.width*0.4,
                  child: Text('DOJ', style: TextStyle(
                    fontSize: 12
                  ),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  // margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black38)
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_dojText.text}'),
                      Container(
                        height: 30,
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: ()  {
                            _selectTheDate();
                          },
                          child: Icon(Icons.calendar_today_outlined,size: 15,),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            Container(
              margin:  EdgeInsets.only(left: 10,right: 10,top: 20),
             /* margin:  EdgeInsets.only(top: 20),*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Educational Information" , style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15
                  ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: (){

                      },
                      child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.blue,),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _selectTheDate() async{

    final datePick=await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate:  new DateTime(1900),
        lastDate: new DateTime(2023),
    );
    var currentTime=DateFormat('yyyy-MM-dd').format(datePick!);
    _dojText.text=currentTime.toString();
    print("datepick is this $currentTime");
    setState(() {

    });
  }

  _widgetEducational() {
    return Card(
      margin:  EdgeInsets.only(top: 5,left: 2),
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),*/
      elevation: 2,
      shadowColor: Colors.grey,
      child: Container(
        margin:  EdgeInsets.only(right: 5,left: 5),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Enter College Name',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    controller: _collegeNameText,
                    validator: (value){
                      if(value==null){
                        'College Name Cannot be null';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Enter Higher Qualification',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    controller: _higherQualText,
                    validator: (value){
                      if(value==null){
                        'Higher Qualification Cannot be null';
                      }
                    },
                  ),
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15,left: 2),
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Text('Enter Passing Year', style: TextStyle(
                          fontSize: 12
                      ),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      // margin: EdgeInsets.only(top: 5),

                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.black38)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_passingText.text}'),
                          Container(
                            height: 30,
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: (){
                                _spineerYear();
                              },
                              child: Icon(Icons.calendar_today_outlined,size: 15,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Upload Photo', style: TextStyle(
                              fontSize: 12
                          ),),
                          Container(
                            height: 30,
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: (){
                                _getnewImage();
                              },
                              child: Icon(Icons.keyboard_arrow_down,size: 25,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.28,
                            margin: EdgeInsets.only(top: 5),
                            height: 30,
                            decoration: BoxDecoration(
                                border:/* Border(
                                    bottom: BorderSide(color: Colors.black38)
                                )*/
                              Border.all(color: Colors.black38),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${_uploadPhotoText.text}'),
                                /*Container(
                                  height: 30,
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: (){
                                      _getTheImage();
                                    },
                                    child: Icon(Icons.camera,size: 15,),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            // width: MediaQuery.of(context).size.width*0.1,
                            height: 30,
                            margin: EdgeInsets.only(top: 4,left: 1),
                            alignment: Alignment.bottomRight,
                            color: Colors.grey,
                            child: InkWell(
                              onTap: (){
                                _getTheImage();
                              },
                              child: Center(
                                child: Text("Browse",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            ),

            Container(
              margin:  EdgeInsets.only(left: 10,right: 10,top: 20),
              /* margin:  EdgeInsets.only(top: 20),*/
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Social Information" , style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15
                  ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: (){

                      },
                      child: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.blue,),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  _widgetSocial() {
    return Card(
      margin:  EdgeInsets.only(top: 5,left: 2),
      /*shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),*/
      elevation: 2,
      shadowColor: Colors.grey,
      child: Container(
        margin:  EdgeInsets.only(right: 5,left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Facebook',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    controller: _facebookText,
                    validator: (value){
                      if(value==null){
                        'Facebook Cannot be null';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Linkedin',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    controller: _linkedinText,
                    validator: (value){
                      if(value==null){
                        'Linkedin Cannot be null';
                      }
                    },
                  ),
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Instagram',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    controller: _instagaramText,
                    validator: (value){
                      if(value==null){
                        'Instagram Cannot be null';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: TextFormField(
                    decoration:  InputDecoration(
                      labelText: 'Twitter',
                      labelStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    readOnly: true,
                    controller: _twitterText,
                    validator: (value){
                      if(value==null){
                        'Twitter Cannot be null';
                      }
                    },
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }


  final picker =
  ImagePicker();
  File? result;
  String? base64Image;

  void _getTheImage() async {

    final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        imageQuality: 100); //this will open the camera app and your are able to click the image

    setState(() {
      imageUrl=null;
      if (pickedImage != null) {
        setState(() {
          myImage = File(pickedImage.path);
        });
        print("$myImage image");
        _uploadPhotoText.text="Image.Jpeg";
        imageConversion();
      } else {
        print("no image Selected");
      }
    });


  }

  Future<void> imageConversion() async {
    // List<int> imageBytes = await myImage.readAsBytes();
    // base64Image = base64Encode(imageBytes);

    List<int> imageBytes;
    final filePath = myImage!.absolute.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

      result = await FlutterImageCompress.compressAndGetFile(
        myImage!.absolute.path,
        outPath,
        quality: 35,

      );
      print("Gallery");

    imageBytes = await result!.readAsBytes();
    setState(() {

      base64Image = base64Encode(imageBytes);

    });
    print(base64Image);

    print(myImage!.lengthSync());
    print(result!.lengthSync());


  }



  void _getGender() async{

    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        // width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(5),
                        child:Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Choose Gender",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    Align(
                      // These values are based on trial & error method
                      //  alignment: Alignment(1.05, -1.05),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],)
            ),
            Align(
              // alignment: Alignment.bottomCenter,
              child:Container(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _genderList.length,
                  itemBuilder: (BuildContext context,int index){
                    return InkWell(child:Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 0.2),
                            borderRadius: BorderRadius.circular(1)
                        ),

                        child:Row(
                          children: <Widget>[

                            Expanded(child:Container(
                                margin: EdgeInsets.only(left: 5,right: 5),

                                alignment: Alignment.centerLeft,
                                child:Text('${_genderList[index].gender}',
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color:Colors.black,fontSize: 14.0)))),

                            Expanded(
                                child:Align(
                                  // width: 20,
                                    alignment: Alignment.centerRight,
                                    child:Checkbox(

                                      onChanged: (bool? value) {
                                        setState(() {
                                          // SpinnerClaimStatusCheck=value;
                                          for(int i=0;i< _genderList.length;i++) {
                                            if (_genderList[i].value == true) {
                                              _genderList[i].value = false;
                                            }
                                          }

                                          if(_genderList[index].value==false) {

                                            _genderText.text = _genderList[index].gender!;
                                            _genderList[index].value = true;

                                          }

                                          Navigator.pop(context,1);

                                        });
                                      }, value:_genderList[index].value,
                                    ))),
                          ],
                        )
                    ),
                        onTap: (){

                        }
                    );
                  },
                ),
              ),),

          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  void _spineerYear() async{

    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        // width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(5),
                        child:Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Choose Year Passing",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    Align(
                      // These values are based on trial & error method
                      //  alignment: Alignment(1.05, -1.05),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],)
            ),
            Align(
              // alignment: Alignment.bottomCenter,
              child:Container(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _yearList.length,
                  itemBuilder: (BuildContext context,int index){
                    return InkWell(child:Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 0.2),
                            borderRadius: BorderRadius.circular(1)
                        ),

                        child:Row(
                          children: <Widget>[

                            Expanded(child:Container(
                                margin: EdgeInsets.only(left: 5,right: 5),

                                alignment: Alignment.centerLeft,
                                child:Text('${_yearList[index].year}',
                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color:Colors.black,fontSize: 14.0)))),

                            Expanded(
                                child:Align(
                                  // width: 20,
                                    alignment: Alignment.centerRight,
                                    child:Checkbox(

                                      onChanged: (bool? value) {
                                        setState(() {
                                          // SpinnerClaimStatusCheck=value;
                                          for(int i=0;i< _yearList.length;i++) {
                                            if (_yearList[i].value == true) {
                                              _yearList[i].value = false;
                                            }
                                          }

                                          if(_yearList[index].value==false) {

                                            _passingText.text = _yearList[index].year!;
                                            _yearList[index].value = true;

                                          }

                                          Navigator.pop(context,1);

                                        });
                                      }, value:_yearList[index].value,
                                    ))),
                          ],
                        )
                    ),
                        onTap: (){

                        }
                    );
                  },
                ),
              ),),

          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  _widgetButton() {
    return MaterialButton(
        splashColor: Colors.white,
        child: new Text(
        "Create User",
        style: new TextStyle(color: Colors.white, fontSize: 16),
    ),
    color: Colors.blue,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    onPressed: () async {
      print("in this submit button");
          if(_superVisiorText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "SuperVisor Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_departmentText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Department Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_whatNoText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Whatsapp Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_emailText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Email Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_whatNoText2.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Personal What Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_mobileNoText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Mobile Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_genderText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Gender Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_dojText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "DOJ Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_collegeNameText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "_College Name Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_higherQualText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "Higher Qualification Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(base64Image==null){
            Fluttertoast.showToast(
                msg: "Photo Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }/*else if(_departmentText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "SuperVisor Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(_departmentText.text.isEmpty){
            Fluttertoast.showToast(
                msg: "SuperVisor Is Not Empty!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }*/else{
            print("everything is ok");
            String url="https://seedcrm.seedwill.co/api/flutter-screening/user";
            name.text="${name.text}$i";
            print("name is ${name.text}");
            var body=json.encode({
              "inserted_by" : "${name.text}",
              "name" : "pankaj123",
              "supervisor_name" : "${_superVisiorText.text}",
              "department_name" : "${_departmentText.text}",
              "email" : "${_emailText.text}",
              "mobile_number" : "${_mobileNoText.text}",
              "whatsapp_number" : "${_whatNoText.text}",
              "gender" : "${_genderText.text}",
              "doj" : "${_dojText.text}",
              "college_name" : "${_collegeNameText.text}",
              "higher_qualification" : "${_higherQualText.text}",
              "profile_image" : "data:image/jpeg;base64,${base64Image}",
              "education_image" : "data:image/jpeg;base64,${base64Image}",
              "passing_year" : "${_passingText.text}",
              "created_at" : "${DateTime.now()}"
            });
            _isLoading=false;
            postdata(url,body);
          }

    }
    );
  }


  Future<dynamic> postdata(String url, var body) async {

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",

    };
    print("the body $body");
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    ioClient.post(Uri.parse(url), body: body, headers: headers)
        .then((response) {
      print(response.body);
      print('My postdata response = $response');
      final int statusCode = response.statusCode;
      print('My postdata response statusCode =$statusCode');

      if(statusCode==401){

        setState(() {
          _isLoading=true;
        });
        var obj = json.decode(response.body);
        print('My postdata   statuscode=$statusCode response obj = $obj');
        String Message =obj['message'];
      }else if(statusCode==400){
        setState(() {
          _isLoading=true;
        });
        var obj = json.decode(response.body);
        print('My postdata   statuscode=$statusCode response obj = $obj');
        String Message =obj['message'];
         Fluttertoast.showToast(msg: "$Message",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
      else if (statusCode < 200 || statusCode > 400 || json == null) {
        setState(() {
          _isLoading=true;
        });
        var obj = json.decode(response.body);
        print('My postdata   statuscode=$statusCode response obj = $obj');
        String Message =obj['message'];



        throw new Exception("Error while fetching data");


      } else if (statusCode == 200) {
        String id_user;
        String Status;
        String Type1;
        String Message;
        String TrainId;
        var obj = json.decode(response.body);
        print('My postdata  response obj = $obj');


        Message=obj['message'];

         Fluttertoast.showToast(msg: "${Message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
             timeInSecForIosWeb: 1);



        setState(() {
          _isLoading=true;
        });
         sucessAlert();
      }
      return response;
    }).catchError((error) {
      Fluttertoast.showToast(msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
      setState(() {
        _isLoading=true;
      });
      print("My postdata errror ==$error");
    });
  }
  

  Future<dynamic> _getdata(String url)async{
    print('My Get _getdata  url = $url');

    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = new IOClient(httpClient);
    ioClient.get(Uri.parse(url),/*headers:headers*/).then((response) async {
      print(response.body);
      print('My Get _getdata response = $response');
      final int statusCode = response.statusCode;
      print('My Get _getdata response statusCode =$statusCode');
      if(statusCode==401){
        var obj = json.decode(response.body);
        print('My _getdata   statuscode=$statusCode response obj = $obj');
        String Message =obj['message'];
        setState(() {
          _isLoading=true;
        });
      }
      else  if (statusCode < 200 || statusCode > 400 || json == null) {
        var obj = json.decode(response.body);
        print('My _getdata   statuscode=$statusCode response obj = $obj');
        String Message =obj['message'];
        setState(() {
          _isLoading=true;
        });
        throw new Exception("Error while fetching data");

      }else if(statusCode==200) {
        String Message;
        String Status;
        String Type1;
        if (response.body.isNotEmpty) {
          var obj = json.decode(response.body);
                   print('My _getdata response obj = $obj');

          print('My Get _getdata Details response  = $obj');

          var obj2=json.decode(json.encode(obj["data"]));

          print("obj2 is $obj2");
          print("obj2 type is${obj2.runtimeType}");
          _superVisiorText.text=obj2[0]['supervisor_name'];
          _departmentText.text=obj2[0]['department_name'];
          _emailText.text=obj2[0]['email'];
          _mobileNoText.text=obj2[0]['mobile_number'];
          _whatNoText.text=obj2[0]['whatsapp_number'];
          _whatNoText2.text=obj2[0]['whatsapp_number'];
          _genderText.text=obj2[0]['gender'];
          _uploadPhotoText.text="Image.Jpeg";
          _dojText.text=obj2[0]['doj'];
          _collegeNameText.text=obj2[0]['college_name'];
          _higherQualText.text=obj2[0]['higher_qualification'];
          _passingText.text="${obj2[0]['passing_year']}";
          imageUrl=obj2[0]['profile_image'];
          
          base64Image = await networkImageToBase64(imageUrl);
          print("base64Image is${base64Image}");
          name.text="p$i";

          setState(() {
            _isLoading=true;
          });

        }
      }else{
        setState(() {
          _isLoading=true;
        });
        print('My _getdata response.body=${response.body}');

      }
      // return _decoder.convert(response.body);
      return response;
    });
  }

  void sucessAlert() {

    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
      return WillPopScope(
          child: Container(
            child: AlertDialog(
              title: Text("Sucess"),
              content: Text("User Added Successfully !"),
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              actions: [
                  MaterialButton(onPressed: (){
                    Navigator.pop(context);
                    setState(() {
                      _superVisiorText.clear();
                      _departmentText.clear();
                      _emailText.clear();
                      _mobileNoText.clear();
                      _whatNoText.clear();
                      _whatNoText2.clear();
                      _genderText.clear();
                      _uploadPhotoText.clear();
                      _dojText.clear();
                      _collegeNameText.clear();
                      _higherQualText.clear();
                      _passingText.clear();
                      base64Image=null;
                      myImage=null;
                      imageUrl=null;
                      name..clear();
                      i++;
                    });
                  },
                    splashColor: Colors.white,
                    child: new Text(
                      "Create New",
                      style: new TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),),
                /*MaterialButton(onPressed: (){
                  Navigator.pop(context);
                  print("i is ${i}");
                  print("i minus is ${i-1}");
                  _getdata("https://seedcrm.seedwill.co/public/api/flutter-screening/user/p${i-1}");
                },
                  splashColor: Colors.white,
                  child: new Text(
                    "Details",
                    style: new TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),),*/
              ],
            ),
          ),
          onWillPop: ()async{
            return true ;
          });
    });

  }



  void _getnewImage() async{

    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 400.0,
        // width: 300.0,
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(5),
                        child:Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Photo",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    Align(
                      // These values are based on trial & error method
                      //  alignment: Alignment(1.05, -1.05),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],)
            ),
            Align(
              alignment: Alignment.center,
              child:Container(
                height: 350,
                child: imageUrl==null?Image.file(myImage!,fit: BoxFit.fill,width: 200,height: 300,)
                    :Image.network(imageUrl!,fit: BoxFit.fill,width: 200,height: 300),
              ),),

          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }


  Future<String?> networkImageToBase64(String? imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl!));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }



}
