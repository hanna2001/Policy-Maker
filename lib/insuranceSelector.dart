import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:policy_maker/Responses.dart';
import 'package:policy_maker/finalpage.dart';
import 'package:policy_maker/profile.dart';
import 'package:policy_maker/services.dart';
import 'package:intl/intl.dart';
import 'package:policy_maker/userServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInsuranceSelector extends StatefulWidget {
  MyInsuranceSelector({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyInsuranceSelectorState createState() => MyInsuranceSelectorState();
}

class MyInsuranceSelectorState extends State<MyInsuranceSelector> {
  int i = 0;
  List<double> months = [];
  List<double> premium = [];
  String installments;
  bool multipleOptions = false;
  Map<double, bool> values = {};
  bool ageEntered = true;
  String email = '';
  bool result = false;
  String change = "no";
  String website = "";
  String name = "";
  String url = "";
  Uint8List bytes;
  String username = "";
  String user1 = '';
  double GST;
  TextStyle insuaranceStyle =TextStyle(
      fontSize: 18.0,
      color: Colors.white,
      fontWeight: FontWeight.w900
  );
  TextEditingController ageController;
  TextEditingController controller;
  _getTable1() async {
    Services.get1().then((insurance) {
      setState(() {
        _insurance = insurance;
      });
      print("Length ${_insurance.length}");
    });
  }

  _getTable7(List<String> options) async {
    Services.get7(options).then((insurance) {
      print("In table 7");
      setState(() {
        options.add(insurance[0].insurance);
        print(options);
        print(options[7] + " 7th ");
      }); // Reset the title...
      print("Length ${_insurance.length}");
      _getTable8(options);
    });
  }

  _getTable8(List<String> options) async {
    Services.get8(options).then((insurance) {
      setState(() {
        options.add(insurance[0].insurance);
        print(insurance[0].insurance);
      }); // Reset the title...
      print("Length ${_insurance.length}");
      _getTable9(options);
    });
  }

  _getTable9(List<String> options) async {
    Services.get9(options).then((insurance) {
      setState(() {
        options.add(insurance);
        print(insurance);
      }); // Reset the title...
      print("Length ${_insurance.length}");
      installments = options[9];
      print(installments);
      List<dynamic> arr =
          installments.replaceAll('"', '').replaceAll(':', ',').split(',');
      print(arr);
      int _currentIndex = 0;
      arr.forEach((a) {
        if (_currentIndex % 2 == 0) {
          months.add(double.parse(a.toString().substring(1)));
        } else {
          premium.add(
              double.parse(a.toString().substring(0, a.toString().length - 1)));
        }
        _currentIndex++;
      });
      print("Months in insure: " + months.toString());
      print("premium in insure: " + premium.toString());
      for (int i = 0; i < months.length; i++) {
        values.putIfAbsent(months[i], () => false);
      }
      setState(() {
        multipleOptions = true;
      });
    });
  }

  _getTable2(List<String> options) async {
    Services.get2(options).then((insurance) {
      setState(() {
        _insurance = insurance;
      }); // Reset the title...
      print("Length ${_insurance.length}");
    });
  }

  _getTable3(List<String> options) async {
    Services.get3(options).then((insurance) {
      setState(() {
        _insurance = insurance;
      });
      print("Length ${_insurance.length}");
    });
  }

  _getTable4(List<String> options) async {
    Services.get4(options).then((insurance) {
      setState(() {
        print(insurance);
        _insurance = insurance;
      });
    });
  }

  _getTable5(List<String> options) async {
    Services.get5(options).then((insurance) {
      setState(() {
        _insurance = insurance;
      }); // Reset the title...
      print("Length ${_insurance.length}");
    });
  }

  _getTable6(List<String> options) async {
    Services.get6(options).then((insurance) {
      setState(() {
        _insurance = insurance;
        result = true;
        print(result);
      }); // Reset the title...
      if (_insurance.length == 0) {
        Fluttertoast.showToast(
            msg: "No premium available for given age in selected plan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        ageController.clear();
        setState(() {
          ageEntered = true;
        });
        options.removeLast();
      }

      print("Length ${_insurance.length}");
    });
  }

  List<Responses> _insurance = [];
  List<String> options = [];
  List<String> texts = [
    "Insurance Type",
    "Sub Type",
    "Family",
    "Provider",
    "Plan Name"
  ];

  List<String> texts1 = [
    "Choose your insurance Type",
    "Choose your subtype",
    "Choose  number of family members",
    "Choose your provider",
    "Choose Your plan name"
  ];

  @override
  void initState() {
    super.initState();

    _getTable1();
    ageController = TextEditingController();
    controller = TextEditingController();
    _getGST("GST");
    _onPressed();
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
    });
    await UserServices.getData(user1).then((result) {
      setState(() {
        name = result[0].companyName;
        username = result[0].userName;
        email = result[0].email;
        if (result[0].logoUrl != null) {
          url = result[0].logoUrl;
        }
        if (url != null) {
          bytes = base64.decode(url);
          print("bytes : $bytes");
        }
        if (result[0].website != null) {
          website = result[0].website;
        }
      });
    });
  }

  var format = NumberFormat.currency(locale: 'HI',decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1565c0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 600.0,
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  child: Hero(
                                    tag: 'hi',
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: bytes.isEmpty
                                                  ? AssetImage(
                                                      "assets/app_icon.png"
                                              )
                                                  : MemoryImage(
                                                      bytes,
                                                    ),
                                              fit: BoxFit.cover)
                                      ),

                                      // ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyProfilePage()),
                                    );
                                  },
                                ),
                                RichText(
                                  textAlign: TextAlign.start,
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'Welcome ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 26.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' !',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ]),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      width: 7.0,
                                      height: 7.0,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFB42827),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Find the Suitable Health Plan for your Clients',
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .subtitle
                                      //     .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 11.0),
                                // child: InkWell(
                                //   onTap: () {
                                //     showDialog(
                                //         context: context,
                                //         builder: (BuildContext context) {
                                //           return AlertDialog(
                                //             title: Text(texts[i]),
                                //             content: getAllSelectedCountry(),
                                //           );
                                //         });
                                //   },
                                //   child: new Container(
                                //       padding: EdgeInsets.all(20),
                                //       decoration: BoxDecoration(
                                //         color: Colors.white,
                                //         border: Border.all(color: Colors.black, width: 2),
                                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                                //       ),
                                //       child: Center(
                                //         child: new Text(
                                //           texts[i],
                                //           style: TextStyle(
                                //               fontSize: 25,
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.black),
                                //         ),
                                //       )),
                                // ),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.only(
                                            right: 10, bottom: 5, left: 10,),
                                        child: InkWell(
                                            onTap: () {
                                              if (i == index) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(texts[i]),
                                                        content:
                                                            getAllSelectedCountry(),
                                                      );
                                                    });
                                              } else if (i < index) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "please fill the above details first",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "please tap again",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 5,
                                                    backgroundColor: Colors.blue,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                print(options);
                                                print("In else");
                                                print(index);
                                                print(i);
                                                if (i == 6) {
                                                  i = i + 4;
                                                  setState(() {
                                                    ageEntered = true;
                                                    ageController.clear();
                                                    multipleOptions = false;
                                                  });
                                                }
                                                for (int j = 0;
                                                    j < (i - index);
                                                    j++) {
                                                  print("In for loop");
                                                  options.removeLast();
                                                  print(options.toString() +
                                                      "For loop");
                                                }
                                                setState(() {
                                                  i = index;
                                                  change = "temp";
                                                });
                                                switch (index) {
                                                  case 0:
                                                    _getTable1();
                                                    break;
                                                  case 1:
                                                    _getTable2(options);
                                                    break;
                                                  case 2:
                                                    _getTable3(options);
                                                    break;
                                                  case 3:
                                                    _getTable4(options);
                                                    break;
                                                  default:
                                                }
                                              }
                                            },
                                            child: Card(
                                              elevation: 10.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              margin: EdgeInsets.zero,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 0.0),
                                                      title: Text(
                                                        texts[index],
                                                        style: TextStyle(
                                                          fontSize: 18.0,
                                                            color:
                                                                Colors.blue[500],
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),

                                                      subtitle: Row(
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.linear_scale,
                                                            color: Color.fromRGBO(
                                                                190,
                                                                86,
                                                                131,
                                                                1.0),
                                                            size: 25.0,
                                                          ),
                                                          FittedBox(
                                                            fit: BoxFit.fitHeight,
                                                            child: Text(
                                                                options.length >
                                                                        index
                                                                    ? options[index]
                                                                    : texts[index],
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.black,
                                                                  fontSize: 17.2
                                                                )
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                                      trailing: Icon(
                                                          Icons
                                                              .keyboard_arrow_right,
                                                          color: Colors.black,
                                                          size: 30.0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )));
                                    // ListTile(
                                    //   title: Text(_insurance[index].insurance),
                                    //   onTap: () {},
                                    // );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0,top: 15.0,bottom: 15.0,right: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        enabled: ageEntered,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: ageController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10),
                                          labelText: "Age of the Oldest Member.",
                                          prefixIcon: Icon(Icons.person),
                                        ),
                                          onSubmitted: (text){
                                            if (ageController.text.trim().toString() !=
                                                null) {
                                              setState(() {
                                                ageEntered = false;
                                              });
                                              options.add(
                                                  ageController.text.trim().toString());
                                              _getTable6(options);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Please enter valid age",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.blue,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
//                          SizedBox(width: 10.0),
//                          Container(
//                            padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
//                            margin: const EdgeInsets.only(right: 10.0),
//                            decoration: BoxDecoration(
//                                color: Colors.white, shape: BoxShape.circle),
//                            child: IconButton(
//                                icon: ageEntered?
//                                Icon(
//                                        Icons.add,
//                                        color: Colors.blue,
//                                      ):
//                                Icon(
//                                  Icons.done,
//                                  color: Colors.blue,
//                                ),
//                                onPressed: () {
////                                  if (ageController.text.trim().toString() !=
////                                      null) {
////                                    setState(() {
////                                      ageEntered = false;
////                                    });
////                                    options.add(
////                                        ageController.text.trim().toString());
////                                    _getTable6(options);
////                                  } else {
////                                    FlutterToast.showToast(
////                                        msg: "Please enter valid age",
////                                        toastLength: Toast.LENGTH_SHORT,
////                                        gravity: ToastGravity.BOTTOM,
////                                        timeInSecForIosWeb: 5,
////                                        backgroundColor: Colors.blue,
////                                        textColor: Colors.white,
////                                        fontSize: 16.0);
////                                  }
//                                }),
//                          )
                          ],
                        ),
                      ]),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.circular(32),),
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: controller,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: InputBorder.none,
                      labelText: "Client's Name",
                      prefixIcon: Icon(Icons.info_outline),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      if (i == 5 &&
                          ageController.text.trim().toString() != null &&
                          ageEntered == false &&
                          multipleOptions == false) {
                        print(options);
                        // result == false
                        // ? showDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     builder: (BuildContext context) {
                        //       return Dialog(
                        //         child: Container(
                        //           padding: EdgeInsets.all(20),
                        //           child: new Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.center,
                        //             children: [
                        //               new CircularProgressIndicator(),
                        //               new Text("Loading"),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   )
                        // :
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Choose the sum insured"),
                                content: getAllSelectedCountry(),
                              );
                            });
                      } else if (multipleOptions == true) {
                        setState(() {
                          multipleOptions = false;
                          print(options);
                          options.removeLast();
                          print(options);
                          options.removeLast();
                          print(options);
                          options.removeLast();
                          print(options);
                          values.clear();
                          i = 5;
                        });
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Choose the sum insured"),
                                content: getAllSelectedCountry(),
                              );
                            });
                        options.removeLast();
                      } else if (i != 5 && change == "yes") {
                        Fluttertoast.showToast(
                            msg: "change all fields as per one change",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (ageEntered) {
                        Fluttertoast.showToast(
                            msg: "please enter your age and confirm it",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      // else {
                      //   FlutterToast.showToast(
                      //       msg: "please enter your age",
                      //       toastLength: Toast.LENGTH_SHORT,
                      //       gravity: ToastGravity.BOTTOM,
                      //       timeInSecForIosWeb: 5,
                      //       backgroundColor: Colors.blue,
                      //       textColor: Colors.white,
                      //       fontSize: 16.0);
                      // }
                    },
                    child: Card(
                      margin: const EdgeInsets.only(right:10.0),
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: new ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0.0),
                          title: Text(
                            "Amount",
                            style: TextStyle(
                              fontSize: 18.0,
                                color: Colors.blue[500],
                                fontWeight: FontWeight.bold),
                          ),

                          //         subtitle: Row(
                          //           children: <Widget>[
                          //             Icon(
                          //               Icons.linear_scale,
                          //               color: Color.fromRGBO(190, 86, 131, 1.0),
                          //             ),
                          //             Text(
                          //                 options.length < 7
                          //                     ? "Choose the sum to be insured"
                          //                     : options[6],
                          //                 style: TextStyle(
                          //                     color: Color.fromRGBO(147, 181, 225, 1.0)))
                          //           ],
                          //         ),
                          //         // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          //         trailing: Icon(Icons.keyboard_arrow_right,
                          //             color: Colors.black, size: 30.0),
                          //       ),
                          //     ),
                          //   ),
                          // )),
                          subtitle: Row(
                            children: <Widget>[
                              Icon(
                                Icons.linear_scale,
                                color: Color.fromRGBO(190, 86, 131, 1.0),
                                size: 25.0,
                              ),
                              Flexible(
                                child: Text(
                                    options.length < 7
                                        ? "Choose the Sum to be Insured"
                                        : "₹${(format.format(int.parse(options[6]))).substring(3)} /-",
                                    style: TextStyle(
                                      fontSize: 17.3,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.black, size: 30.0),
                        ),
                      ),
                    ),
                  )),
              multipleOptions == false
                  ? Container(
                      width: 0,
                      height: 0,
                    )
                  : (ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: values.keys.map((double key) {
                        return new CheckboxListTile(
                          checkColor: Colors.white,
                          title:
                          key==12.0||key==24.0||key==36.0 ?
                          key==12.0 ?
                          Text((key/12).toStringAsFixed(0) +
                              " Year" +
                              " ( ₹" +
                              format.format(((100 - premium[months.indexOf(key)]) *
                                      key *
                                      GST *
                                      double.parse(options[7]) /
                                      100)
                                  .round()).substring(3)
                                  .toString() +
                               " /- ) ",
                          style:insuaranceStyle ,):
                          Text((key/12).toStringAsFixed(0) +
                              " Years" +
                              " ( ₹" +
                              format.format(((100 - premium[months.indexOf(key)]) *
                                  key *
                                  GST *
                                  double.parse(options[7]) /
                                  100)
                                  .round()).substring(3)
                                  .toString() +
                              " /- ) ",style: insuaranceStyle,):
                          key==1?
                          Text(key.toStringAsFixed(0) +
                              " Month" +
                              " ( ₹" +
                              format.format(((100 - premium[months.indexOf(key)]) *
                                  key *
                                  GST *
                                  double.parse(options[7]) /
                                  100)
                                  .round()).substring(3)
                                  .toString() +
                              " /- ) ",style: insuaranceStyle,):
                          Text(key.toStringAsFixed(0) +
                              " Months" +
                              " ( ₹" +
                        format.format(((100 - premium[months.indexOf(key)]) *
                                  key *
                                  GST *
                                  double.parse(options[7]) /
                                  100)
                                  .round()).substring(3)
                                  .toString() +
                              " /- ) ",style: insuaranceStyle,),
                          value: values[key],
                          onChanged: (bool value) {
                            setState(() {
                              values[key] = value;
                            });
                          },
                        );
                      }).toList(),
                    )),
              multipleOptions == false
                  ? Container(
                      width: 0,
                      height: 0,
                    )
                  : Container(
                width: 150.0,
                    height: 50.0,
                    child: RaisedButton(
//                        padding: EdgeInsets.only(left: 2.0, right: 2.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'Share',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 17.4,
                                  fontWeight: FontWeight.w700,
                                    color: Color(0xff0d47a1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                            Icon(
                              Icons.share,
                              color: Color(0xff0d47a1),
                            )
//                        Container(
//                          padding: const EdgeInsets.all(8),
//                          decoration: BoxDecoration(
//                            borderRadius:
//                                const BorderRadius.all(Radius.circular(20)),
//                          ),
//                          child: Icon(
//                            Icons.arrow_forward_ios,
//                            color: Colors.white,
//                            size: 16,
//                          ),
//                        )
                          ],
                        ),
                        onPressed: () {
                          print(values);
                          Timer(
                              Duration(seconds: 2),
                              () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyFinalPage(
                                                text: options,
                                                client: controller.text
                                                    .trim()
                                                    .toString(),
                                                values: values,
                                                months: months,
                                                premium: premium,
                                                color: Colors.deepPurple,
                                                name: name,
                                                username: username,
                                                bytes: bytes,
                                                email: email,
                                                website: website)))
                                  });
                        },
                      ),
                  ),
              SizedBox(height: 20.0,)
            ],
          ),
        ),
      ),
    );
  }

  Widget getAllSelectedCountry() {
    return Container(
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _insurance.length,
        itemBuilder: (BuildContext context, int index) {
          // return ListTile(
          //   title: Text(_insurance[index].insurance),
          //   onTap: () {
          //     if (change == "temp") {
          //       setState(() {
          //         change = "yes";
          //       });
          //     }
          //     options.add(_insurance[index].insurance);
          //     switch (i) {
          //       case 0:
          //         _getTable2(options);
          //         break;
          //       case 1:
          //         _getTable3(options);
          //         break;
          //       case 2:
          //         _getTable4(options);
          //         break;
          //       case 3:
          //         _getTable5(options);
          //         break;
          //       case 5:
          //         _getTable7(options);
          //         break;
          //       default:
          //     }
          //     i++;
          //     print(i);
          //     print(options);
          //     Navigator.pop(context);
          //   },
          // );
          return Container(
              padding: EdgeInsets.all(5),
              child: InkWell(
                onTap: () {
                  if (change == "temp") {
                    setState(() {
                      change = "yes";
                    });
                  }
                  options.add(_insurance[index].insurance);
                  switch (i) {
                    case 0:
                      _getTable2(options);
                      break;
                    case 1:
                      _getTable3(options);
                      break;
                    case 2:
                      _getTable4(options);
                      break;
                    case 3:
                      _getTable5(options);
                      break;
                    case 5:
                      _getTable7(options);
                      break;
                    default:
                  }
                  i++;
                  print(i);
                  print(options);
                  Navigator.pop(context);
                },
                child: Card(
                  elevation: 10.0,
                  margin: new EdgeInsets.symmetric(vertical: 1.0),
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFCF6F5FF)),
                    child: new ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                      title: Text(
                        _insurance[index].insurance,
                        style: TextStyle(
                            color: Colors.blue[500],
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.black, size: 30.0),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
