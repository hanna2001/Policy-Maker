import 'dart:async';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:device_information/device_information.dart';
import 'package:policy_maker/animations.dart';
import 'package:policy_maker/profile.dart';
import 'package:policy_maker/profileFill.dart';
import 'package:policy_maker/userServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:policy_maker/services.dart';
import 'package:policy_maker/mainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool boolean = false;
  bool numOtp = false;
  String otpTyped;
  String number;
  String randomNumber;
  var expiryDate;
  String phone;
  String email;
  bool preference = false;
  bool emailOtp = false;
  String username;
  String password;
  List<String> link1 = [];
  List<String> link2 = [];
  List<String> link3 = [];
  bool resendOtp = false;
  int smsCount = 0;
  bool otpSent = false;
  TextEditingController numberController;
  TextEditingController emailController;

  // Future<void> onPressed() async {
  //   Firestore.instance
  //       .collection("Gateway")
  //       .document("Email")
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       username = value.data['username'];
  //       password = value.data['password'];
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    numberController = TextEditingController();
    emailController = TextEditingController();
    // onPressed();
    // getLink("link1");
    // getLink("link2");
    // getLink("link3");

  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Future<String> getIMEI()async{
    String imei;
    try{
        imei = await DeviceInformation.deviceIMEINumber;
    }catch(e){
        imei='no!';
    }
    return imei;
  }
  Future<bool> signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential?.user != null){
        return true;
      }
      else return false;

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      print(e.message);
      if(resendOtp==false){
        print("Incorrect OTP");
        Fluttertoast.showToast(
          msg: "OTP is incorrect.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      }
      else{
        print("Timeout");
        Fluttertoast.showToast(
          msg: "OTP Timeout.\nPlease resend OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      }
      return false;
          // numberController.clear();
    }
  }

  void verifyNumber() async{
    
                                  await _auth.verifyPhoneNumber(
                                    phoneNumber: '+91'+numberController.text,
                                    verificationCompleted: (phoneAuthCredential) async {
                                      setState(() {
                                        showLoading = false;
                                      });
                                      // signInWithPhoneAuthCredential(phoneAuthCredential);
                                      //  Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileFill()));
                                    },
                                    verificationFailed: (verificationFailed) async {
                                      setState(() {
                                        showLoading = false;
                                      });
                                      print('----'+verificationFailed.message);
                                      Fluttertoast.showToast(
                                                    msg: 'Verification Error',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                    },
                                    codeSent: (verificationId, resendingToken) async {
                                    
                              // Sign the user in (or link) with the credential
                                     
                                      setState(() {
                                        showLoading = false;
                                        numOtp=true;
                                        this.verificationId = verificationId;
                                      });
                                    },
                                    codeAutoRetrievalTimeout: (verificationId) async {
                                      setState(() {
                                        resendOtp=true;

                                      });
                                    },
                                  );
  }

 
  getLink(String parameter) async {
    Services.getGST(parameter).then((result) {
      setState(() {
        if (parameter == "link1") {
          setState(() {
            link1 = result[0].insurance.split(',');
          });
        } else if (parameter == "link2") {
          setState(() {
            link2 = result[0].insurance.split(',');
          });
        } else {
          setState(() {
            link3 = result[0].insurance.split(',');
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: 240,
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      margin: const EdgeInsets.only(top: 100),
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                        constraints: const BoxConstraints(
                                            maxHeight: 340),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Image.asset('assets/phone.png')),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: Text('Register | Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800))),
                          
                          ],
                        ),
                      ),
                    ],
                  ),
                 
                  Column(children: <Widget>[
                    
                    FadeAnimation(
                      1.5,
                      numOtp == false
                      ?Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextField(
                          
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            focusColor: Colors.blue,
                            contentPadding: EdgeInsets.all(14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(width: 10),
                            ),
                            labelText:'Enter Mobile Number',
                            labelStyle: TextStyle(color: Colors.blue),
                            prefixIcon: Icon(Icons.phone),
                            
                          ),
                        ),
                      )
                      :showLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          ):Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: PinCodeTextField(
                          cursorColor: Colors.black,
                          animationCurve: Curves.fastOutSlowIn,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            inactiveFillColor: Colors.grey[50],
                            selectedFillColor: Colors.grey[50],
                            selectedColor: Colors.red,
                            borderWidth: 2,
                            errorBorderColor: Colors.purple
                          ),
                          keyboardType: TextInputType.number,
                          appContext: context,
                          length: 6,
                        
                          onChanged: (value){
                            print(value);
                          },
                          onCompleted: (value) {
                            setState(() {
                              otpTyped=value;
                            });
                            print("Completed: " + value);
                            print(otpTyped);
                          },
                        ),
                      ),
                    ),
                    numOtp == false
                        ? new Container(
                            width: 00,
                            height: 0,
                            color: Colors.blue,
                          )
                        : Column(
                          children: [
                            TextButton(
                              onPressed: (){
                                setState(() {
                                  numOtp=false;
                                });
                              },
                              child: RichText(
                                
                                text: TextSpan(
                                  text: 'Wrong number?',
                                  style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline),
                                  children: [
                                    TextSpan(
                                      text: ' '+numberController.text,
                                      style: TextStyle(color: Colors.black,decoration: TextDecoration.none)
                                    )
                                  ]
                                ),
                              ),
                            ),
                            resendOtp == true
                                ? new InkWell(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: new Text(
                                        'Resend OTP',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onTap: () async {
                                      print("---"+numberController.text);
                                      setState(() {
                                        resendOtp=false;
                                      });
                                      verifyNumber();
                                    },
                                  )
                                : Container(
                                    padding: EdgeInsets.all(10),
                                    child: new Text(
                                      'Resend available in a few seconds',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ],
                        ),
                    FadeAnimation(
                      2,
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 0, 20, 25),
                        child: numOtp == false
                            ? new RaisedButton(
                                shape: StadiumBorder(),
                                color: Colors.blue,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () async {
                                  
                                    bool present = false;
                                    await UserServices.userExists(
                                            numberController.text
                                                .trim()
                                                .toString())
                                        .then((result) {
                                      setState(() {
                                        present = result;
                                        
                                      });
                                    });
                                    if (present == false) {
                                      print("------Not present already");
                                      setState(() {
                                          showLoading = true;
                                          number=numberController.text;
                                      });
                                      if(number.length==10)
                                        verifyNumber();
                                      else{
                                        int len=number.length;
                                        Fluttertoast.showToast(
                                                    msg: (len>10)?'Mobile number long':'Mobile number too shot',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                      }
                                    }
                                    else {
                                      print("present already");

                                      String IMEI = "";
                                      var now = DateTime.now();
                                      var expiryDate;
                                      // Firestore.instance
                                      //     .collection('User')
                                      //     .document(
                                      //         numberController.text.trim().toString())
                                      //     .get()
                                      //     .then((DocumentSnapshot ds) {
                                      //   setState(() {
                                      //     IMEI = ds.data["IMEI"];
                                      //     expiryDate = ds.data["Expiry Date"];
                                      //   });
                                      // });

                                      await UserServices.getData(
                                              numberController.text
                                                  .trim()
                                                  .toString())
                                          .then((user) {
                                        IMEI = user[0].imei;
                                        expiryDate = user[0].expiryDate;
                                        print("IMEI from database: " + IMEI);
                                        print("Date from database: " +
                                            expiryDate);
                                      });
                                      setState(() {
                                        number = numberController.text
                                            .trim()
                                            .toString();
                                      });
                                      String imei='no!';//idMap["androidId"];
                                      
                                      imei=await getIMEI();
                                      if(imei=='no!')
                                      {
                                          
                                          await _requestPermission();
                                          imei=await getIMEI();
                                      }

                                      if(imei!='no!'){

                                        print("-----imei "+imei);
                                      if (IMEI == imei) {
                                        print(
                                            "Same IMEI ... Confirming the same device");
                                        if (DateTime.parse(expiryDate)
                                            .isBefore(now)) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Your plan/free trial has expired ",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          numberController.clear();
                                        } else {
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          prefs.setBool("auth_verified", true);
                                          prefs.setString(
                                              "auth_contact",
                                              numberController.text
                                                  .trim()
                                                  .toString());
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyMainPage()));
                                        }
                                      }
                                      else{
                                        Fluttertoast.showToast(
                                              msg:
                                                  "You are not using the same device",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        print(
                                            "Same IMEI ... Confirming the same device....not same device");
                                      }
                                      
                                      }
                                      else{
                                         Fluttertoast.showToast(
                                              msg:
                                                  "Please allow Phone permission and try again later",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                      }

                                      
                                    }
                                },
                              )
                            : new RaisedButton(
                                padding: EdgeInsets.all(10),
                                shape: StadiumBorder(),
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Confirm OTP',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () async {
                                  //  {
                                    if(resendOtp==true){
                                       print("Timeout");
                                      Fluttertoast.showToast(
                                        msg: "OTP Timeout.\nPlease resend OTP",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    }
                                    else{
                                      PhoneAuthCredential phoneAuthCredential =
                                        PhoneAuthProvider.credential(
                                            verificationId: verificationId, smsCode: otpTyped);
                                        print('confirmOtp');
                                      bool signin=await signInWithPhoneAuthCredential(phoneAuthCredential);

                                      if(signin==true){
                                        print('---------Verified');
                                        Fluttertoast.showToast(
                                              msg:
                                                  "OTP Verified successfully ",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);

                                          bool exists;
                                          await UserServices.userExists(numberController.text)
                                            .then((value) {
                                          exists = value;
                                        });
                                        print("Exist"+exists.toString());
                                        if (!exists) {
                                          print('New User!');
                                          final prefs =
                                              await SharedPreferences.getInstance();
                                          DateTime expiryDate =
                                              DateTime.now().add(Duration(days: 2));
                                        print(expiryDate);

                                      String imei='no!';//idMap["androidId"];
                                      
                                      imei=await getIMEI();
                                      if(imei=='no!')
                                      {
                                          
                                          await _requestPermission();
                                          imei=await getIMEI();
                                      }

                                      print("-----imei "+imei);
                                      
                                          if(imei!='no!')
                                          {
                                            print('----can create');
                                            UserServices.createUser(numberController.text,
                                              expiryDate.toString(), imei)
                                          .then((result) {
                                        print(result);
                                        Fluttertoast.showToast(
                                            msg: result,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        if (result ==
                                            "User created Successfully") {
                                          prefs.setBool("auth_verified", true);
                                          prefs.setString(
                                              "auth_contact", number);

                                          if (prefs
                                              .containsKey("auth_verified")) {
                                            setState(() {
                                              boolean = true;
                                            });
                                          }
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Redirecting to your profile.",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.blue,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileFill()));
                                                }
                                              });
                                          }
                                          else{
                                             Fluttertoast.showToast(
                                                    msg: 'Please allow Phone permission and try again later',
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                          }

                                      
                                            } else {
                                              print('Old User!');
                                              

                                              String imei='no!';//idMap["androidId"];
                                      
                                              imei=await getIMEI();
                                              if(imei=='no!')
                                              {   
                                                  

                                                  await _requestPermission();
                                                  imei=await getIMEI();
                                              }

                                              print("-----imei "+imei);
                                              
                                              if(imei!='no!'){

                                                UserServices.updateUser(
                                                      "IMEI", imei, numberController.text)
                                                  .then((result) {
                                                Fluttertoast.showToast(
                                                    msg: result,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                if (result ==
                                                    "User updated Successfully") {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyMainPage()));
                                                }
                                              });
                                              }
                                              else{
                                                Fluttertoast.showToast(
                                                    msg: 'Please Provide Phone Permision and Try again later',
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                              
                                            }


                                      }
                                      else print("----------not verified");
                                    }

                                        
 //////////////////------------------------------------------------------                                   
                                    //   bool exists;
                                    //   await UserServices.userExists(numberController.text)
                                    //     .then((value) {
                                    //   exists = value;
                                    // });
                                    // print("Exist"+exists.toString());
                                    // if (!exists) {
                                    //   print('New User!');
                                    //   final prefs =
                                    //       await SharedPreferences.getInstance();
                                    //   DateTime expiryDate =
                                    //       DateTime.now().add(Duration(days: 2));
                                    //   print(expiryDate);
                                    //   // await AndroidMultipleIdentifier
                                    //   //     .requestPermission();
                                    //   // Map idMap =
                                    //   //     await AndroidMultipleIdentifier.idMap;
                                      

                                      
//--
                                      // await Firestore.instance
                                      //     .collection("User")
                                      //     .document(number)
                                      //     .setData({
                                      //   "Username": "Anonymous",
                                      //   "Company Name": "Anonymous",
                                      //   "Email": "test@gmail.com",
                                      //   "Logo url":
                                      //       "https://firebasestorage.googleapis.com/v0/b/policymaker-95e91.appspot.com/o/blank_profile.jpg?alt=media&token=734b18fe-91b5-4cf6-8ce7-e06b3d5c42f2",
                                      //   "Expiry Date": expiryDate,
                                      //   "IMEI": imei
                                      // });
//--
                                      
                                  },
                              ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//747312031890731
//747312031890731

// OTPTextField(
//                               length: 6,
//                               width: MediaQuery.of(context).size.width-20,
//                               fieldWidth: 40,
//                               style: TextStyle(
//                                 fontSize: 17
//                               ),
//                               otpFieldStyle: OtpFieldStyle(
//                                 // backgroundColor: Colors.amber,
//                                 borderColor: Colors.blue,
//                                 focusBorderColor: Colors.black,
//                                 enabledBorderColor: Colors.pink,
                                
                                

//                                 ),
//                               textFieldAlignment: MainAxisAlignment.spaceAround,
//                               fieldStyle: FieldStyle.underline,
//                               onCompleted: (pin) {
//                                 print("Completed: " + pin);
//                                 otpTyped=pin;
//                               },
//                             )