// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:policy_maker/main.dart';
// import 'package:policy_maker/services.dart';
// import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:permission_handler/permission_handler.dart';

// class MyFinalPage extends StatefulWidget {
//   List<String> text;
//   String client;
//   Map<double, bool> values;
//   List<double> months;
//   List<double> premium;
//   Color color;
//   String name = "";
//   String username = "";
//   Uint8List bytes;
//   String email;

//   MyFinalPage({
//     Key key,
//     @required this.text,
//     @required this.client,
//     @required this.values,
//     @required this.months,
//     @required this.premium,
//     @required this.color,
//     @required this.name,
//     @required this.username,
//     @required this.bytes,
//     @required this.email,
//   }) : super(key: key);
//   @override
//   _MyFinalPage createState() => _MyFinalPage();
// }

// class _MyFinalPage extends State<MyFinalPage> {
//   String installments;
//   String usable;
//   String url = "";
//   String user1;
//   double GST;
//   List<Color> colors = [
//     Colors.purple,
//     Colors.orange,
//     Colors.yellow,
//     Colors.blue,
//     Colors.red
//   ];
//   bool load = false;
//   Color color = Colors.deepPurple;
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         Duration(seconds: 1),
//         () => setState(() {
//               load = true;
//             }));
//     _onPressed();
//     _requestPermission();
//     _getGST("GST");
//   }

//   _requestPermission() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();

//     final info = statuses[Permission.storage].toString();
//     print(info);
//   }

//   _getGST(String parameter) async {
//     Services.getGST(parameter).then((insurance) {
//       setState(() {
//         GST = double.parse(insurance[0].insurance);
//       }); // R
//     });
//   }

//   void _onPressed() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       user1 = prefs.getString("auth_contact");
//     });
//   }

//   Future<bool> _willPopCallback() async {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
//     return false;
//   }

//   void showColorBox() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             title: new Text("Choose Your Color"),
//             content: Container(
//               height: 300.0, // Change as per your requirement
//               width: 300.0, // Change as per your requirement
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: colors.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                       padding: EdgeInsets.all(5),
//                       child: InkWell(
//                         onTap: () {
//                           // FlutterToast.showToast(
//                           //     msg: "You change the color",
//                           //     toastLength: Toast.LENGTH_SHORT,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 5,
//                           //     backgroundColor: Colors.blue,
//                           //     textColor: Colors.white);
//                           setState(() {
//                             color = colors[index];
//                           });
//                           // FlutterToast.showToast(
//                           //     msg: "You chose a color",
//                           //     toastLength: Toast.LENGTH_SHORT,
//                           //     gravity: ToastGravity.BOTTOM,
//                           //     timeInSecForIosWeb: 5,
//                           //     backgroundColor: Colors.blue,
//                           //     textColor: Colors.white);

//                           // Timer(
//                           //     Duration(seconds: 2),
//                           //     () => {
//                           //           Navigator.push(
//                           //               context,
//                           //               MaterialPageRoute(
//                           //                   builder: (context) => MyFinalPage(
//                           //                         text: widget.text,
//                           //                         client: widget.client,
//                           //                         values: widget.values,
//                           //                         months: widget.months,
//                           //                         premium: widget.premium,
//                           //                         color: color,
//                           //                       )))
//                           //         });
//                         },
//                         child: Card(
//                           elevation: 10.0,
//                           margin: new EdgeInsets.symmetric(vertical: 1.0),
//                           child: Container(
//                             decoration: BoxDecoration(color: Color(0xFCF6F5FF)),
//                             child: new ListTile(
//                               contentPadding: EdgeInsets.symmetric(
//                                   horizontal: 8.0, vertical: 0.0),
//                               title: Row(
//                                 children: <Widget>[
//                                   Icon(
//                                     Icons.linear_scale,
//                                     color: colors[index],
//                                   ),
//                                   Text("Choose Color",
//                                       style: TextStyle(
//                                           color: Color.fromRGBO(
//                                               147, 181, 225, 1.0)))
//                                 ],
//                               ),
//                               // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//                               trailing: Icon(Icons.keyboard_arrow_right,
//                                   color: colors[index], size: 30.0),
//                             ),
//                           ),
//                         ),
//                       ));
//                   // ListTile(
//                   //   title: Text(_insurance[index].insurance),
//                   //   onTap: () {},
//                   // );
//                 },
//               ),
//             ));
//       },
//     );
//   }

