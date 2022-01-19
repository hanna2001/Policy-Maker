import 'dart:async';
import 'package:android_multiple_identifier/android_multiple_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:policy_maker/expirePage.dart';
import 'package:policy_maker/noInternetPage.dart';
import 'package:policy_maker/slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:policy_maker/mainPage.dart';
import 'package:policy_maker/userServices.dart';
import 'dart:io';
import 'Animatedbackground.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isVerified = false;
  String imei;
  @override
  void initState() {
    super.initState();
    internetConnectivity();
    _getSharedPrefs();
    Timer(
        Duration(seconds: 2),
        () => {
              if (isVerified == true)
                {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MyMainPage()))
                }
              else
                {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => ImagePage()))
                }
            });
  }

  internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => NoInternet()));
    }
  }

  _getSharedPrefs() async {
    
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auth_verified")) {
      setState(() {
        isVerified = true;
      });
      while (await AndroidMultipleIdentifier.checkPermission() != true) {
        await AndroidMultipleIdentifier.requestPermission();
        Fluttertoast.showToast(
            msg: "Allow permission to proceed with the app",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      Map idMap = await AndroidMultipleIdentifier.idMap;
      print(idMap);
      setState(() {
        imei = idMap["androidId"];
      });
      // Firestore.instance
      //     .collection('User')
      //     .document(prefs.getString("auth_contact"))
      //     .get()
      //     .then((DocumentSnapshot ds) async {
      //   if (ds.data["IMEI"] != imei) {
      //     setState(() {
      //       isVerified = false;
      //     });
      //   }
      // });
      UserServices.getData(prefs.getString("auth_contact")).then((user) {
        if (user[0].imei != imei) {
          setState(() {
            isVerified = false;
          });
        } else if (DateTime.parse(user[0].expiryDate)
            .isBefore(DateTime.now())) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => ExpirePage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
      return MediaQuery(
        child: child,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      );},
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(child: AnimatedBackground()),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/logo.png",
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitThreeBounce(color: Colors.white),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "#MadeWithLove",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Merienda',
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                          Text(
                            " ❤ ",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            )
                          ),
                          Text(
                            "Kohli.Studio",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Oregano-Regular',
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
