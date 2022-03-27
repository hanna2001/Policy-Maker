import 'dart:convert';
import 'dart:developer';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:policy_maker/services.dart';
import 'package:policy_maker/subsciptonPlans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userServices.dart';
import 'package:http/http.dart' as http;

class Subscribe extends StatefulWidget {


  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  var paymentResponse;
  List _plan=[];
  String user = '';
  String username,email,url;
  String pID,pKey,pToken,pUrl;
  bool loading=true;
  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user1 = prefs.getString("auth_contact");
    setState(() {
      user = user1;
    });
    await UserServices.getData(user).then((result) {
      setState(() {
        username = result[0].userName;
        email = result[0].email;
        
      });
    });
    
  }

  getPaymentDetails() async{
    await Services.getDetails("cashfreeID").then((insurance) {
      setState(() {
        pID = insurance.substring(12, insurance.length - 3);
      }); // R
      print("-------pid"+pID);
    });
    await Services.getDetails("cashfreeKey").then((insurance) {
      setState(() {
        pKey = insurance.substring(12, insurance.length - 3);
      }); // R
      print(pKey);
    });
    await Services.getGST("cashfreeTest").then((result) {
      setState(() {
        pUrl = result[0].insurance;
      }); // R
      print(pUrl);
    });
    setState(() {
      loading=false;
    });
  }

  getToken(amount,orderno)async{
    var url=Uri.parse(pUrl);
    var header = Map<String, String>();
    header['x-client-id'] = pID;
    header['x-client-secret'] = pKey;
    var body=Map<String,String>();
    body["orderId"]=orderno;
    body["orderAmount"]=amount;
    body["orderCurrency"]="INR";
    final response = await http.post(url, body: jsonEncode(body),headers: header);
    print(response.body);
    var res=jsonDecode(response.body);
    print(res["status"]);
    print(res["cftoken"]);
    setState(() {
      pToken=res["cftoken"];
    });
    
  
  }

  getPlans() async{
    // SubPlans plan1=SubPlans(name: 'Short Plan',duration: '3 months',features: ['free fds','cols','ferfwf'],amount: 50);
    // SubPlans plan2=SubPlans(name: 'Long Plan',duration: '6 months',features: ['free fds','cols','ferfwf','free fds'],amount: 70);
    // SubPlans plan3=SubPlans(name: 'Short Plan',duration: '3 months',features: ['free fds','cols','ferfwf'],amount: 50);
    // SubPlans plan4=SubPlans(name: 'Long Plan',duration: '6 months',features: ['free fds','cols','ferfwf','free fds'],amount: 70);
    // _plan.add(plan1);
    // _plan.add(plan2);
    // _plan.add(plan3);
    // _plan.add(plan4);
    Services.getSubPlans().then((value) {
      setState(() {
        _plan=value;
        
      });
      
      
    });
  }
  
  int selectedIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlans();
    getUserDetails();
    getPaymentDetails();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color:  Color(0xff1565c0),
                ),
                Expanded(
                  child: Container(
                              width: double.infinity,
                              height: 500,
                              color: Colors.white,
                            ),
                ),
              ],
            ),
          ),
          Column(
            children: [
            Row(
            children: [
              Image(image: AssetImage('assets/app_name.png')),
              Text('PRO',style: TextStyle(fontSize: 30),)
            ],
          ),
          SizedBox(height: 50,),
          Expanded(
            child: Opacity(
              opacity: loading?0:1,
              child: ListView.builder(itemCount: _plan.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  child: Card(
                    color: Colors.transparent,
                    borderOnForeground: false,
                    elevation: 10,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex=index;
                        });
                        
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color:selectedIndex==index?Colors.blue:Colors.transparent,width: 2),
                          borderRadius: BorderRadius.circular(15)),
                        height: selectedIndex==index?100+(30.0*_plan[index].features.length)+10: 100,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.star,color: selectedIndex==index?Colors.blue:Colors.grey,),
                              title: Text(_plan[index].name+'  '+_plan[index].amount.toString()+'/-',style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Expanded(child: Text(_plan[index].years??_plan[index].months??_plan[index].duration,)),
                              trailing: FlatButton(
                                onPressed: (){
                                  if(selectedIndex!=index){
                                    setState(() {
                                      selectedIndex=index;
                                    });
                                  }
                                  else{
                                    showModalBottomSheet(context: context, builder: (context){
                                      return Container(
                                        decoration: BoxDecoration( color: Color(0xff757575)),
                                        height: 400,
                                        width: double.infinity,
                                        
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15),
                                          
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.all(15),
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15),),
                                            child: Column(children: 
                                            [
                                              Spacer(flex: 1,),
                                              ListTile(
                                                leading:Image(image: AssetImage('assets/logo_blue.png')),
                                                title: Text(_plan[index].name),
                                                subtitle: Expanded(child: Text(_plan[index].duration,)),
                                                trailing: FlatButton(onPressed: (){}, child: Text(_plan[index].amount.toString()+'/-',style: TextStyle(color: Colors.white),),color: Colors.blue,),
                                              ),
                                              SizedBox(height: 10,),
                                              Visibility(
                                              visible: selectedIndex==index,
                                              child: Container(
                                                height: 30.0*_plan[index].features.length,
                                                // decoration: BoxDecoration(border: Border.all()),
                                                child: ListView.builder(itemBuilder: (context,ind){
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 5),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.add_task,size: 20,color: Colors.greenAccent[700],),
                                                        SizedBox(width: 5,),
                                                        Text(_plan[index].features[ind]),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount: _plan[index].features.length,),
                                              )
                                            ),
                                            Spacer(flex: 2,),
                                            FlatButton(
                                              onPressed: ()async{
                                                
                                                print('fi');
                                                String stage = "TEST";
                                                String orderId = "008";
                                                String orderAmount = _plan[index].amount.toString();
                                                String customerName = username;
                                                String orderNote = "Subscribed";
                                                String orderCurrency = "INR";
                                                String appId = pID;
                                                String customerPhone = user;
                                                String customerEmail = email;
                                                String notifyUrl = "https://pub.dev/packages/cashfree_pg/example";
            
                                                await getToken(orderAmount,orderId);
                                                print("token===:"+pToken);
                                                Map<String, dynamic> inputParams = {
                                                  "orderId": orderId,
                                                  "orderAmount": orderAmount,
                                                  "customerName": customerName,
                                                  "orderNote": orderNote,
                                                  "orderCurrency": orderCurrency,
                                                  "appId": appId,
                                                  "customerPhone": customerPhone,
                                                  "customerEmail": customerEmail,
                                                  "stage": stage,
                                                  "notifyUrl": notifyUrl,
                                                  "tokenData":pToken
                                                };
            
                                                CashfreePGSDK.doPayment(inputParams).then((value)  {
                                                  // this.responseRecieved();
                                                  print("----------------------------------------------------------");
                                                  print(value);
                                                  setState(() {
                                                    paymentResponse=value;
                                                  });
                                                  Fluttertoast.showToast(msg: "payment "+paymentResponse["txStatus"].toString().toLowerCase());
                                                  print(paymentResponse);
                                                  print(customerName);

                                                  //Do something with the result
                                                });
                                              }, 
                                              child: Text('Pay',style: TextStyle(color: Colors.white),),color: Colors.blue,),
                                            Spacer(flex: 1,)
                                        ],),
                                          ),
                                        ),
                                      );
                                    });
                                  }
                                }, 
                                child: Text(selectedIndex==index?'Buy':'View',style: TextStyle(color: Colors.white),),color: Colors.blue,),
                              
                            ),
                            SizedBox(height: 10,),
                            Visibility(
                            visible: selectedIndex==index,
                            child: Container(
                              height: 30.0*_plan[index].features.length,
                              // decoration: BoxDecoration(border: Border.all()),
                              child: ListView.builder(itemBuilder: (context,ind){
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_task,size: 20,color: Colors.greenAccent[700],),
                                      SizedBox(width: 5,),
                                      Text(_plan[index].features[ind]),
                                    ],
                                  ),
                                );
                              },
                              itemCount: _plan[index].features.length,),
                            )
                          ),
                          ],
                        )
                        ),
                    ),
                  ),
                );
              }),
            ),
          ),
          ],
          ),
          Visibility(
            visible: loading,
            child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: SpinKitFadingCircle(color: Colors.blue),//CircularProgressIndicator()
                        )
                    ),
                  ),
          )
          
        ],
      ),

    );
  }
}