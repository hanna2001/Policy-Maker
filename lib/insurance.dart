// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:policy_maker/services.dart';

// import 'package:policy_maker/finalpage.dart';
// import 'Responses.dart';

// class MyInsurancePage extends StatefulWidget {
//   @override
//   _MyInsurancePage createState() => _MyInsurancePage();
// }

// class _MyInsurancePage extends State<MyInsurancePage>
//     with TickerProviderStateMixin {
//   int step = 1;
//   bool done = false;
//   List<Responses> _insurance = [];
//   List<String> options = [];
//   TabController _controller;
//   List<String> dropDownOptions = [];
//   bool dropDown1 = false;
//   bool dropDown2 = false;
//   String member = "";
//   int thirdController = 1;

//   TextEditingController controller;
//   TextEditingController agecontroller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = TabController(
//       length: 3,
//       vsync: this,
//       initialIndex: 0,
//     );
//     _getTable1();
//     controller = TextEditingController();
//     agecontroller = TextEditingController();
//   }

//   _getTable2(List<String> options) async {
//     Services.get2(options).then((insurance) {
//       setState(() {
//         _insurance = insurance;
//         step = 2;
//       }); // Reset the title...
//       print("Length ${_insurance.length}");
//     });
//   }

//   _getTable7(List<String> options) async {
//     Services.get7(options).then((insurance) {
//       setState(() {
//         options.add(insurance[0].insurance);
//       }); // Reset the title...
//       print("Length ${_insurance.length}");
//       _getTable8(options);
//     });
//   }

//   _getTable8(List<String> options) async {
//     Services.get8(options).then((insurance) {
//       setState(() {
//         options.add(insurance[0].insurance);
//         print(insurance[0].insurance);
//       }); // Reset the title...
//       print("Length ${_insurance.length}");
//       _getTable9(options);
//     });
//   }

//   _getTable9(List<String> options) async {
//     Services.get9(options).then((insurance) {
//       setState(() {
//         options.add(insurance);
//         print(insurance);
//       }); // Reset the title...
//       print("Length ${_insurance.length}");
//       print(options);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => MyFinalPage(
//                   text: options, client: controller.text.trim().toString())));
//     });
//   }

//   _getTable1() async {
//     Services.get1().then((insurance) {
//       setState(() {
//         _insurance = insurance;
//       });
//       print("Length ${_insurance.length}");
//     });
//   }

//   _getTable3(List<String> options) async {
//     Services.get3(options).then((insurance) {
//       setState(() {
//         _insurance = insurance;
//         step = 1;
//       });
//       for (var i = 0; i < _insurance.length; i++) {
//         if (!dropDownOptions
//             .contains(_insurance[i].insurance.substring(0, 2))) {
//           dropDownOptions.add((_insurance[i].insurance).substring(0, 2));
//         }
//       }
//       print("Length ${_insurance.length}");
//     });
//   }

//   _getTable4(List<String> options) async {
//     Services.get4(options).then((insurance) {
//       setState(() {
//         print(insurance);
//         _insurance = insurance;
//       }); // Reset the title...
//       Timer(new Duration(seconds: 2), () {
//         _controller.animateTo(2);
//       });
//     });
//   }

//   _getTable5(List<String> options) async {
//     Services.get5(options).then((insurance) {
//       setState(() {
//         _insurance = insurance;
//         thirdController++;
//       }); // Reset the title...
//       print("Length ${_insurance.length}");
//     });
//   }

//   _getTable6(List<String> options) async {
//     Services.get6(options).then((insurance) {
//       setState(() {
//         _insurance = insurance;
//         thirdController++;
//       }); // Reset the title...
//       print("Length ${_insurance.length}");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           child: Center(
//             child: Column(
//               children: [
//                 IgnorePointer(
//                   child: Container(
//                     height: 50,
//                     child: TabBar(
//                         labelPadding: EdgeInsets.all(10),
//                         controller: _controller,
//                         isScrollable: false,
//                         tabs: [
//                           Text(
//                             "Insurance",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "Members",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "Providers",
//                             style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ]),
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                       controller: _controller,
//                       physics: NeverScrollableScrollPhysics(),
//                       children: [
//                         _firstWidget(),
//                         _secondWidget(),
//                         _thirdWidget()
//                       ]),
//                 )
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   crossAxisAlignment: CrossAxisAlignment.center,
//                 //   children: [
//                 //     Container(
//                 //       padding: EdgeInsets.all(10),
//                 //       margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
//                 //       decoration: BoxDecoration(
//                 //         color: step == 1 ? Colors.blue : Colors.white,
//                 //         border: Border.all(color: Colors.blue, width: 2),
//                 //       ),
//                 //       child: Text(
//                 //         "Insurance",
//                 //         style: TextStyle(
//                 //             color: step == 1 ? Colors.white : Colors.blue,
//                 //             fontWeight:
//                 //                 step == 1 ? FontWeight.bold : FontWeight.normal,
//                 //             fontSize: 20),
//                 //       ),
//                 //     ),
//                 //     Container(
//                 //       padding: EdgeInsets.all(10),
//                 //       margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
//                 //       decoration: BoxDecoration(
//                 //         color: step == 2 ? Colors.blue : Colors.white,
//                 //         border: Border.all(color: Colors.blue, width: 2),
//                 //       ),
//                 //       child: Text(
//                 //         "Members",
//                 //         style: TextStyle(
//                 //             color: step == 2 ? Colors.white : Colors.blue,
//                 //             fontWeight:
//                 //                 step == 2 ? FontWeight.bold : FontWeight.normal,
//                 //             fontSize: 20),
//                 //       ),
//                 //     ),
//                 //     Container(
//                 //       padding: EdgeInsets.all(10),
//                 //       margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
//                 //       decoration: BoxDecoration(
//                 //           color: step == 3 ? Colors.blue : Colors.white,
//                 //           border: Border.all(color: Colors.blue, width: 2)),
//                 //       child: Text(
//                 //         "Providers",
//                 //         style: TextStyle(
//                 //             color: step == 3 ? Colors.white : Colors.blue,
//                 //             fontWeight:
//                 //                 step == 3 ? FontWeight.bold : FontWeight.normal,
//                 //             fontSize: 20),
//                 //       ),
//                 //     )
//                 //   ],
//                 // ),
//               ],
//             ),
//           )),
//     );
//   }

