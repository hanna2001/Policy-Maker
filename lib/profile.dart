import 'package:avatar_glow/avatar_glow.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:policy_maker/services.dart';
import 'package:policy_maker/userServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mailer/smtp_server/mailgun.dart';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/smtp_server.dart';

const url = 'http://thinkdiff.net';
const email = 'mahmud@example.com';
const phone = '+880 123 456 78';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String name = '';
  String username = '';
  String url =
      'https://firebasestorage.googleapis.com/v0/b/policymaker-95e91.appspot.com/o/blank_profile.jpg?alt=media&token=734b18fe-91b5-4cf6-8ce7-e06b3d5c42f2';
  String email = '';
  String usernameEmail;
  String password;
  int randomNum;
  String emailTemp;
  String date;
  String user = '';
  bool bool1 = false;
  bool bool2 = false;
  bool bool3 = false;
  bool bool4 = false;
  String website = '';
  TextEditingController controller;
  File _image;
  Uint8List bytes;
  final picker = ImagePicker();

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
    // final StorageReference firebaseStorageRef =
    //     FirebaseStorage.instance.ref().child(user);
    // final StorageUploadTask task = firebaseStorageRef.putFile(_image);
    // var imageUrl = await (await task.onComplete).ref.getDownloadURL();
    // Firestore.instance.collection('User').document(user).updateData({
    //   "Logo url": imageUrl,
    // });
    // setState(() {
    //   url = imageUrl;
    // });
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    onPressed();
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
    // Firestore.instance
    //     .collection('User')
    //     .document(user)
    //     .get()
    //     .then((DocumentSnapshot ds) {
    //   setState(() {
    //     name = ds.data["Company Name"];
    //     url = ds.data["Logo url"].toString();
    //     username = ds.data["Username"];
    //     email = ds.data['Email'];
    //     date = ds.data["Expiry Date"].toDate();
    //     print(name);
    //     print(url);
    //     print(username);
    //     print(date);
    //   });
    // });
    // Firestore.instance
    //     .collection("Gateway")
    //     .document("Email")
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     usernameEmail = value.data['username'];
    //     password = value.data['password'];
    //   });
    // });
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

  Future<void> updateValue(String change, String field) {
    try {
      // Firestore.instance.collection('User').document(user).updateData({
      //   field: change,
      // });
      UserServices.updateUser(field, change, user).then((user) {
        if (user == "User updated Successfully") {
          Fluttertoast.showToast(
              msg: "Updated your $field to $change successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          switch (field) {
            case "CompanyName":
              setState(() {
                name = change;
                print(name);
              });
              break;
            case "Username":
              setState(() {
                username = change;
              });
              break;
            case "Website":
              setState(() {
                website = change;
              });
              break;
            case "Email":
              setState(() {
                email = change;
              });
          }
        } else {
          Fluttertoast.showToast(
              msg: "Update failed Error: $e",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    } catch (e) {
      print("Update failed.");
      Fluttertoast.showToast(
          msg: "Update failed Error: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _showDialog(String field, String fieldValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller.clear();
        return AlertDialog(
          title: new Text("Update " + field),
          content: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue, width: 2)),
            child: new TextField(
              controller: controller,
              autofocus: true,
              decoration:
                  new InputDecoration(labelText: field, hintText: fieldValue),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: Text("Update Value"),
              onPressed: () async {
                if (field != "Email") {
                  updateValue(controller.text.trim().toString(), field);
                  controller.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEmailDialog(String field, String fieldValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        controller.clear();
        return AlertDialog(
          title: new Text("Update " + field),
          content: new TextField(
            controller: controller,
            autofocus: true,
            decoration:
                new InputDecoration(labelText: field, hintText: fieldValue),
          ),
          actions: <Widget>[
            new FlatButton(
              child: bool4 == false ? Text("Send OTP") : Text("Update Value"),
              onPressed: () async {
                if (bool4 == false) {
                  Random random = new Random();
                  setState(() {
                    randomNum = random.nextInt(10000);
                    emailTemp = controller.text.trim().toString();
                    controller.clear();
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
                    print('-------------Message sent: ' + sendReport.toString());
                  } catch (e) {
                    print('----------Message not sent.');
                    print(e.toString());
                    print(usernameEmail);
                    print(password);
                  }
                  setState(() {
                    bool4 = true;
                  });

                  Navigator.of(context).pop();
                  _showEmailDialog("Email", email);
                } else {
                  print(randomNum.toString());
                  print(controller.text.trim().toString());
                  if (randomNum.toString() ==
                      controller.text.trim().toString()) {
                    updateValue(emailTemp, field);
                    controller.clear();
                    Navigator.of(context).pop();
                  } else {
                    print("Incorrect OTP");
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
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
                                          // decoration: new BoxDecoration(
                                          //   shape: BoxShape.circle,
                                          // ),
                                          // child: bytes == null
                                          //     ? Image.asset(
                                          //         "assets/blank_profile.jpg",
                                          //         // height: 120,
                                          //       )
                                          //     : Image.memory(
                                          //         bytes,
                                          //         height: 120,
                                          //       ),
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
                                            username,
                                            style: new TextStyle(
                                                fontSize: 26.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          width: 120,
                                          child: new Text(
                                            email,
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
                        "Comapany Name",
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
                          leading: IconButton(
                              icon: Icon(
                                Icons.business,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _showDialog("CompanyName", name);
                              }),
                          title: Text(
                            '$name',
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                              color: Colors.teal,
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.edit, size: 15.0),
                              onPressed: () {
                                _showDialog("CompanyName", name);
                              }),
                        ),
                      ),
                      Text(
                        "Email Address",
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
                          leading: IconButton(
                              icon: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _showEmailDialog("Email", email);
                              }),
                          title: Text(
                            email,
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                              color: Colors.teal,
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.edit, size: 15.0),
                              onPressed: () {
                                _showEmailDialog("Email", email);
                              }),
                        ),
                      ),
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
                          leading: IconButton(
                              icon: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _showDialog("Username", username);
                              }),
                          title: Text(
                            username,
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                              color: Colors.teal,
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.edit, size: 15.0),
                              onPressed: () {
                                _showDialog("Username", username);
                              }),
                        ),
                      ),
                      Text(
                        "Website",
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
                          leading: IconButton(
                              icon: Icon(
                                Icons.supervised_user_circle,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _showDialog("Website", website);
                              }),
                          title: Text(
                            website,
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                              color: Colors.teal,
                            ),
                          ),
                          trailing: IconButton(
                              icon: Icon(Icons.edit, size: 15.0),
                              onPressed: () {
                                _showDialog("Username", username);
                              }),
                        ),
                      ),
                      Text(
                        "Expiry Date",
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
                          leading: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            ),
                            tooltip: 'Renew My subscription',
                            onPressed: () {},
                          ),
                          title: Text(
                            '$date',
                            style: TextStyle(
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ]),
        ),
      ),
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