//   Future<void> saveGallery() async {
//     try {
//       RenderRepaintBoundary boundary =
//           previewContainer.currentContext.findRenderObject();
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0);

//       ByteData byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);
//       final result =
//           await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
//       print("Results is" + result.toString());
//     } catch (e) {
//       print("Error is:" + e.toString());
//     }
//   }

//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           title: new Text("Choose Your policy"),
//           backgroundColor: Colors.blue[900],
//           actions: <Widget>[
//             FlatButton(
//               textColor: Colors.white,
//               onPressed: () {
//                 showColorBox();
//               },
//               child: Text("Colors"),
//               shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//             child: new WillPopScope(
//           onWillPop: _willPopCallback, // Empty Function.
//           child: load == false
//               ? Container(
//                   width: 0,
//                   height: 0,
//                 )
//               : postUI(),
//         )));
//   }

//   GlobalKey previewContainer = new GlobalKey();
//   int originalSize = 800;
//   Widget postUI() {
//     return Container(
//       color: color,
//       margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
//       width: MediaQuery.of(context).size.width,
//       child: new RepaintBoundary(
//         key: previewContainer,
//         child: Container(
//           color: color,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               widget.bytes == null
//                   ? Container(
//                       width: 0,
//                       height: 0,
//                     )
//                   : Container(
//                       margin: EdgeInsets.all(20),
//                       width: 180,
//                       height: 180,
//                       // decoration: new BoxDecoration(
//                       //   shape: BoxShape.circle,
//                       // ),
//                       // child: bytes == null
//                       //     ? Image.asset(
//                       //         "assets/blank_profile.jpg",
//                       //         // height: 120,
//                       //       )
//                       //     : Image.memory(
//                       //         bytes,
//                       //         height: 120,
//                       //       ),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                               image: MemoryImage(
//                                 widget.bytes,
//                               ),
//                               fit: BoxFit.cover)),

//                       // ),
//                     ),
//               widget.name == "Anonymous"
//                   ? Container(
//                       width: 0,
//                       height: 0,
//                     )
//                   : Container(
//                       height: 40,
//                       margin: EdgeInsets.all(5),
//                       padding: EdgeInsets.all(5),
//                       child: Text(
//                         widget.name,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ),
//                     ),
//               widget.client == ""
//                   ? Container(
//                       width: 0,
//                       height: 0,
//                     )
//                   : Container(
//                       height: 40,
//                       margin: EdgeInsets.all(5),
//                       padding: EdgeInsets.all(5),
//                       child: Text(
//                         widget.client,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ),
//                     ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 40,
//                     margin: EdgeInsets.all(5),
//                     padding: EdgeInsets.all(5),
//                     child: Text(
//                       widget.text[0] + " Insurance",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     ),
//                   ),
//                   Container(
//                     height: 40,
//                     child: IconButton(
//                         iconSize: 40,
//                         icon: Icon(Icons.share),
//                         onPressed: () {
//                           saveGallery();
//                           FocusScope.of(context).requestFocus(FocusNode());
//                           ShareFilesAndScreenshotWidgets().shareScreenshot(
//                               previewContainer,
//                               originalSize,
//                               widget.client,
//                               "Insurance.jpg",
//                               "image/jpg",
//                               text: widget.client);
//                         }),
//                   ),
//                 ],
//               ),