//   Widget _firstWidget() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
//       margin: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//               color: Colors.blue, width: 2, style: BorderStyle.solid)),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.blue, borderRadius: BorderRadius.circular(7.5)),
//             padding: EdgeInsets.all(20),
//             child: Text(
//               "Choose Your type of insurance!!",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 19,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           // step == 2
//           //     ? firstUI(options[0], Colors.lightBlue)
//           //     : Container(
//           //         width: 0,
//           //         height: 0,
//           //       ),
//           Expanded(
//               child: ListView.builder(
//                   itemCount: _insurance.length,
//                   itemBuilder: (BuildContext ctxt, int index) {
//                     return firstUI(
//                         _insurance[index].insurance.toString(), Colors.blue);
//                   }))
//           // RaisedButton(
//           //   onPressed: () {
//           //     _controller.animateTo(1);
//           //   },
//           // )
//         ],
//       ),
//     );
//   }

//   Widget firstUI(String content, Color color) {
//     return new Container(
//       padding: EdgeInsets.all(20),
//       height: MediaQuery.of(context).size.width / 4,
//       child: InkWell(
//         onTap: step == 1
//             ? () {
//                 setState(() {
//                   if (options.isNotEmpty) {
//                     options.removeLast();
//                   }
//                   options.add(content);
//                   _getTable2(options);
//                 });
//               }
//             : () {
//                 setState(() {
//                   if (options.length > 1) {
//                     options.removeLast();
//                   }
//                   options.add(content);
//                   _getTable3(options);
//                   _controller.animateTo(1);
//                 });
//               },
//         child: new Container(
//             decoration: BoxDecoration(
//               color: color,
//               border: Border.all(color: Colors.black, width: 2),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Center(
//               child: new Text(
//                 content,
//                 style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//             )),
//       ),
//     );
//   }

