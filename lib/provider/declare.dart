import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro_trade/model/usermodel.dart';
import 'package:riverpod/riverpod.dart';


class UserController extends AsyncNotifier<UserModel?> {
  @override
  FutureOr<UserModel?> build() async {
    return await _getUser();
  }

  Future<UserModel> _getUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return UserModel.fromSnap(snap);
  }

  Future<void> refreshUser() async {
    final user = await _getUser();
    state = AsyncData(user);
  }
}