//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.fromLTRB(0, 30, 0, 5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Subtype: " + widget.text[1],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Plan Name: " + widget.text[4],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Plan members: " + widget.text[2],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Plan provider: " + widget.text[3],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Age of the client: " + widget.text[5],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   // height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Plan features : " + widget.text[8],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Sum Insured: " + widget.text[6],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.white)),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width - 150,
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Center(
//                     child: Text(
//                       "Monthly Premium:" + widget.text[7],
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )),
//               Container(
//                   margin: EdgeInsets.all(5),
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                       children: widget.months
//                           .map(
//                             (double a) => widget.values[a] == true
//                                 ? firstUI(
//                                     a,
//                                     widget.premium[widget.months.indexOf(a)],
//                                     Colors.blue)
//                                 : Container(
//                                     width: 0,
//                                     height: 0,
//                                   ),
//                           )
//                           .toList())),
//               // child: Expanded(
//               //     child: ListView.builder(
//               //         shrinkWrap: true,
//               //         itemCount: months.length,
//               //         itemBuilder: (BuildContext context, int index) {
//               //           return firstUI(
//               //               months[index], premium[index], Colors.blue);
//               //         }))),
//               Container(
//                   margin: EdgeInsets.only(top: 10),
//                   padding: EdgeInsets.only(right: 15)),
//               Text(
//                 "Feel Free To Reach Out To:",
//                 style: TextStyle(color: Colors.white),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.all(5),
//                     padding: EdgeInsets.all(5),
//                     child: Text(
//                       widget.username == "Anonymous"
//                           ? "Contact : "
//                           : widget.name,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(5),
//                     padding: EdgeInsets.all(5),
//                     child: Text(
//                       user1,
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(right: 0),
//                     padding: EdgeInsets.only(right: 0),
//                     child: Text(
//                       widget.email == "test@gmail.com"
//                           ? ""
//                           : (" / " + widget.email),
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                     "The above premium information is subject to verification by an insurance company.",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white)),
//               )
//               // ListView.builder(
//               //     itemCount: months.length,
//               //     itemBuilder: (BuildContext ctxt, int index) {
//               //       return firstUI(
//               //           months[index], premium[index], Colors.blue);
//               //     })),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget firstUI(double month, double premium, Color color) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color,
//         border: Border.all(color: Colors.black, width: 2),
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Center(
//           child: new Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             "$month Months : ",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             " ₹ ${(double.parse(widget.text[7]) * month * (100.0 - premium) * GST / 100).round()}",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ],
//       )),
//     );
//   }

//   // takeScreenShot() async {
//   //   RenderRepaintBoundary boundary =
//   //       previewContainer.currentContext.findRenderObject();
//   //   double pixelRatio = originalSize / MediaQuery.of(context).size.width;
//   //   ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
//   //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   //   Uint8List pngBytes = byteData.buffer.asUint8List();
//   //   setState(() {
//   //     _image2 = Image.memory(pngBytes.buffer.asUint8List());
//   //   });
//   //   try {
//   //     await Share.file('esys image', 'esys.png', pngBytes, 'image/png',
//   //         text: "Insurance Page");
//   //   } catch (e) {
//   //     print('error: $e');
//   //   }
//   // }
// }
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:policy_maker/insuranceSelector.dart';
import 'package:policy_maker/main.dart';
import 'package:policy_maker/mainPage.dart';
import 'package:policy_maker/services.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFinalPage extends StatefulWidget {
  List<String> text;
  String client;
  Map<double, bool> values;
  List<double> months;
  List<double> premium;
  Color color;
  String name = "";
  String username = "";
  Uint8List bytes;
  String email;
  String website;

  MyFinalPage({
    Key key,
    @required this.text,
    @required this.client,
    @required this.values,
    @required this.months,
    @required this.premium,
    @required this.color,
    @required this.name,
    @required this.username,
    @required this.bytes,
    @required this.email,
    @required this.website,
  }) : super(key: key);
  @override
  _MyFinalPage createState() => _MyFinalPage();
}

class _MyFinalPage extends State<MyFinalPage> {
  String installments;
  String usable;
  String url = "";
  String user1;
  String Website;
  double GST;
  List<Color> colors = [
    Color(0xFF00B2AD),
    Color(0xFF2F374A),
    Color(0xFFEA4D88),
    Color(0xFFEA614B),
    Color(0xFF307EC0),
    Color(0xFFBE9FE1)
  ];

  TextStyle heading1Style=TextStyle(
      fontSize: 20.0,
      color: Colors.black,
      fontWeight: FontWeight.w500);

