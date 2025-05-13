import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.position,
    required this.no,
    required this.uid,
    required this.pic,
    required this.school,
    required this.other1,
    required this.other2,
    required this.balance,
    required this.rewards,
    required this.expectedRewards,
    required this.deposit,
    required this.withdrawal,
    required this.afflink,
    required this.affn,
    required this.affearn,
    required this.pendingamount,
  });

  late final String afflink;
  late final String name;
  late final String email;
  late final String position; //USER BINANCE ID
  late final int no;
  late final String uid;
  late final String pic;
  late final String school; // USER PICTURE
  late final String other1;
  late final String other2;
  late final double balance;
  late final double rewards;
  late final double expectedRewards;
  late final double deposit;
  late final double withdrawal;
  late final int affn;
  late final double affearn;
  late final double pendingamount;

  UserModel.fromJson(Map<String, dynamic> json) {
    afflink = json['afflink'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    position = json['position'] ?? '';
    no = json['no'] ?? 0;
    uid = json['uid'] ?? '';
    pic = json['pic'] ?? '';
    school = json['school'] ?? '';
    other1 = json['other1'] ?? '';
    other2 = json['other2'] ?? '';
    balance = (json['balance'] ?? 0.0).toDouble();
    rewards = (json['rewards'] ?? 0.0).toDouble();
    expectedRewards = (json['expectedRewards'] ?? 0.0).toDouble();
    deposit = (json['deposit'] ?? 0.0).toDouble();
    withdrawal = (json['withdrawal'] ?? 0.0).toDouble();
    affn = json['affn'] ?? 0;
    affearn = (json['affearn'] ?? 0.0).toDouble();
    pendingamount = (json['pendingamount'] ?? 0.0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['afflink'] = afflink;
    data['name'] = name;
    data['email'] = email;
    data['position'] = position;
    data['no'] = no;
    data['uid'] = uid;
    data['pic'] = pic;
    data['school'] = school;
    data['other1'] = other1;
    data['other2'] = other2;
    data['balance'] = balance;
    data['rewards'] = rewards;
    data['expectedRewards'] = expectedRewards;
    data['deposit'] = deposit;
    data['withdrawal'] = withdrawal;
    data['affn'] = affn;
    data['affearn'] = affearn;
    data['pendingamount'] = pendingamount;
    return data;
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel.fromJson(snapshot);
  }
}
