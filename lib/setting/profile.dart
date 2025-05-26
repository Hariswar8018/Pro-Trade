import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_trade/home/navigation.dart';
import 'package:pro_trade/main.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro_trade/provider/declare.dart';
import 'package:pro_trade/provider/storage.dart';
import 'package:riverpod/riverpod.dart';

import '../global.dart';

class Profile extends StatefulWidget {
  UserModel user;bool update;
  Profile({super.key,required this.user,required this.update});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  Future<void> gyi() async {
    name.text=widget.user.name;
    email.text=widget.user.email;
    bio.text=widget.user.other2;
    userm.text=widget.user.other1;
    email.text=widget.user.email;
    pic=widget.user.pic;
    binanceid.text=widget.user.position;
    ss=widget.user.school;
    setState((){

    });
  }
  String pic="";
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(widget.update?"Update your Profile":"Complete your Profile",style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Center(
                child: Container(
                    width: w-20,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Global.blac,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        // specify the radius for the top-left corner
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        // specify the radius for the top-right corner
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        f(w, 0),
                        f(w, 1),
                      ],
                    )
                ),
              ),
            ),

            SizedBox(height: 5,),
            review==0?Column(
              children: [
                SizedBox(height: 15,),
                InkWell(
                  onTap: ()async{
                    try {
                      Uint8List? _file = await pickImage(
                          ImageSource.gallery);
                      String photoUrl = await StorageMethods()
                          .uploadImageToStorage('users', _file!, true);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.user.uid)
                          .update({
                        "pic": photoUrl,
                      });
                      Global.showMessage(context, "Uploaded",true);
                    }catch(e){
                      Global.showMessage(context, "$e",false);
                    }
                  },
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(pic),
                      radius: 65,
                    ),
                  ),
                ),
                Center(child: Text("Click to Upload Picture",style: TextStyle(color: Colors.white,fontSize: 12),)),
                SizedBox(height: 25,),
                fg(name, "Your Name", "Ayusman",false,1),
                fg(userm, "UserName", "Hariswar8018",false,1),
                fg(email, "Your Email", em,true,1),
                fg(bio, "Your Bio", "Ayusman",false,6),
              ],
            ):Column(
              children: [
                SizedBox(height: 15,),
                InkWell(
                  onTap: ()async{
                    try {
                      Uint8List? _file = await pickImage(ImageSource.gallery);
                      String photoUrl = await StorageMethods()
                          .uploadImageToStorage('users', _file!, true);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.user.uid)
                          .update({
                        "school": photoUrl,
                      });
                      Global.showMessage(context, "Uploaded",true);
                    }catch(e){
                      Global.showMessage(context, "$e",false);
                    }
                  },
                  child: Container(
                    width: w-30,
                    height: 300,
                    decoration: BoxDecoration(
                      border:Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(image: NetworkImage(ss),fit: BoxFit.contain)
                    ),
                    child: Center(child: Text(ss.isEmpty?"Upload you Scanner by Pressing here":"",style: TextStyle(color: Colors.white),)),
                  )
                ),
                Center(child: Text("Click to Upload Screenshot",style: TextStyle(color: Colors.white,fontSize: 12),)),
                SizedBox(height: 25,),
                fg(binanceid, "Your Binance ID", "",false,1),
              ],
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: InkWell(
            onTap: () async {
              await FirebaseFirestore.instance.collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid).update({
                "name":name.text,
                "other1":bio.text,
                "other2":userm.text,
                "position":binanceid.text,
              });
              if(widget.update){
                Navigator.pop(context);
              }else{
                Navigator.push(
                    context, PageTransition(
                    child: MyHomePage(title: '',), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                ));
              }
            },
            child: Container(
              height:45,width:w-40,
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(7),
                color:Color(0xffA0D8F1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4), // Shadow color with transparency
                    spreadRadius: 5, // The extent to which the shadow spreads
                    blurRadius: 7, // The blur radius of the shadow
                    offset: Offset(0, 3), // The position of the shadow
                  ),
                ],
              ),
              child: Center(child: Text(widget.update?"Update Profile":"Save and Continue",style: TextStyle(
                  color: Colors.black,
                  fontFamily: "RobotoS",fontWeight: FontWeight.w800
              ),)),
            ),
          ),
        ),
      ],
    );
  }
  String ss='';
  TextEditingController binanceid=TextEditingController();
  int review=0;
  Widget f(double w, int yes)=>InkWell(
    onTap: (){
      setState(() {
        review=yes;
      });
      print(review);
    },
    child: Container(
      width: w/2-30,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: yes==review?Color(0xffA0D8F1):Global.blac,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            yes==0?Icon(Icons.person,size: 25,color: Colors.black,):Icon(Icons.account_balance,size: 25,color: Colors.black,),
            SizedBox(width: 3,),
            Text(yiop(yes),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color:yes==review? Colors.black:Colors.white)),
          ],
        ),
      ),
    ),
  );
  String yiop(int y){
    if(y==0){
      return "Profile";
    }else if(y==1){
      return "Payments";
    }else {
      return "Invites";
    }
  }
  final userProvider = AsyncNotifierProvider<UserController, UserModel?>(() {
    return UserController();
  });

  void initState(){
    gyi();
  }

  String em="";
  TextEditingController userm=TextEditingController();
  TextEditingController name=TextEditingController();

  TextEditingController email=TextEditingController();

  TextEditingController bio=TextEditingController();

  Widget fg(TextEditingController ha, String str, String str2,bool a,int i) => Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
    child: TextFormField(
      controller: ha,
      readOnly: a,
      maxLines: i,
      keyboardType: TextInputType.text,
      maxLength: str=="UserName"?10:700,
      style: TextStyle(color: Colors.white), // ✅ Makes typed text white
      decoration: InputDecoration(
        labelText: str,
        counterText: "",
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

  Widget c(String str)=> Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4,bottom: 4),
          child: Text("$str",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 20)),
        ),
      ),
    ),
  );

  Widget s(String s, String n, bool b, bool j) {
    return ListTile(
      leading: j
          ? Icon(Icons.edit_rounded, color: Colors.green, size: 20)
          : Icon(Icons.circle, color: Colors.black, size: 20),
      title: Text(s + " :"),
      trailing:
      Text(n, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
      splashColor: Colors.orange.shade300,
      tileColor: b ? Colors.grey.shade50 : Colors.white,
    );
  }
}
