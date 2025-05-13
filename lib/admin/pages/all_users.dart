import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pro_trade/admin/userdetail.dart';
import 'package:pro_trade/model/usermodel.dart';

class UsersAll extends StatelessWidget {
  bool all;
 UsersAll({super.key,required this.all});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(all?"All Users":"Paid Users",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: all?FirebaseFirestore.instance.collection('users').snapshots():FirebaseFirestore.instance.collection('users').where("balance",isGreaterThan: 0.0).snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No data available for today',style: TextStyle(color: Colors.white)));
              }
              final data = snapshot.data!.docs.toList();
              if (data.isEmpty) {
                return Center(child: Text('No data available for today',style: TextStyle(color: Colors.white),));
              }
              final list = data.map((e) => UserModel.fromJson(e.data())).toList();
              return ListView.builder(
                itemCount: list.length,
                padding: EdgeInsets.only(top: 10),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return UserCard(user: list[index],);
                },
              );
          }
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget{
  UserModel user;
  UserCard({required this.user});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade50,
      child: ListTile(
        onTap: (){
          Navigator.push(
              context, PageTransition(
              child: Userdetail(user: user,), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 100)
          ));
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.pic),
        ),
        title: Text(user.name,style: TextStyle(fontWeight: FontWeight.w700),),
        subtitle: Text(user.email),
        trailing:Text("\$ "+user.balance.toString(),style: TextStyle(fontWeight: FontWeight.w700),) ,
      ),
    );
  }
}
