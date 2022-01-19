// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/mailgun.dart';
// import 'package:policy_maker/animations.dart';
// import 'package:policy_maker/mainPage.dart';
// import 'package:policy_maker/services.dart';
// import 'package:policy_maker/userServices.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProfileFill extends StatefulWidget {
//   ProfileFill({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   ProfileFillState createState() => ProfileFillState();
// }

// class ProfileFillState extends State<ProfileFill> {
//   String name = '';
//   String username = '';
//   String url = '';
//   String email = '';
//   String usernameEmail;
//   String password;
//   int randomNum;
//   String emailTemp;
//   String date;
//   String user = '';
//   String website = '';
//   File _image;
//   Uint8List bytes;
//   bool emailOtp = true;
//   bool emailEntered = false;
//   final picker = ImagePicker();
//   TextEditingController companyController;
//   TextEditingController usernameController;
//   TextEditingController emailController;
//   TextEditingController websiteController;
//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     setState(() {
//       _image = File(pickedFile.path);
//     });
//     if (_image != null) {
//       File croppedImage = await ImageCropper.cropImage(
//           sourcePath: _image.path,
//           maxWidth: 1080,
//           maxHeight: 1080,
//           aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
//       if (croppedImage != null) {
//         setState(() {
//           _image = croppedImage;
//         });
//         UserServices.uploadImage(_image, user).then((result) async {
//           if (result == "success") {
//             FlutterToast.showToast(
//                 msg: "Updated your profile picture successfully",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 5,
//                 backgroundColor: Colors.blue,
//                 textColor: Colors.white,
//                 fontSize: 16.0);
//             await UserServices.getData(user).then((result) {
//               setState(() {
//                 url = result[0].logoUrl;
//                 bytes = Base64Decoder().convert(url);
//                 print(url);
//               });
//             });
//           } else {
//             FlutterToast.showToast(
//                 msg: result,
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 5,
//                 backgroundColor: Colors.blue,
//                 textColor: Colors.white,
//                 fontSize: 16.0);
//           }
//         });
//       }
//     }
//   }

//   Future<void> onPressed() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String user1 = prefs.getString("auth_contact");
//     setState(() {
//       user = user1;
//     });
//     await UserServices.getData(user).then((result) {
//       setState(() {
//         name = result[0].companyName;
//         username = result[0].userName;
//         email = result[0].email;
//         date = result[0].expiryDate;
//         url = result[0].logoUrl;
//         website = result[0].website;
//         // String new_url = url.split('.')[0];
//         // print(new_url);
//         if (url != null) {
//           bytes = base64.decode(url);
//         }
//         print(date);
//       });
//     });
//     await Services.getDetails("username").then((insurance) {
//       setState(() {
//         usernameEmail = insurance.substring(12, insurance.length - 3);
//       }); // R
//       print(usernameEmail);
//     });
//     await Services.getDetails("password").then((insurance) {
//       setState(() {
//         password = insurance.substring(12, insurance.length - 3);
//       }); // R
//       print(password);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     onPressed();
//     usernameController = new TextEditingController(text: username);
//     companyController = new TextEditingController(text: name);
//     emailController = new TextEditingController(text: email);
//     websiteController = new TextEditingController(text: website);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 18,
//           backgroundColor: Colors.blue[900],
//           title: Text(
//             "PROFILE",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             height: 800,
//             child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Row(
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         width: 180,
//                         height: 180,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: bytes == null
//                                     ? AssetImage("assets/blank_profile.jpg")
//                                     : MemoryImage(
//                                         bytes,
//                                       ),
//                                 fit: BoxFit.cover)),

