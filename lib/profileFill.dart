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

import 'package:avatar_glow/avatar_glow.dart';

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
            Fluttertoast.showToast(
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
            Fluttertoast.showToast(
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
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueAccent,
      
      body: ListView(
        children: <Widget>[
         Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(color:Color(0xff1565c0), boxShadow: [
                  BoxShadow(
                      color: Colors.blueAccent,
                      blurRadius: 50,
                      offset: Offset(0, 0))
                ]),
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 1.0),
                            child:
                                new Stack(fit: StackFit.loose, children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                 
                                  Hero(
                                    tag: "hi",
                                    child: AvatarGlow(
                                      glowColor: Colors.white,
                                      endRadius: 100,
                                      child: Material(
                                        elevation: 50.0,
                                        shape: CircleBorder(),
                                        child: Container(
                                          width: 130,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: bytes == null
                                                      ? AssetImage(
                                                          "assets/app_icon.png")
                                                      : MemoryImage(
                                                          bytes,
                                                        ),
                                                  fit: BoxFit.cover)),

                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          width: 120,
                                          child: new Text(
                                            'Profile',
                                            style: new TextStyle(
                                                fontSize: 26.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          width: 120,
                                          child: new Text(
                                            'Details',
                                            style: new TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 130.0, right: 20.0),
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
                          ),
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: Divider(
                              color: Colors.teal.shade700,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Insurance Agent Name",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        child: ListTile(
                          leading: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              
                          title:TextField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.teal),
                        controller: usernameController,
                        obscureText: false,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter Insure Agent Name',
                          hintStyle: TextStyle(color: Colors.grey)
                        ),
                      ) ,
                          
                        ),
                      ),
                      Text(
                        "Company Name",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        child: ListTile(
                          leading:  Icon(
                                Icons.account_balance_outlined,
                                color: Colors.blue,
                              ),
                              
                          title: TextField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.teal),
                        controller: companyController,
                        obscureText: false,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter Company Name',
                          hintStyle: TextStyle(color: Colors.grey)
                        ),
                      ),
                       
                        ),
                      ),
                      Text(
                        "Insurance Agency Website",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        child: ListTile(
                          leading: Icon(
                                Icons.blur_circular,
                                color: Colors.blue,
                              ),
                          title: TextField(
                            style: TextStyle(color: Colors.teal),
                        cursorColor: Colors.black,
                        controller: websiteController,
                        obscureText: false,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter Insure Agency Website',
                          hintStyle: TextStyle(color: Colors.grey)
                        ),
                      ),
                          
                        ),
                      ),
                      Text(
                        "Email",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        child: ListTile(
                          leading: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                          title: TextField(
                            style: TextStyle(color: Colors.teal),
                        cursorColor: Colors.black,
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.grey)
                        ),
                      )
                         
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 6.0),
                        child: Align(
                          child: InkWell(
                  child: loading==false? Text(
                    emailEntered == false ? 'Send OTP':'',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                  :CircularProgressIndicator(),
                  onTap: () async {
                    loading=false;
                    if(emailController.text.length==0)
                    {
                      Fluttertoast.showToast(msg: 'Please enter email');
                    }
                    else if(!emailController.text.contains('@')){
                      Fluttertoast.showToast(msg: 'Please enter a valid email');
                    }
                    else{

                      if (emailEntered == false) {
                      Random random = new Random();
                      setState(() {
                        randomNum = random.nextInt(10000);
                        emailTemp = emailController.text.trim().toString();
                        print(emailTemp);
                        loading=true;
                        emailController.clear();
                      });
                      final message = Message()
                        ..from = Address("$usernameEmail", 'Kohli Studio')
                        ..recipients.add(emailTemp)
                        ..subject = 'Verification Code'
                        ..text =
                            'This is the plain text.\nThis is line 2 of the text part.'
                        ..html =
                            '''<img src="../assets/Frame 1 (1).png" height="200" alt="">
<div style="margin:auto; height: 50%; width: 70%; background-color: rgb(200, 250, 181); border-radius: 5px;">
    <center style="padding: 10%;">
        <h3 style="margin: 10px auto;">Verify your Account</h3>
    <p>Your One Time password is </p>
    <h1>$randomNum</h1>
    </center>
    
</div>''';
                      try {
                        final sendReport = await send(
                            message, mailgun("$usernameEmail", "$password"));
                        print('Message sent: ' + sendReport.toString());
                        setState(() {
                          loading=false;
                        });
                        _showDialog(randomNum);
                        
                      } catch (e) {
                        print('Message not sent.');
                        print(e.toString());
                        setState(() {
                          loading=false;
                        });
                        Fluttertoast.showToast(msg: 'Please try again');
                      }
                      setState(() {
                        emailEntered = true;
                        print(emailEntered);
                      });
                      
                    } else {
                      
                    }
                    }
                    
                  },
                ),
                          alignment: Alignment.bottomRight,
                          
                        ),
                      )
                      
                    ]),
              ),
            ),
          ]),
          FadeAnimation(
            1.5,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                   decoration: BoxDecoration(
                      boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 15,
                  offset: Offset(0, 6),
                )
              ]
                    ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 3,
                  child: RaisedButton(
                    elevation: 5,
                     padding: EdgeInsets.all(10),
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15.0)),
                     color: Colors.white,
                     child: Row(
                       children: [Icon(Icons.check,color: Colors.green,),
                         Text(
                           "    Save",
                         ),
                       ],
                     ),
                     textColor: Colors.black,
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
                               "Website"??'',
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
                       Fluttertoast.showToast(
                           msg: "Redirecting to your InsureSelector.",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.BOTTOM,
                           timeInSecForIosWeb: 5,
                           backgroundColor: Colors.blue,
                           textColor: Colors.black,
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
                   decoration: BoxDecoration(
                      boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 20,
                  offset: Offset(0, 6),
                )
              ]
                    ),
                  child: new RaisedButton(
                    elevation: 5,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(Icons.cancel_outlined,color: Colors.red,),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              "   Reset",
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.black,
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

  
  void _showDialog(int otp){
    String otp;
    showDialog(
      context: context,
       builder: (BuildContext context){
         return AlertDialog(
           title: new Text("Confirm OTP "),
          content: new TextField(
            onChanged: (value){
              otp=value;
            },
            autofocus: true,
            decoration:
                new InputDecoration(hintText: 'Enter OTP'),
          ),
          actions: [
            TextButton(
              onPressed: (){
                if (otp==randomNum.toString()) {
                          print("Correct OTP");
                          setState(() {
                            emailOtp = false;
                            print(emailOtp);
                            emailController.text=emailTemp;
                          });
                          print(emailOtp.toString() + " EmailOtp");
                          Navigator.of(context).pop();
                        } else {
                          print(emailController.text.trim().toString());
                          print(randomNum.toString());
                          Fluttertoast.showToast(
                              msg: "Incorrect OTP",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.blue,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
              }, 
              child: Text('Confirm OTP')
              )
          ],
         );
       }
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height - 70);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}



