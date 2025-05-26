import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/model/usermodel.dart';

class ReferralScreen extends StatefulWidget {
  UserModel user;
  ReferralScreen({required this.user});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Pro Trade Referral',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: 5),
        child: ListView(
          children: [
            Text(
              'Invite friends and Earn money',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Join the financial evolution! Share your link and earn up to 30% revenue share (6% of your referral\'s payouts). Your referrals also get PARK Points as a bonus — plus additional rewards when they participate in the PARK Token Sale!\n\nFor deposits over \$1M, contact evergreenwealth50@gmail.com for custom terms.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 24),
            Text(
              'Share your link',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'https://evergreenwealth.in/${FirebaseAuth.instance.currentUser!.uid}',
                    style: TextStyle(
                      color: Color(0xffA0D8F1),
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.white),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: 'https://evergreenwealth.in/${FirebaseAuth.instance.currentUser!.uid}'));
                    Global.showMessage(context, "Copied to Clipboard", true);
                  },
                )
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Share your code',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${FirebaseAuth.instance.currentUser!.uid}',
                    style: TextStyle(
                      color: Color(0xffA0D8F1),
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.white),
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: '${FirebaseAuth.instance.currentUser!.uid}'));
                    Global.showMessage(context, "Copied to Clipboard", true);
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            infoTile('Link clicks:', widget.user.affn.toString()),
            infoTile('Registered with your link:', '$prc friends'),
            infoTile('Turnover:', '\$${widget.user.affearn}'),
            infoTile('Your total reward:', '\$${widget.user.affearn}'),
            SizedBox(height: 16),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.limeAccent,
        child: Icon(Icons.chat_bubble, color: Colors.black),
        onPressed: () {

        },
      ),*/
    );
  }

  void initState(){
    countDocumentsWithPresent();
  }
  void countDocumentsWithPresent() async {
    int count = 0; int i=0;
    await FirebaseFirestore.instance
        .collection('users').where("afflink",isEqualTo: widget.user.uid)
        .get()
        .then((querySnapshot) {
      count = querySnapshot.docs.length;
      print("Number of documents with in the 'Present' array: $count");
    }).catchError((error) {
      print("Error counting documents: $error");
    });
    setState(() {
      prc = count;
    });
  }
int prc=0;
  Widget infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontSize: 16,color: Colors.white))),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
        ],
      ),
    );
  }
}
