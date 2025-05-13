import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/home/navigation.dart';
import 'package:pro_trade/login/forgot.dart';
import 'package:pro_trade/main.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/setting/profile.dart';


class Login extends StatefulWidget {
  String affiliate;
  Login({super.key,required this.affiliate});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int i = 0; // Track the index

  @override
  void initState() {
    super.initState();
    f(); // Start the timer
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool b=false;
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if(b){
          setState(() {
            b=false;
          });
          return false;
        }else{
          return true;
        }
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
            Text(signup?"  Create Account !":"  Hi There !",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: Colors.white),),
            SizedBox(height: 5),
            Text(signup?"     to Start Investing in USDT":"     Have we Meet Before ?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
            SizedBox(height: 24),
            signup?fg(name, "Your Name", ""):SizedBox(),
            SizedBox(height: 5),
            fg(email, "Your Email", ""),
            SizedBox(height: 5),
            fg(password, "Your Password", ""),
            SizedBox(height: 5),
            progress?Center(child: CircularProgressIndicator(backgroundColor: Colors.grey,)):InkWell(
              onTap: () async {
                setState(() {
                  progress=true;
                });
                if(signup){
                  try{
                    final us=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
                    UserModel user=UserModel(name: name.text,
                        email: email.text, position: "", no: 0, uid: us.user!.uid,
                        pic: "", school: "", other1: "", other2: "", balance: 0.0, rewards: 0.0,
                        expectedRewards: 0.0, deposit: 0.0, withdrawal: 0.0, afflink: widget.affiliate, affn: 0, affearn:0.0, pendingamount: 0.0,
                    );
                    await FirebaseFirestore.instance.collection("users").doc(us.user!.uid).set(user.toJson());
                    Navigator.push(
                        context, PageTransition(
                        child: Profile(user: user, update: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                    Global.showMessage(context, "SignUp Successful",true);
                  }catch(e){
                    Global.showMessage(context, "$e",false);
                  }
                }else{
                  try{
                    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                    Navigator.push(
                        context, PageTransition(
                        child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                    Global.showMessage(context, "LoggedIn Successful",true);
                  }catch(e){
                    Global.showMessage(context, "$e",false);
                  }
                }
                setState(() {
                  progress=false;
                });
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
                        signup?"Sign Up":"Log In",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                      ),
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0,bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: w/2-39,height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade900,
                    ),
                  ),
                  Text(
                    "   OR   ",
                    style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w800, fontSize: 13),
                  ),
                  Container(
                    width: w/2-39,height: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey.shade900,
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () async{
                  setState(() {
                    progress=true;
                  });
                  try {
                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication googleAuth = await googleUser!
                        .authentication;
                    final AuthCredential credential = GoogleAuthProvider
                        .credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    final user = await FirebaseAuth.instance.signInWithCredential(credential);
                    String uid = await FirebaseAuth.instance.currentUser!.uid;
                    String emaill = await FirebaseAuth.instance.currentUser!.email??"";
                    try{
                      UserModel user=UserModel(name: name.text,
                          email: emaill, position: "", no: 0, uid: uid,
                          pic: "", school: "", other1: "", other2: "", balance: 0.0, rewards: 0.0,
                          expectedRewards: 0.0, deposit: 0.0, withdrawal: 0.0, afflink: widget.affiliate,
                        affn: 0, affearn:0.0, pendingamount: 0.0,
                      );
                      await FirebaseFirestore.instance.collection("users").doc(uid).set(user.toJson());
                      Navigator.push(
                          context, PageTransition(
                          child: Profile(user: user, update: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                      ));
                      Global.showMessage(context, "SignUp Successful",true);
                    }catch(e){
                      Global.showMessage(context, "$e", false);
                    }
                    Navigator.push(
                        context, PageTransition(
                        child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                    ));
                  }catch(e){
                    print(e);
                    Global.showMessage(context, "$e", false);
                  }
                  setState(() {
                    progress=false;
                  });
                },
                child: Container(
                    width: w - 35,
                    height: 45,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/google.webp",height: 30,),
                        Text(
                          "  "+(signup?"Sign Up":"Log In")+" with Google",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                      ],
                    )
                ),
              ),
            ),
            SizedBox(height: 14,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 13,),
                TextButton(onPressed: () {
                  setState(() {
                    if(signup){
                      signup=false;
                    }else{
                      signup=true;
                    }
                  });
                }, child: Text(signup?"Not New? Login ":"New User? Sign Up here",style: TextStyle(color: Colors.white),),),
                Spacer(),
                TextButton(onPressed: () {
                  Navigator.push(
                      context, PageTransition(
                      child: Forgot(), type: PageTransitionType.topToBottom, duration: Duration(milliseconds: 800)
                  ));
                }, child: Text("Forgot Password?",style: TextStyle(color: Colors.white),),),
                SizedBox(width: 13,),
              ],
            ),
            SizedBox(height: 60),
          ],
        )
      ),
    );
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

  void f() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        if (i >= 5) {
          i = 0; // Reset to 1
        } else {
          i++;
        }
      });
    });
  }
}
