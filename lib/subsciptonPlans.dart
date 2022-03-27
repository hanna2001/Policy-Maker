class SubPlans{
  String name;
  String duration;
  List features;
  String amount;
  String months;
  String years;


  SubPlans({this.duration,this.features,this.name,this.amount});

  // List getFeatures(String s){
  //   List li=[];
  //   li=s.

  // }
  setYear(){
    int days=int.parse(duration);
    if(days>=365){
      years=(days/365).round().toString()+" year(s)";
    }
    
  }

  setMonth(){
    int days=int.parse(duration);
    if(days>=30){
      months=(days/30).round().toString()+' month(s)';
    }
  }
}