//                         // ),
//                       ),
//                       InkWell(
//                         splashColor: Colors.red, // inkwell color
//                         child: SizedBox(
//                             width: 26,
//                             height: 26,
//                             child: Icon(
//                               Icons.edit,
//                               color: Colors.black,
//                             )),
//                         onTap: () {
//                           getImage();
//                         },
//                       ),
//                     ],
//                   ),
//                   FadeAnimation(
//                     1.5,
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       child: TextField(
//                         controller: usernameController,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           focusColor: Colors.blue,
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(width: 10),
//                           ),
//                           fillColor: Colors.deepOrange,
//                           labelText: "Insurance Agent Name",
//                           labelStyle: TextStyle(color: Colors.blue),
//                           prefixIcon: Icon(Icons.phone),
//                         ),
//                       ),
//                     ),
//                   ),
//                   FadeAnimation(
//                     1.5,
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       child: TextField(
//                         controller: companyController,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           focusColor: Colors.blue,
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(width: 10),
//                           ),
//                           fillColor: Colors.deepOrange,
//                           labelText: "Company Name",
//                           labelStyle: TextStyle(color: Colors.blue),
//                           prefixIcon: Icon(Icons.phone),
//                         ),
//                       ),
//                     ),
//                   ),
//                   FadeAnimation(
//                     1.5,
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       child: TextField(
//                         controller: websiteController,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           focusColor: Colors.blue,
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(width: 10),
//                           ),
//                           fillColor: Colors.deepOrange,
//                           labelText: "Insurance agency Website",
//                           labelStyle: TextStyle(color: Colors.blue),
//                           prefixIcon: Icon(Icons.phone),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           height: 100,
//                           width: MediaQuery.of(context).size.width / 1.2,
//                           padding: EdgeInsets.all(20),
//                           child: TextField(
//                             enabled: emailOtp,
//                             controller: emailController,
//                             obscureText: false,
//                             decoration: InputDecoration(
//                               focusColor: Colors.blue,
//                               contentPadding: EdgeInsets.all(10),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                                 borderSide: BorderSide(width: 10),
//                               ),
//                               fillColor: Colors.deepOrange,
//                               labelText: "Email",
//                               labelStyle: TextStyle(color: Colors.blue),
//                               prefixIcon: Icon(Icons.phone),
//                             ),
//                           ),
//                         ),
//                         new InkWell(
//                           child: new Text(
//                             emailEntered == false ? 'Send OTP' : 'Confirm',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           onTap: () async {
//                             if (emailEntered == false) {
//                               Random random = new Random();
//                               setState(() {
//                                 randomNum = random.nextInt(10000);
//                                 emailTemp =
//                                     emailController.text.trim().toString();
//                                 emailController.clear();
//                               });
//                               final message = Message()
//                                 ..from =
//                                     Address("$usernameEmail", 'Kohli Studio')
//                                 ..recipients.add(emailTemp)
//                                 ..subject = 'Verification Code'
//                                 ..text =
//                                     'This is the plain text.\nThis is line 2 of the text part.'
//                                 ..html =
//                                     "<h1>Verification Code for your Insurance Selector</h1>\n<p>Dear User, Your One Time password is $randomNum</p>";
//                               try {
//                                 final sendReport = await send(message,
//                                     mailgun("$usernameEmail", "$password"));
//                                 print('Message sent: ' + sendReport.toString());
//                               } catch (e) {
//                                 print('Message not sent.');
//                                 print(e.toString());
//                               }
//                               setState(() {
//                                 emailEntered = true;
//                               });
//                             } else {
//                               if (emailController.text.trim().toString() ==
//                                   randomNum.toString()) {
//                                 setState(() {
//                                   emailOtp = false;
//                                 });
//                               } else {
//                                 print(emailController.text.trim().toString());
//                                 print(randomNum.toString());
//                                 FlutterToast.showToast(
//                                     msg: "Incorrect OTP",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.BOTTOM,
//                                     timeInSecForIosWeb: 5,
//                                     backgroundColor: Colors.blue,
//                                     textColor: Colors.white,
//                                     fontSize: 16.0);
//                               }
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   FadeAnimation(
//                     1.5,
//                     Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width / 3,
//                       child: new RaisedButton(
//                           padding: EdgeInsets.all(15),
//                           shape: StadiumBorder(),
//                           color: Colors.blue,
//                           child: Text(
//                             "Save the profile",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           onPressed: () async {
//                             print(companyController.text.trim().toString());
//                             await UserServices.updateUser(
//                                     "CompanyName",
//                                     companyController.text.trim().toString() ==
//                                             ""
//                                         ? name
//                                         : companyController.text
//                                             .trim()
//                                             .toString(),
//                                     user)
//                                 .then((user) {
//                               if (user == "User updated Successfully") {
//                                 print("updated company name");
//                               }
//                             });
//                             await UserServices.updateUser(
//                                     "Username",
//                                     usernameController.text.trim().toString() ==
//                                             ""
//                                         ? username
//                                         : usernameController.text
//                                             .trim()
//                                             .toString(),
//                                     user)
//                                 .then((user) {
//                               if (user == "User updated Successfully") {
//                                 print("updated agent name");
//                               }
//                             });
//                             await UserServices.updateUser(
//                                     "Website",
//                                     websiteController.text.trim().toString() ==
//                                             ""
//                                         ? website
//                                         : websiteController.text
//                                             .trim()
//                                             .toString(),
//                                     user)
//                                 .then((user) {
//                               if (user == "User updated Successfully") {
//                                 print("updated website name");
//                               }
//                             });
//                             if (emailOtp == false) {
//                               await UserServices.updateUser(
//                                       "Email", emailTemp, user)
//                                   .then((user) {
//                                 if (user == "User updated Successfully") {
//                                   print("updated email");
//                                 }
//                               });
//                             }
//                             FlutterToast.showToast(
//                                 msg: "Redirecting to your InsureSelector.",
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.BOTTOM,
//                                 timeInSecForIosWeb: 5,
//                                 backgroundColor: Colors.blue,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => MyMainPage()));
//                           }),
//                     ),
//                   )
//                 ]),
//           ),
//         ));
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'package:policy_maker/animations.dart';
import 'package:policy_maker/mainPage.dart';
import 'package:policy_maker/services.dart';
import 'package:policy_maker/userServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileFill extends StatefulWidget {
  ProfileFill({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ProfileFillState createState() => ProfileFillState();
}

class ProfileFillState extends State<ProfileFill> {
  String name = '';
  String username = '';
  String url = '';
  String email = '';
  String usernameEmail;
  String password;
  int randomNum;
  String emailTemp;
  String date;
  String user = '';
  String website = '';
  File _image;
  Uint8List bytes;
  bool emailOtp = true;
  bool emailEntered = false;
  final picker = ImagePicker();
  TextEditingController companyController;
  TextEditingController usernameController;
  TextEditingController emailController;
  TextEditingController websiteController;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    if (_image != null) {
      File croppedImage = await ImageCropper.cropImage(
          sourcePath: _image.path,
          maxWidth: 1080,
          maxHeight: 1080,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));
      if (croppedImage != null) {
        setState(() {
          _image = croppedImage;
        });
        UserServices.uploadImage(_image, user).then((result) async {
          if (result == "success") {
            FlutterToast.showToast(
                msg: "Updated your profile picture successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            await UserServices.getData(user).then((result) {
              setState(() {
                url = result[0].logoUrl;
                bytes = Base64Decoder().convert(url);
                print(url);
              });
            });
          } else {
            FlutterToast.showToast(
                msg: result,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        });
      }
    }
  }

  Future<void> onPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user1 = prefs.getString("auth_contact");
    setState(() {
      user = user1;
    });
    await UserServices.getData(user).then((result) {
      setState(() {
        name = result[0].companyName;
        username = result[0].userName;
        email = result[0].email;
        date = result[0].expiryDate;
        url = result[0].logoUrl;
        website = result[0].website;
        // String new_url = url.split('.')[0];
        // print(new_url);
        if (url != null) {
          bytes = base64.decode(url);
        }
        print(date);
      });
    });
    await Services.getDetails("username").then((insurance) {
      setState(() {
        usernameEmail = insurance.substring(12, insurance.length - 3);
      }); // R
      print(usernameEmail);
    });
    await Services.getDetails("password").then((insurance) {
      setState(() {
        password = insurance.substring(12, insurance.length - 3);
      }); // R
      print(password);
    });
  }

  @override
  void initState() {
    super.initState();
    onPressed();
    usernameController = new TextEditingController(text: username);
    companyController = new TextEditingController(text: name);
    emailController = new TextEditingController(text: email);
    websiteController = new TextEditingController(text: website);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'VarelaRound',
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(children: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      image: DecorationImage(
                          image: bytes == null
                              ? AssetImage("assets/blank_profile.jpg")
                              : MemoryImage(
                                  bytes,
                                ),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 110.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 20.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 20,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        getImage();
                      },
                    ),
                  )
                ],
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: FadeAnimation(
                  1.5,
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: usernameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hoverColor: Colors.white,
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 10),
                        ),
                        fillColor: Colors.white,
                        labelText: "Insurance Agent Name",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: FadeAnimation(
                  1.5,
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: companyController,
                      obscureText: false,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 10),
                        ),
                        fillColor: Colors.deepOrange,
                        labelText: "Company Name",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.account_balance,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: FadeAnimation(
                  1.5,
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: websiteController,
                      obscureText: false,
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 10),
                        ),
                        fillColor: Colors.deepOrange,
                        labelText: "Insurance agency Website",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.web, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Row(children: <Widget>[
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 1.2,
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    enabled: emailOtp,
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 10),
                      ),
                      fillColor: Colors.deepOrange,
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.mail, color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  child: new Text(
                    emailEntered == false ? 'Send OTP' : 'Confirm',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    if (emailEntered == false) {
                      Random random = new Random();
                      setState(() {
                        randomNum = random.nextInt(10000);
                        emailTemp = emailController.text.trim().toString();
                        print(emailTemp);
                        emailController.clear();
                      });
                      final message = Message()
                        ..from = Address("$usernameEmail", 'Kohli Studio')
                        ..recipients.add(emailTemp)
                        ..subject = 'Verification Code'
                        ..text =
                            'This is the plain text.\nThis is line 2 of the text part.'
                        ..html =
                            "<h1>Verification Code for your Insurance Selector</h1>\n<p>Dear User, Your One Time password is $randomNum</p>";
                      try {
                        final sendReport = await send(
                            message, mailgun("$usernameEmail", "$password"));
                        print('Message sent: ' + sendReport.toString());
                      } catch (e) {
                        print('Message not sent.');
                        print(e.toString());
                      }
                      setState(() {
                        emailEntered = true;
                        print(emailEntered);
                      });
                    } else {
                      if (emailController.text.trim().toString() ==
                          randomNum.toString()) {
                        print("Correct OTP");
                        setState(() {
                          emailOtp = false;
                          print(emailOtp);
                        });
                        print(emailOtp.toString() + " EmailOtp");
                      } else {
                        print(emailController.text.trim().toString());
                        print(randomNum.toString());
                        FlutterToast.showToast(
                            msg: "Incorrect OTP",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                ),
              ]),
            ],
          ),
          FadeAnimation(
            1.5,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  child: new RaisedButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.green,
                      child: Text(
                        "Save",
                      ),
                      textColor: Colors.white,
                      onPressed: () async {
                        print(companyController.text.trim().toString());
                        await UserServices.updateUser(
                                "CompanyName",
                                companyController.text.trim().toString() == ""
                                    ? name
                                    : companyController.text.trim().toString(),
                                user)
                            .then((user) {
                          if (user == "User updated Successfully") {
                            print("updated company name");
                          }
                        });
                        await UserServices.updateUser(
                                "Username",
                                usernameController.text.trim().toString() == ""
                                    ? username
                                    : usernameController.text.trim().toString(),
                                user)
                            .then((user) {
                          if (user == "User updated Successfully") {
                            print("updated agent name");
                          }
                        });
                        await UserServices.updateUser(
                                "Website",
                                websiteController.text.trim().toString() == ""
                                    ? website
                                    : websiteController.text.trim().toString(),
                                user)
                            .then((user) {
                          if (user == "User updated Successfully") {
                            print("updated website name");
                          }
                        });
                        if (emailOtp == false) {
                          await UserServices.updateUser(
                                  "Email", emailTemp, user)
                              .then((user) {
                            if (user == "User updated Successfully") {
                              print("updated email");
                            }
                          });
                        }
                        FlutterToast.showToast(
                            msg: "Redirecting to your InsureSelector.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyMainPage()));
                      }),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  child: new RaisedButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.red,
                      child: Text(
                        "Reset",
                      ),
                      textColor: Colors.white,
                      onPressed: () async {
                        emailController.clear();
                        companyController.clear();
                        usernameController.clear();
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
