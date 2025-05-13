import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/home/settings.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:pro_trade/pay/pay_manuak.dart';
import 'package:pro_trade/setting/about_update.dart';
import 'package:pro_trade/setting/history.dart';
import 'package:pro_trade/setting/invite.dart';
import 'package:pro_trade/setting/portfolio.dart';
import 'package:pro_trade/setting/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'setting/payments/withdrawl.dart';

class Global{
  static final apikey="qUQ1L4uNfVW9IunMOZgKRc2D2BltWhuVENg4iXK7TW8Mmgk4D8TPseWkXGtbqfdh";
  static final api="jl8CK1miqOD8MtrkakyZp82LygDFT2yMM4Asd9R11NPaWFuLM6QBtQpfHRFIQLKq";

  static Color blac = Color(0xff23262B);

  static void showMessage(BuildContext context,String str, bool green) async{
    await Flushbar(
      titleColor: Colors.white,
      message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.linear,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: green?Colors.green:Colors.red,
      boxShadows: [BoxShadow(color: Colors.blue, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
      backgroundGradient: green?LinearGradient(colors: [Colors.green, Colors.green.shade400]):LinearGradient(colors: [Colors.red, Colors.redAccent.shade400]),
      isDismissible: false,
      duration: Duration(seconds: 3),
      icon: green? Icon(
        Icons.verified,
        color: Colors.white,
      ): Icon(
        Icons.warning,
        color: Colors.white,
      ),
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Colors.white,
      messageText: Text(
        str,
        style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: "ShadowsIntoLightTwo"),
      ),
    ).show(context);
  }
  static Widget button(String s,double w,Color r){
    return Center(
      child: Container(
        height:45,width:w-40,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(7),
          color:r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // Shadow color with transparency
              spreadRadius: 5, // The extent to which the shadow spreads
              blurRadius: 7, // The blur radius of the shadow
              offset: Offset(0, 3), // The position of the shadow
            ),
          ],
        ),
        child: Center(child: Text(s,style: TextStyle(
            color: Colors.black,
            fontFamily: "RobotoS",fontWeight: FontWeight.w800
        ),)),
      ),
    );
  }

  static Drawer drawer(BuildContext context,UserModel user){
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Color(0xff111111),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
              width:w/2,
              height: w/2,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.jpg"),fit: BoxFit.contain)
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: PayManuak(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                  ));
                },
                child: dff(Icon(Icons.payments,color: Colors.white,),"Invest",false)),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: History(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                child: dff(Icon(Icons.history,color: Colors.white,),"Transactions",false)),

            InkWell(
                onTap: () async {
                  Navigator.push(
                      context, PageTransition(
                      child: Portfolio(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                child: dff(Icon(Icons.vertical_split,color: Colors.white,),"Portfoilio",false)),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: Settingss(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                  ));
                },
                child: dff(Icon(Icons.person,color: Colors.white,),"Profile",false)),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: Withdrawl(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200)
                  ));
                },
                child: dff(Icon(Icons.credit_score,color: Colors.white,),"Withdrawl",false)),
            SizedBox(height: 15,),
            InkWell(
                onTap: () async {
                  final Uri _url = Uri.parse('https://evergreenwealth.in/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: dff(Icon(Icons.language,color: Colors.white,),"Website",true)),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: AboutAndMissionScreen(adbout: true,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                  ));
                },
                child: dff(Icon(Icons.info,color: Colors.white,),"About Us",false)),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: AboutAndMissionScreen(adbout: false,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                  ));
                },
                child: dff(Icon(Icons.remove_red_eye,color: Colors.white,),"Our Vision",false)),
            InkWell(
                onTap: () async {
                  final Uri _url = Uri.parse('https://evergreenwealth.in/contact-us/');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: dff(Icon(Icons.contact_mail,color: Colors.white,),"Contact Us",true)),

            SizedBox(height: 15,),
            InkWell(
                onTap: () async {
                  final Uri _url = Uri.parse('https://sites.google.com/view/starwishterms/privacy_policy');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: dff(Icon(Icons.privacy_tip,color: Colors.white,),"Privacy Policy",false)),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context, PageTransition(
                      child: ReferralScreen(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
                  ));
                },
                child: dff(Icon(Icons.share,color: Colors.white,),"Refer & Earn",false)),
            InkWell(
                onTap: () async {
                  final Uri _url = Uri.parse('https://sites.google.com/view/starwishacademy/terms-condition');
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: dff(Icon(Icons.paste_outlined,color: Colors.white,),"Terms & Condition",false)),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                circleavataar(FaIcon(FontAwesomeIcons.instagram,color: Colors.white,),'https://www.instagram.com/pro_trade_/?igsh=Z25zanMzOGk4YzNr'),
                circleavataar(FaIcon(FontAwesomeIcons.facebook,color: Colors.white),'https://www.instagram.com/pro_trade_/?igsh=Z25zanMzOGk4YzNr'),
                circleavataar(FaIcon(FontAwesomeIcons.telegram,color: Colors.white),'https://t.me/+z_hO_KTVuoxkNGQ1'),
                circleavataar(FaIcon(FontAwesomeIcons.x,color: Colors.white),'https://x.com/protradeik70?s=21'),
              ],
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
  static Widget circleavataar(Widget s,String link){
    return InkWell(
      onTap: () async {
        final Uri _url = Uri.parse(link);
        if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
        }
      },
      child: CircleAvatar(
        backgroundColor: Colors.black,
        child: Center(
          child: s,
        ),
      ),
    );
  }
  static Widget dff(Widget d,String str,bool give){
    return ListTile(
      leading: d,
      title: Text(str,style: TextStyle(color: Colors.white),),
      trailing: give?Icon(Icons.open_in_new_sharp,color: Colors.white,):SizedBox(),
    );
  }
}