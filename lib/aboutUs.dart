import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:policy_maker/animations.dart';
import 'package:policy_maker/userServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  AboutUs({
    Key key,
  }) : super(key: key);
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  TextEditingController controller = new TextEditingController();
  String user;
  @override
  void initState() {
    super.initState();
    onPressed();
  }

  Future<void> onPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString("auth_contact");
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 20,
            ),
            FadeAnimation(
              1,
              Container(
                child: Image(
                  image: AssetImage('assets/about.png'),
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: Card(
                  elevation: 30.0,
                  shadowColor: Colors.black,
                  child: new Container(
                      margin: EdgeInsets.all(10),
                      padding: new EdgeInsets.all(10.0),
                      child: new Column(children: <Widget>[
                        Container(
                          child: Text("About InsureBuddy",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                        )
                      ])),
                )),
            Container(
                child: Card(
              elevation: 30.0,
              shadowColor: Colors.black,
              child: new Container(
                  margin: EdgeInsets.all(10),
                  padding: new EdgeInsets.all(10.0),
                  child: new Column(children: <Widget>[
                    Container(
                      child: Text(
                          "InsureBuddy App is intended for enlightment of those seeking insurance, to give them insights into what shall suit their needs the best.\nA Toolkit enabling you to churn out quotation of Health Insurance in the blink of an Eye, converting your Cold Calls into Business. It uses the data available on the Internet and collectively makes it available at one place.\nWith the help Of InsureBuddy, You can share these Details to Your Client via Whats App, Email, SMS, Viber, Telegram, Hike, etc with your Personalized Name, Company, Company Logo and Contact Details.\nOwner of the App is not liable for any descripency found in the data produced on the Website.\n",
                          style: TextStyle(fontSize: 15)),
                    ),
                    Container(
                      child: Text(
                          "Support\ninsurebuddy@kohli.tel\n\n\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0,left: 15.0,right: 15.0),
                      child: TextField(
                        controller: controller,
                        obscureText: false,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(width: 10),
                          ),
                          fillColor: Colors.deepOrange,
                          labelText: "Write to us",
                          prefixIcon: Icon(Icons.feedback),
                        ),
                      ),
                    ),
                  ])),
            )),
            SizedBox(
              height: 20,
            ),
            // Card(
            //     elevation: 30.0,
            //     shadowColor: Colors.black,
            //     child: Container(
            //         margin: EdgeInsets.all(20),
            //         child: new Column(children: <Widget>[
            //           // Container(
            //           //   child: Text("Feel free to write a Query/Suggestion:",
            //           //       style: TextStyle(
            //           //           fontSize: 17, fontWeight: FontWeight.bold)),
            //           // ),
            //           Container(
            //             margin: EdgeInsets.all(15),
            //             child: TextField(
            //               controller: controller,
            //               obscureText: false,
            //               keyboardType: TextInputType.multiline,
            //               maxLines: null,
            //               decoration: InputDecoration(
            //                 contentPadding: EdgeInsets.all(10),
            //                 border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(15),
            //                   borderSide: BorderSide(width: 10),
            //                 ),
            //                 fillColor: Colors.deepOrange,
            //                 labelText: "Write to us",
            //                 prefixIcon: Icon(Icons.feedback),
            //               ),
            //             ),
            //           ),
            //         ]))),
            Container(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Colors.blue,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: new Text("Submit Feedback",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                            color: Colors.white)),
                  ),
                  onPressed: () {
                    if (controller.text.trim().toString() != null &&
                        controller.text.trim().toString() != "") {
                      UserServices.createFeedback(
                              user, controller.text.trim().toString())
                          .then((result) {
                        print(result);
                      });
                      controller.clear();
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please provide some feedback",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }),
            ),
            SizedBox(height: 30.0,),
            Container(
              child: Center(
                child: Text(
                    "Copyright ©️2020 InsureBuddy — Kohli Media LLP. All Rights Reserved.",
                    style: TextStyle(
                        fontSize: 10, color: Colors.grey)),
              ),
            ),
            SizedBox(height: 30.0,),
          ],
        ),
      )),
    );
  }
}
