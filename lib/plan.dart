import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:policy_maker/companyPlans.dart';
import 'package:policy_maker/services.dart';
import 'package:policy_maker/Responses.dart';

class Plan extends StatefulWidget {

  @override
  _PlanState createState() => _PlanState();
}

List companyNames=[];
List iName=[];
List iType=[];
List dummyList=['3 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','3 Adults + 1 Kid','3 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','3 Adults + 1 Kid','3 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','2 Adults + 1 Kid','3 Adults + 1 Kid'];
List MemberType=[];
List plans=[];
List planNames=[];
int planNo=0;
int status=0;
bool loading=true;
String selectedCompany=null;
String selectedInN=null;
String selectedInT=null;
String selectedMem=null;
bool insTypShow=false;
bool companyShow=false;
bool cardShow=false;
class _PlanState extends State<Plan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInsurenceNames();
    print("---0-"+iName.toString());
  }
  getInsurenceNames() async{
    Services.getInsuranceNames().then((value){
      setState(() {
        iName=value;
        loading=false;
      });
    });
  }

  getInsuranceType()async{
    Services.getInsuranceType(selectedInN).then((value){
      setState(() {
        iType=value;
        loading=false;
        insTypShow=true;
      });
    });
  }

  getCompanyNamesNT() async{
    
    Services.getCompany_N_T(selectedInN,selectedInT).then((value) {
      setState(() {
        companyNames=value;
        loading=false;
        companyShow=true;
      });
    });
    
    
    print("----"+companyNames.toString());
  }

  getPlanNames() async{
    
    Services.getPlanNames(selectedInN, selectedInT, selectedCompany).then((value) {
      setState(() {
      planNames=value;
      loading=false;
      });
      
    });
  }

  makePlanCards() async{
    for(int i=0;i<planNames.length;i++)
    {
      await Services.getPlanDetailsName(selectedCompany, selectedInN, selectedInT, planNames[i].planName).then((value){
        setState(() {
        planNames[i].member=value;
        print(planNames[i].member);
        });
      });
    }
    loading=false;   

  }

  String getText(){
    if(status==0){
      return "Choose Insurance Name";
    }
    else if(status==1){
      return "Choose Insurance Type";
    }
    else if(status==2){
      return "Choose Company Name";
    }
    else if(status==3){
      return "click on search";
    }
    else if(status==4){
      return "No Plans available";
    }
  }
 
  // getCompanyNames() async{
  //   Services.getCompanyNames().then((value) {
  //     setState(() {
  //       companyNames=value;
  //     });
  //   });
  //   print("----"+companyNames.toString());
  // }
  // getMemberType() async{
  //   Services.getMemberType(selectedInN,selectedInT,selectedCompany).then((value){
  //     setState(() {
  //       MemberType=value;
  //     });
  //   });
  // }
  // getPlanDetails() async{
  //   Services.getPlanDetails(selectedCompany).then((value){
  //     setState(() {
  //                       plans=value;
  //                       print(plans.length);
  //     });
  //   });
  // }
  // getPlans() async{
  //   for(int i=0;i<planNames.length;i++){
  //     Services.getPlanDetailsName(selectedCompany,selectedInN,selectedInT,planNames[i]).then((value){
  //     setState(() {    
  //                       plans=value;
  //                       print(plans.length);
  //     });
  //   });
  //   }
  // }
  // getPlanNames() async{
  //   Services.getPlanName(selectedCompany,selectedInN,selectedInT).then((value){
  //     setState(() {
  //                       planNames=value;
  //                       print(planNames.length);
  //                       // getPlans();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1565c0),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height-20,
        width: MediaQuery.of(context).size.width-20,
        color: Colors.white,
        child:Stack(
          children: [
            Column(
            children: [
              Align(alignment: Alignment.topLeft, child: Image(image: AssetImage('assets/logo_blue.png'))),
              
              Padding(
                padding: const EdgeInsets.only(top:20,left: 10,right: 10),
                child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      //borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all()
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(alignment: Alignment.topLeft, child: Text('Select Insurance Name:')),
                        SizedBox(width: 20,),
                        DropdownButton<dynamic>(
                        value: selectedInN,
                        underline: Container(
                          height: 2,
                        ),
                        onChanged: (dynamic newValue) {
                          setState(() {
                            // dropdownValue = newValue!;
                            selectedInN=newValue.toString();
                            if(selectedInN!=null)
                            {
                              
                              selectedInT=null;
                              selectedCompany=null;
                              selectedMem=null;
                
                              // cardShow=false;
                              // planNames=[];
                              status=1;
                              loading=true;
                              getInsuranceType();
                              
                              
                            }
                          });
                        },
                        items: iName
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: insTypShow?1:0,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all()
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(alignment: Alignment.topLeft, child: Text('Select Type:')),
                          SizedBox(width: 20,),
                          DropdownButton<dynamic>(
                          value: selectedInT,
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              // dropdownValue = newValue!;
                              selectedInT=newValue.toString();
                              if(selectedInT!=null)
                              {
                                // cardShow=false;
                                selectedCompany=null;
                                selectedMem=null;
                
                                // planNames=[];
                                status=2;
                                loading=true;
                                getCompanyNamesNT();
                                 
                              }
                            });
                          },
                          items: iType
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                                            ),
                        ],
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: companyShow?1:0,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                      border: Border.all()
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(alignment: Alignment.topLeft, child: Text('Select Company Name:')),
                          SizedBox(width: 20,),
                          DropdownButton<dynamic>(
                          value: selectedCompany,
                          underline: Container(
                            height: 2,
                          ),
                          onChanged: (dynamic newValue) {
                            setState(() {
                              // dropdownValue = newValue!;
                              selectedCompany=newValue.toString();
                              cardShow=false;
                              if(selectedCompany!=null){
                
                                // cardShow=false;
                
                                // planNames=[];
                
                                //get plan names
                                status=3;
                                loading=true;
                                getPlanNames();
                              }
                              
                            });
                          },
                          items: companyNames
                              .map<DropdownMenuItem<String>>((dynamic value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    
                    onPressed: ()async{
                      //make cards
                      print("=="+planNames.toString());
                      loading=true;
                      await makePlanCards();
                      if(planNames.length!=0){
                        print('hi');
                        cardShow=true;
                      }
                      if (planNames.length==0){
                        setState(() {
                         
                        status=4;
                        });
                      }
                      print(status);
                      showDialog(
                           context: context, 
                           builder: (context){
                             return Container(
                               padding: EdgeInsets.symmetric(vertical: 30),
                               child: Flexible(
                                  child: cardShow?Swiper(
                                    loop: false,
                                      itemBuilder: (context, index) {
                                        return Container(
                                    
                                          margin: EdgeInsets.all(30),
                                          
                                          child: Card(
                                            elevation: 10,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                
                                                children: [
                                                  Image(
                                                    image: AssetImage('assets/card${index%5}.png'),
                                                    height: 70,
                                                  ),
                                                  Text(
                                                    // plans[index].planName,
                                                    planNames[index].planName,
                                                    style: TextStyle(
                                                      fontSize: 25
                                                    ),  
                                                  ),
                                                  Text(
                                                    planNames[index].companyName,
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15
                                                    ),  
                                                  ),
                                                  Spacer(),
                                                  // TextButton(onPressed: (){
                                                    
                                                  //   showDialog(
                                                  //     context: context,
                                                      
                                                  //     builder: (_)=> AlertDialog(
                                                  //       actions: [TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Close'))],
                                                  //     title:  Text('Member Types'),
                                                  //     content:Container(
                                                  //       // height: 100,
                                                  //       width: 100,
                                                  //       child: planNames[index].member.length>0?ListView.builder(
                                                  //         shrinkWrap: true,
                                                  //         itemCount:planNames[index].member.length,
                                                  //         itemBuilder: (context,ind){
                                                  //         return ListTile(
                                                  //           title: Text(planNames[index].member[ind]),
                                                  //         );
                                                  //       }):Text('No member type to show'),
                                                  //     )
                                                  // ));
                                                  // }, 
                                                  // child: Text('View member types')),
                                                  TextButton(onPressed: (){}, child: Text('Member Types Available',style: TextStyle(color: Colors.blue),)),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                                    height: 70,
                                                    child: SingleChildScrollView(
                                                      child: Text(
                                                        planNames[index].member.toString().substring(1,planNames[index].member.toString().length-1),
                                                        //dummyList.toString(),
                                                      textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                        color: Colors.grey
                                                        ), 
                                                        
                                                        ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                 
                                                  Flexible(
                                                    child: ListView.builder(itemBuilder: (context,ind){
                                                      return Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(2.0),
                                                            child: 
                                                              
                                                                Text(planNames[index].planFeature[ind]),
                                                             
                                                          ),
                                                        ],
                                                      );
                                                      
                                                    },
                                                    itemCount: planNames[index].planFeature.length,),
                                                  ),
                                                  Spacer(),
                                                  FlatButton(onPressed: (){}, child: Text('Download Brochore',style: TextStyle(color: Colors.white),),color: Colors.blue,)
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      // autoplay: true,
                                      itemCount: planNames.length,
                                      pagination:  SwiperPagination(
                                        margin: EdgeInsets.all(5),
                                        builder: DotSwiperPaginationBuilder(size: 7,activeSize: 7,
                                        color: Colors.grey, activeColor:Colors.blue)
                                      ),
                                      control:  SwiperControl(
                                      ),
                                    ):Container(
                                      color: Colors.white,
                                      child: Opacity(opacity: 0.1, child: Image(image: AssetImage('assets/app_icon.png'))),
                                    )
                                          ),
                               margin: EdgeInsets.symmetric(horizontal: 20,vertical: 70),
                               color: Colors.transparent,
                             );
                           }
                          );
                        
                    },
                     child: Row(
                       mainAxisAlignment:MainAxisAlignment.center,
                       children: [
                         Text('Search Plans   '),
                         Icon(Icons.search)],
                     )
                  )
                
                ],
                  )
              ),
              
              Flexible(
                child: Container(
                    color: Colors.white,
                    child: Opacity(opacity: 0.1, child: Image(image: AssetImage('assets/app_icon.png'))),
                  )
                         ),
              
            ],
          ),
          Visibility(
            visible: loading,
            child: Opacity(
              opacity:0.5,
              child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height-20,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(child: SpinKitCircle(color: Colors.blue))
                      ),
                    ),
            ),
          )
          ]
        ),
        
      ),
    );
  }
}