//   Widget _secondWidget() {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
//       margin: EdgeInsets.all(45),
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: Colors.blue, width: 2, style: BorderStyle.solid)),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.all(20),
//               padding: EdgeInsets.all(20),
//               color: Colors.blue,
//               child: Text(
//                 "Choose the number of members in your family",
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
//               child: TextField(
//                 controller: controller,
//                 obscureText: false,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(10),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide: BorderSide(width: 10),
//                   ),
//                   fillColor: Colors.deepOrange,
//                   labelText: "Name of the client",
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(10),
//               padding: EdgeInsets.all(10),
//               child: FormField<String>(
//                 builder: (FormFieldState<String> state) {
//                   return InputDecorator(
//                     decoration: InputDecoration(
//                         labelStyle: TextStyle(color: Colors.black),
//                         errorStyle:
//                             TextStyle(color: Colors.redAccent, fontSize: 16.0),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0))),
//                     child: dropDown1 == false
//                         ? DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               hint: Text("Select the number of adults"),
//                               isDense: true,
//                               onChanged: (String newValue) {
//                                 setState(() {
//                                   member = newValue + "adult + ";
//                                   dropDown1 = true;
//                                 });
//                                 dropDownOptions.removeRange(
//                                     0, dropDownOptions.length);
//                                 for (var i = 0; i < _insurance.length; i++) {
//                                   if (_insurance[i]
//                                               .insurance
//                                               .substring(0, 10) ==
//                                           member &&
//                                       (!dropDownOptions.contains(_insurance[i]
//                                           .insurance
//                                           .substring(10, 12)))) {
//                                     dropDownOptions.add(_insurance[i]
//                                         .insurance
//                                         .substring(10, 12));
//                                   }
//                                 }
//                               },
//                               items: dropDownOptions.map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                             ),
//                           )
//                         : Text("You have chosen $member"),
//                   );
//                 },
//               ),
//             ),
//             member == ""
//                 ? Container(
//                     width: 0,
//                     height: 0,
//                   )
//                 : (Container(
//                     margin: EdgeInsets.all(10),
//                     padding: EdgeInsets.all(10),
//                     child: FormField<String>(
//                       builder: (FormFieldState<String> state) {
//                         return InputDecorator(
//                           decoration: InputDecoration(
//                               labelStyle: TextStyle(color: Colors.black),
//                               errorStyle: TextStyle(
//                                   color: Colors.redAccent, fontSize: 16.0),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5.0))),
//                           child: dropDown2 == false
//                               ? DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     hint: Text("Select the number of kids"),
//                                     isDense: true,
//                                     onChanged: (String newValue) {
//                                       setState(() {
//                                         member = member + newValue + "Kid";
//                                         options.add(member);
//                                         dropDown2 = true;
//                                       });
//                                     },
//                                     items: dropDownOptions.map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 )
//                               : Text("You have chosen $member"),
//                         );
//                       },
//                     ),
//                   )),
//             dropDown2 == false
//                 ? Container(
//                     height: 0,
//                     width: 0,
//                   )
//                 : Container(
//                     margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
//                     child: TextField(
//                       controller: agecontroller,
//                       decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(width: 10),
//                         ),
//                         fillColor: Colors.deepOrange,
//                         labelText: "Age of the oldest member.",
//                         prefixIcon: Icon(Icons.info_outline),
//                       ),
//                     ),
//                   ),
//             Container(
//               margin: EdgeInsets.all(10),
//               padding: EdgeInsets.all(10),
//               child: RaisedButton(
//                 onPressed: () {
//                   if (agecontroller.text.trim().toString() == "") {
//                     FlutterToast.showToast(
//                         msg: "Age field must not be empty.",
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.BOTTOM,
//                         timeInSecForIosWeb: 5,
//                         backgroundColor: Colors.blue,
//                         textColor: Colors.white,
//                         fontSize: 16.0);
//                   } else {
//                     if (!done) {
//                       done = true;
//                       _getTable4(options);
//                       options.add(agecontroller.text);
//                       print(options);
//                     }
//                   }
//                 },
//                 child: Text(
//                   "Save the data.",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 color: Colors.blue,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget thirdUI(String content, Color color) {
//     return new Container(
//       padding: EdgeInsets.all(20),
//       height: MediaQuery.of(context).size.width / 4,
//       child: InkWell(
//         onTap: () {
//           options.add(content);
//           print(options);
//           if (thirdController == 1) {
//             _getTable5(options);
//           } else {
//             _getTable6(options);
//           }
//         },
//         child: new Container(
//             decoration: BoxDecoration(
//               color: color,
//               border: Border.all(color: Colors.black, width: 2),
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Center(
//               child: new Text(
//                 content,
//                 style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//             )),
//       ),
//     );
//   }

//   Widget _thirdWidget() {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
//       margin: EdgeInsets.all(45),
//       decoration: BoxDecoration(
//           border: Border.all(
//               color: Colors.blue, width: 2, style: BorderStyle.solid)),
//       child: Column(
//         children: [
//           Icon(
//             Icons.alarm,
//             size: 30,
//             color: Colors.blue,
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             padding: EdgeInsets.all(20),
//             color: Colors.blue,
//             child: Text(
//               "Choose Your favorite provider",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           ),
//           thirdController == 1
//               ? Expanded(
//                   child: ListView(
//                   children: _insurance
//                       .map((Responses element) =>
//                           thirdUI(element.insurance.toString(), Colors.blue))
//                       .toList(),
//                 ))
//               : Container(
//                   margin: EdgeInsets.all(10),
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.black)),
//                   child: Text(
//                     " Choose Your plan ",
//                     style: TextStyle(color: Colors.black, fontSize: 20),
//                   ),
//                 ),
//           thirdController == 2
//               ? Expanded(
//                   child: ListView.builder(
//                       itemCount: _insurance.length,
//                       itemBuilder: (BuildContext ctxt, int index) {
//                         return thirdUI(_insurance[index].insurance.toString(),
//                             Colors.blue);
//                       }))
//               : Container(
//                   width: 0,
//                   height: 0,
//                 ),
//           thirdController == 3
//               ? Container(
//                   margin: EdgeInsets.all(10),
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.black)),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       hint: Text("Select the amount to be insured"),
//                       isDense: true,
//                       onChanged: (String newValue) {
//                         setState(() {
//                           options.add(newValue);
//                           _getTable7(options);
//                         });
//                       },
//                       items: _insurance.map((Responses value) {
//                         return DropdownMenuItem<String>(
//                           value: value.insurance,
//                           child: Text(value.insurance),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 )
//               : Container(
//                   width: 0,
//                   height: 0,
//                 )
//         ],
//       ),
//     );
//   }
// }
