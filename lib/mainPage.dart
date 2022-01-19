import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:policy_maker/aboutUs.dart';
import 'package:policy_maker/insuranceSelector.dart';
import 'package:policy_maker/profile.dart';
import 'package:policy_maker/services.dart';
import 'package:policy_maker/userServices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile.dart';

import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class MyMainPage extends StatefulWidget {
  MyMainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  String link = "";
  String rating = "";
  String subscribe = "https://secure.kohli.company/KohliApp/cart.php?a=add&pid=271";
  String user;
  Uint8List bytes;
  String url = "";
  String username;
  bool load = false;
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        load = true;
      });
    });
    mainWidget = MyInsuranceSelector();
    onPressed();
    shareApp("shareApp");
    shareApp("rating");
    super.initState();
  }

  Widget appBarIcon({@required IconData icon}) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.black,
        size: 28.0,
      ),
      onPressed: () {},
    );
  }

  Widget mainWidget;
  // Widget defaultWidget = SingleChildScrollView(
  //     child: Center(
  //   child: Column(
  //     children: <Widget>[
  //       SizedBox(height: 20),
  //       Text("All your insurance policy here!"),
  //     ],
  //   ),
  // ));

  shareApp(String parameter) async {
    Services.getGST(parameter).then((result) {
      setState(() {
        if (parameter == "shareApp") {
          link = result[0].insurance;
        } else {
          rating = result[0].insurance;
        }
      });
    });
  }

  String title = "Home";
  _launchURL() async {
    if (await canLaunch(rating)) {
      await launch(rating);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL1() async {
    if (await canLaunch(subscribe)) {
      await launch(subscribe);
    } else {
      throw 'Could not launch $url';
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
        url = result[0].logoUrl;
        username = result[0].userName;
        // String new_url = url.split('.')[0];
        // print(new_url);
        if (url != null) {
          bytes = base64.decode(url);
          print(bytes != null);
          // print(bytes);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return load == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: CircularProgressIndicator(),
              ),
            ],
          )
        : Scaffold(
            backgroundColor: Color(0xff1565c0),
            appBar: AppBar(
              backgroundColor: Color(0xff1565c0),
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                '$title',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'VarelaRound',
                ),
              ),
            ),
            drawer: Drawer(
              elevation: 10,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: 8,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 50,bottom: 50.0),
                          decoration: BoxDecoration(
                              color: Color(0xff1565c0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 50,
                                    offset: Offset(0, 0))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, top: 10, right: 10.0),
                                  child: GestureDetector(
                                    child: Hero(
                                      tag: 'hi',
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, top: 10, bottom: 10),
                                        child: CircularImage(
                                          bytes != null
                                              ? MemoryImage(
                                                  bytes,
                                                )
                                              : AssetImage(
                                                  "assets/app_icon.png"),
                                          width: 96,
                                          height: 96,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        mainWidget = MyProfilePage();
                                        title = "Profile";
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "Hi",
                                    style: new TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 50.0),
                                    child: Text(
                                      username,
                                      style: new TextStyle(
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Pacifico',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, top: 10),
                        child: Column(
                          children: <Widget>[
//                            Text(
//                              "Your Account",
//                              textAlign: TextAlign.right,
//                              style: TextStyle(
//                                color: Colors.blue,
//                                fontSize: 20,
//                              ),
//                            ),
                            SizedBox(
                              height: 2,
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.home,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Home",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  mainWidget = MyInsuranceSelector();
                                  title = "Home";
                                });
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),

                            ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              title: Text(
                                "Profile",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              onTap: () {
                                setState(() {
                                  mainWidget = MyProfilePage();
                                  title = "Profile";
                                });
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 2,
                            ),

                            // ListTile(
                            //   leading: Icon(Icons.help,color:Colors.white),
                            //   title: Text("Insurance Selector"),
                            //   onTap: () {
                            //     // setState(() {
                            //     //   mainWidget = MyInsurancePage();
                            //     //   title = "Insurance Page";
                            //     // });
                            //     Navigator.pop(context);
                            //   },
                            // ),

                            ListTile(
                              leading: Icon(
                                Icons.explore,
                                color: Colors.black,
                              ),
                              title: Text(
                                "About",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              onTap: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) => AboutUs()));
                                setState(() {
                                  mainWidget = AboutUs();
                                  title = "About Us";
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        indent: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Image.asset('assets/crown.png',),
                                title: Text(
                                  "Subscribe",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  // Share.share(
                                  //     '$link Your beloved one uses our app! Why dont you?');
                                  _launchURL1();
                                  Navigator.pop(context);
                                  // Navigator.push(
                                  //   context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => MyApp()));
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "Share App",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  // Share.share(
                                  //     '$link Your beloved one uses our app! Why dont you?');
                                  ShareFilesAndScreenshotWidgets.text(
                                      "Sharing app",
                                      "Your Insurance Buddy uses our App! Why don't you try? Download $link",
                                      'text/plain');
                                  // Navigator.push(
                                  //   context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => MyApp()));
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.star_border,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  "Rate Us",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  _launchURL();
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height:100.0),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 30.0),
                                      child: FittedBox(
                                        fit:BoxFit.fitWidth,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              "#MadeWithLove ",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Merienda',
                                                  fontSize: 14.0,
                                                  color: Colors.pinkAccent),
                                            ),
                                            Text(
                                              '❤',
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              " Kohli.Studio",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Oregano-Regular',
                                                  fontSize: 18.0,
                                                  color: Colors.pinkAccent),
                                            ),
                                          ],
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: mainWidget);
  }
}

class CircularImage extends StatelessWidget {
  final double _width, _height;
  final ImageProvider image;
  Uint8List bytes;

  CircularImage(this.image, {double width = 50, double height = 50})
      : _width = width,
        _height = height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: image, fit: BoxFit.cover),
      ),
    );
  }
}
