import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/home/navigation.dart';
import 'package:pro_trade/login/login.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/setting/profile.dart';

class AffiliateLinks extends StatefulWidget {
   AffiliateLinks({super.key});

  @override
  State<AffiliateLinks> createState() => _AffiliateLinksState();
}

class _AffiliateLinksState extends State<AffiliateLinks> {
  int i = 0;
 // Track the index
  bool b=false;

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(0xff111111),
          appBar: AppBar(
            backgroundColor: Color(0xff111111),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/logo.jpg"),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(signup?"  Create Account !":"  Affiliate Link",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.white),),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 14.0,right: 14),
                child: Text(signup?"     to Start Investing in USDT":"Enter the Affiliate Code to get 5% Extra for first Deposit ?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
              ),
              SizedBox(height: 24),
              fg(name, "Enter Affiliate Code", ""),
              SizedBox(height: 5),
              SizedBox(height: 5),
              progress?SizedBox():InkWell(
                onTap: () async {
                  if(name.text.isEmpty){
                    Global.showMessage(context, "Please Write Affiliate Code", false);
                    return ;
                  }
                  try {
                    CollectionReference usersCollection = FirebaseFirestore
                        .instance
                        .collection('users');
                    QuerySnapshot querySnapshot = await usersCollection.where(
                        'uid', isEqualTo: name.text).get();
                    if (querySnapshot.docs.isNotEmpty) {
                      UserModel user = UserModel.fromSnap(
                          querySnapshot.docs.first);
                      df();
                      Navigator.push(
                          context, PageTransition(
                          child: Login(affiliate: user.uid,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                      ));
                      Global.showMessage(context, "Affiliate Code Valid!", true);
                    } else {
                      Global.showMessage(context, "Couldn't find Affiliate Code !", false);
                    }
                  }catch(e){
                    Global.showMessage(context, "Couldn't find PromoCode", false);
                  }
                },
                child:Center(
                  child: Container(
                      width: w - 35,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Color(0xffA0D8F1),
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child:  Center(
                        child: Text(
                          signup?"Sign Up":"Fetch & Continue",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: 9),
              Center(child: Text("OR",style: TextStyle(color: Colors.grey),)),
              SizedBox(height: 9),
              progress?Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,)):InkWell(
               onTap: (){
                 Navigator.push(
                     context, PageTransition(
                     child: Login(affiliate:"NA"), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                 ));
               },
                child:Center(
                  child: Container(
                      width: w - 35,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(6)
                      ),
                      child:  Center(
                        child: Text(
                          signup?"Sign Up":"Skip",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      )
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          )
      ),
    );
  }

  Future<void> df() async {
    try{
      CollectionReference usersCollection = FirebaseFirestore
          .instance
          .collection('users');
      await usersCollection.doc(name.text).update({
        "affn":FieldValue.increment(1),
      });
    }catch(e){

    }
  }
  bool progress=false;

  bool signup=false;

  Widget fg(TextEditingController ha, String str, String str2) => Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
    child: TextFormField(
      controller: ha,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white), // ✅ Makes typed text white
      decoration: InputDecoration(
        labelText: str,
        labelStyle: TextStyle(color: Colors.white), // ✅ Makes label text white
        hintText: str2,
        hintStyle: TextStyle(color: Colors.white70), // ✅ Makes hint text white with slight opacity
        isDense: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // ✅ White border
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // ✅ White border when not focused
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0), // ✅ Thicker white border when focused
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please type It';
        }
        return null;
      },
    ),
  );

  TextEditingController name=TextEditingController();

  TextEditingController email=TextEditingController();

  TextEditingController verify=TextEditingController();

  TextEditingController password=TextEditingController();

  Widget d(int j) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 9,
        height: 9,
        decoration: BoxDecoration(shape: BoxShape.circle, color: i != j ? Colors.white : Colors.grey),
      ),
    );
  }
}
