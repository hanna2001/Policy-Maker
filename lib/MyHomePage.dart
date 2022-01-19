import 'dart:async';

import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:flutter/material.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:policy_maker/animations.dart';
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
    numberController = TextEditingController();
    emailController = TextEditingController();
    // onPressed();
    getLink("link1");
    getLink("link2");
    getLink("link3");
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
                          style: TextStyle(color: Colors.blue),
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
                      :Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OTPTextField(
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 40,
                              style: TextStyle(
                                fontSize: 17
                              ),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onCompleted: (pin) {
                                print("Completed: " + pin);
                                otpTyped=pin;
                              },
                            ),
                      ),
                    ),
                    numOtp == false
                        ? new Container(
                            width: 0,
                            height: 0,
                          )
                        : resendOtp == true
                            ? new InkWell(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: new Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () async {
                                  setState(() {
                                    resendOtp = false;
                                    print("---Resend OTP"+resendOtp.toString());
                                  });
                                  Timer(Duration(seconds: 30), () {
                                    setState(() {
                                      resendOtp = true;
                                      print("---Resend OTP2"+resendOtp.toString());
                                    });
                                  });
                                  String link =
                                      "http://websms.kohliconnect.com/app/smsapi/index.php?key=55DFE218F61F0F&campaign=0&routeid=9&type=text&contacts=" +
                                          number +
                                          "&senderid=KOHLIC&msg=Dear+User+Your+OTP+is+" +
                                          randomNumber.toString();
                                  print(link);
                                  var f = await http.get(link);
                                  print(f.body.toString());
                                  try {
                                    await http.post(
                                        "http://websms.kohliconnect.com/app/miscapi/55DFE218F61F0F/getDLR/" +
                                            f.body.toString());
                                    FlutterToast.showToast(
                                        msg: "Resent The OTP",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                              )
                            : Container(
                                padding: EdgeInsets.all(10),
                                child: new Text(
                                  'Resend available in a few seconds',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                    FadeAnimation(
                      2,
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 0, 20, 25),
                        child: numOtp == false
                            ? new RaisedButton(
                                padding: EdgeInsets.all(10),
                                shape: StadiumBorder(),
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    
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
                                  Timer(Duration(seconds: 30), () {
                                    setState(() {
                                      resendOtp = true;
                                      print(resendOtp);
                                    });
                                  });
                                  Random random = new Random();
                                  int randomNum = random.nextInt(10000);
                                  print("OPT "+randomNum.toString());
                                  if (numberController.text
                                          .trim()
                                          .toString()
                                          .length ==
                                      10) {
                                    bool present = false;
                                    print("-----Present"+present.toString());
                                    // await UserServices.userExists(
                                    //         numberController.text
                                    //             .trim()
                                    //             .toString())
                                    //     .then((result) {
                                    //   setState(() {
                                    //     present = result;
                                        
                                    //   });
                                    //   print("---await-----"+present.toString());
                                    // });
                                    print("---await-----"+present.toString());
                                    if (present == false) {
                                      print("------Not present already");
                                      setState(() {
                                        numOtp = true;
                                        number = numberController.text
                                            .trim()
                                            .toString();
                                        numberController.clear();
                                        randomNumber = randomNum.toString();
                                      });
                                      while (otpSent == false) {
                                        try {
                                          String link = link1[smsCount] +
                                              number +
                                              link2[smsCount] +
                                              randomNumber.toString();
                                          print("link"+link);
                                          var f = await http.get(link);
                                          print("---f.body"+f.body.toString());
                                          await http.post(link3[smsCount] +
                                              f.body.toString());
                                          setState(() {
                                            otpSent = true;
                                          });
                                        } catch (e) {
                                          print("Did not send");
                                          setState(() {
                                            otpSent = false;
                                            smsCount =
                                                (smsCount + 1) % (link1.length);
                                          });
                                          print("---reoe"+e.toString());
                                        }
                                      }
                                    } else {
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
                                      await AndroidMultipleIdentifier
                                          .requestPermission();
                                      Map idMap =
                                          await AndroidMultipleIdentifier.idMap;

                                      String imei = idMap["androidId"];
                                      print("IMEi: " + imei);
                                      if (IMEI == imei) {
                                        print(
                                            "Same IMEI ... Confirming the same device");
                                        if (DateTime.parse(expiryDate)
                                            .isBefore(now)) {
                                          FlutterToast.showToast(
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
                                    }
                                  } else if (numberController.text
                                          .trim()
                                          .toString()
                                          .length !=
                                      10) {
                                    FlutterToast.showToast(
                                        msg:
                                            "Please Provide valid mobile number.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    FlutterToast.showToast(
                                        msg:
                                            "Please Provide Your mobile number",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
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
                                  if (otpTyped ==
                                      randomNumber) {
                                    // var collectionRef =
                                    //     Firestore.instance.collection('User');
                                    // var doc = await collectionRef
                                    //     .document(
                                    //         numberController.text.trim().toString())
                                    //     .get();
                                    bool exists;
                                    await UserServices.userExists(number)
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
                                      await AndroidMultipleIdentifier
                                          .requestPermission();
                                      Map idMap =
                                          await AndroidMultipleIdentifier.idMap;

                                      String imei = idMap["androidId"];

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

                                      UserServices.createUser(number,
                                              expiryDate.toString(), imei)
                                          .then((result) {
                                        print("----24"+result);
                                        FlutterToast.showToast(
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
                                          FlutterToast.showToast(
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
                                    } else {
                                      print('Old User!');
                                      await AndroidMultipleIdentifier
                                          .requestPermission();
                                      Map idMap =
                                          await AndroidMultipleIdentifier.idMap;

                                      String imei = idMap["androidId"];
                                      UserServices.updateUser(
                                              "IMEI", imei, number)
                                          .then((result) {
                                        FlutterToast.showToast(
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
                                  } else {
                                    print("Incorrect OTP");
                                    FlutterToast.showToast(
                                        msg: "OTP is incorrect.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    numberController.clear();
                                  }
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