  bool load = false;
  var format = NumberFormat.currency(locale: 'HI',decimalDigits: 0);
  Color color = Colors.deepPurple;
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => setState(() {
              load = true;
            }));
    _onPressed();
    _getGST("GST");
    _requestPermission();
    print(widget.bytes.toString() + "Bytes");
  }

  Future<void> saveGallery() async {
    try {
      RenderRepaintBoundary boundary =
          previewContainer.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
      print("Results is" + result.toString());
    } catch (e) {
      print("Error is:" + e.toString());
    }
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  _getGST(String parameter) async {
    Services.getGST(parameter).then((insurance) {
      setState(() {
        GST = double.parse(insurance[0].insurance);
      }); // R
    });
  }

  void _onPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user1 = prefs.getString("auth_contact");
      Website = widget.website;
    });
  }

  Future<bool> _willPopCallback() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyMainPage()));
    return false;
  }

  void showColorBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text("Choose Your Color"),
            content: Container(
              height: 300.0, // Change as per your requirement
              width: 300.0, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: colors.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          // FlutterToast.showToast(
                          //     msg: "You change the color",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 5,
                          //     backgroundColor: Colors.blue,
                          //     textColor: Colors.white);
                          setState(() {
                            color = colors[index];
                          });
                          // FlutterToast.showToast(
                          //     msg: "You chose a color",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 5,
                          //     backgroundColor: Colors.blue,
                          //     textColor: Colors.white);

                          // Timer(
                          //     Duration(seconds: 2),
                          //     () => {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => MyFinalPage(
                          //                         text: widget.text,
                          //                         client: widget.client,
                          //                         values: widget.values,
                          //                         months: widget.months,
                          //                         premium: widget.premium,
                          //                         color: color,
                          //                       )))
                          //         });
                        },
                        child: Card(
                          elevation: 10.0,
                          margin: new EdgeInsets.symmetric(vertical: 1.0),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xFCF6F5FF)),
                            child: new ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 0.0),
                              title: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.linear_scale,
                                    color: colors[index],
                                  ),
                                  Text("Choose Color",
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              147, 181, 225, 1.0)))
                                ],
                              ),
                              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                              trailing: Icon(Icons.keyboard_arrow_right,
                                  color: colors[index], size: 30.0),
                            ),
                          ),
                        ),
                      ));
                  // ListTile(
                  //   title: Text(_insurance[index].insurance),
                  //   onTap: () {},
                  // );
                },
              ),
            ));
      },
    );
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pop(context,true);
      },
      child: new Scaffold(
          appBar: new AppBar(
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
              "Share policy",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'VarelaRound',
              ),
            ),
            backgroundColor: color,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showColorBox();
                },
                icon: Icon(Icons.color_lens),
                color: Colors.white,
              ),
              IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    saveGallery();
                    FocusScope.of(context).requestFocus(FocusNode());
                    ShareFilesAndScreenshotWidgets().shareScreenshot(
                        previewContainer,
                        originalSize,
                        widget.client,
                        "Insurance.jpg",
                        "image/jpg",
                        text: Website != ""
                            ? "Check out our website: $Website"
                            : "");
                  }),
            ],
          ),
          body: SingleChildScrollView(
              child: new WillPopScope(
            onWillPop: _willPopCallback, // Empty Function.
            child: load == false
                ? Container(
                    width: 0,
                    height: 0,
                  )
                : postUI(),
          ))),
    );
  }

  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  Widget postUI() {
    return Container(
      color: color,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
      child: new RepaintBoundary(
        key: previewContainer,
        child: Container(
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AvatarGlow(
                glowColor: Colors.white,
                endRadius: 100,
                child: CircleAvatar(
//                  margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
//                  width: MediaQuery.of(context).size.width / 2.5,
//                  height: MediaQuery.of(context).size.height / 2.5,
//                   decoration: new BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
                  radius: 61,
                   backgroundColor: Colors.black,
                   child: widget.bytes.isEmpty
                    ?new Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.contain,
                            image: new AssetImage("assets/app_icon.png"),
                        )
                    )):
                   CircleAvatar(
                     radius: 60,
                     backgroundColor: color,
                     child: ClipRRect(
                       borderRadius:BorderRadius.circular(80),
                       child: Image.memory(widget.bytes),
                     ),
                   )
//                       ? Image.asset(
//                           "assets/blank_profile.jpg",
//                           // height: 120,
//                         )
//                       : Image.memory(
//                           widget.bytes,
//                           height: 120,
//                         ),
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                        image: widget.bytes.isNotEmpty
//                            ? MemoryImage(
//                                widget.bytes,
//                              )
//                            : AssetImage('assets/logo.png'),
//                        fit: BoxFit.cover)
//                ),

                  // ),
                ),
              ),
              widget.name == "Anonymous"
                  ? Container(
                      width: 40,
                      height: 40,
                    )
                  : Container(
                      height: 40,
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.only(left: 10, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    widget.client == ""
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : Container(
                            height: 40,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.only(bottom: 5, top: 10),
                            child: Text(
                              widget.client + "'s Insurance Plan",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.only(bottom: 5, top: 2),
                      child: Text(
                        widget.text[0] + " Insurance",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Text(
                      "Policy Details",
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Plan Type: ",
                              style: heading1Style,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              widget.text[1],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Insurance Members: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              widget.text[2],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Insurance Provider: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              widget.text[3],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Client Age: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              widget.text[5]+" Years",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Insurance Plan: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              widget.text[4],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
//                    Container(
//                      height: 40,
//                      width: MediaQuery.of(context).size.width - 60,
//                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                      padding: EdgeInsets.all(10),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.all(
//                          Radius.circular(10),
//                        ),
//                        color: Colors.grey[50],
//                      ),
//                      child: Row(
//                        children: <Widget>[
//                          Text(
//                            "Plan features : ",
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontSize: 18,
//                                fontWeight: FontWeight.w500),
//                            textAlign: TextAlign.left,
//                          ),
//                          Text(
//                            widget.text[8],
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontSize: 18,
//                                fontWeight: FontWeight.w300),
//                            textAlign: TextAlign.left,
//                          ),
//                        ],
//                      ),
//                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Sum Insured:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              " ₹"+format.format(int.parse(widget.text[6])).substring(3)+" /-",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 60,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "Monthly Cost: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          FittedBox(
                            fit:BoxFit.fitHeight,
                            child: Text(
                              "₹"+format.format(int.parse(widget.text[7])).substring(3) + " /-",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.only(right: 10, top: 10, bottom: 10),
                        child: Column(
                            children: widget.months
                                .map(
                                  (double a) => widget.values[a] == true
                                      ? firstUI(
                                          a,
                                          widget.premium[
                                              widget.months.indexOf(a)],
                                        )
                                      : Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                )
                                .toList())),
                    Text(
                      "Feel Free To Reach Out To:",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Container(
                      height: 35,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        widget.username == "Anonymous"
                            ? "Contact : "
                            : widget.username,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      height: 30,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        user1 +
                            (widget.email == "test@gmail.com"
                                ? ""
                                : (" / " + widget.email)),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Website != ""
                        ? Container(
                            height: 30,
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Check out our website: $Website",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                          "The above premium information is subject \n to verification by an insurance company.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 10)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstUI(double month, double premium) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10, right: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Center(
          child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FittedBox(
            fit:BoxFit.fitHeight,
            child: Text(
              month==12.0||month==24.0||month==36.0 ?
                  month==12.0 ?
                  "${(month/12).round()} Year : "
                      : "${(month/12).round()} Years : "
                  : month==1.0
                  ? "${month.round()} Month : "
                  : "${month.round()} Months : ",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          FittedBox(
            fit:BoxFit.fitHeight,
            child: Text(
              " ₹${format.format((double.parse(widget.text[7]) * month * (100.0 - premium) * GST / 100.0).round()).substring(3)} /-",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ],
      )),
    );
  }

  // takeScreenShot() async {
  //   RenderRepaintBoundary boundary =
  //       previewContainer.currentContext.findRenderObject();
  //   double pixelRatio = originalSize / MediaQuery.of(context).size.width;
  //   ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   setState(() {
  //     _image2 = Image.memory(pngBytes.buffer.asUint8List());
  //   });
  //   try {
  //     await Share.file('esys image', 'esys.png', pngBytes, 'image/png',
  //         text: "Insurance Page");
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }
}
