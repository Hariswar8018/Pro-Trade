import 'package:flutter/material.dart';
import 'package:pro_trade/global.dart';

class PayManuak extends StatefulWidget {
  const PayManuak({super.key});

  @override
  State<PayManuak> createState() => _PayManuakState();
}

class _PayManuakState extends State<PayManuak> {
  bool open=false;
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff111111),
      appBar: AppBar(
        backgroundColor: Color(0xff111111),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text("Pay Now",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                open=!open;
              });
            },
            child: Center(
              child:open? Stack(
                children: [
                  Container(
                    width: w-40,
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage("assets/scanner.png"),fit: BoxFit.contain)
                    ),
                  ),
                  Container(
                      width: w-40,
                        height: 50,
                        decoration: BoxDecoration(
                  color: Color(0xffABC07D),
                  borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pay by QR Scan ( Manual ) "),
                    Icon(Icons.arrow_drop_down),
                  ],
                              ),
                        ),
                      ),
                ],
              ):Container(
                width: w-40,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xffABC07D),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pay by QR Scan ( Manual ) "),
                      Icon(Icons.arrow_right_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Global.showMessage(context, "Not yet Activate",false);
            },
            child: Center(
              child: Container(
                width: w-40,
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffABC07D),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pay by Binance "),
                      Icon(Icons.arrow_right_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
