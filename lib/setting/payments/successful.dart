import 'package:flutter/material.dart';
import 'package:pro_trade/global.dart';
import 'package:pro_trade/home/navigation.dart';

class PurchaseSuccessful extends StatelessWidget {
  double sum;bool success;
  PurchaseSuccessful({super.key,required this.sum,required this.success});

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Center(child: Image.asset("assets/success.png",width: w/2,))
            ,Text(success?'Transaction Submitted':"Payment Successful",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child:Text("+ ₹${sum.toInt()}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 35,color: Colors.white),),
            ),
            Spacer(),
            InkWell(
                onTap: () async {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Global.button("Continue", w, Colors.yellowAccent)),
            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
