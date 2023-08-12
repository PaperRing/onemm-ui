import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onemm/app/component/storage/storage.dart';
import 'package:onemm/app/component/storage/storage_key.dart';
import 'package:onemm/app/config/sentry_config.dart';

import '../model/user.dart' as U;
import '../util/random_util.dart';

class GoogleAuth {
  GoogleAuth._();

  static final _googleSignIn = GoogleSignIn();

  static Future<U.User> get() async {
    final user = await Storage().getString(StorageKey.CURERNT_USER);
    if (user == null) return U.User.empty();
    return U.User.fromMap(jsonDecode(user));
  }

  static Future<bool> login() async {
    final signInAccount = await _googleSignIn.signIn();
    final googleAuth = await signInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;
    if (user == null) return false;

    final email = user.email;
    if (email == null) return false;
    final name = "${(user.displayName ?? user.email?.split("@")[0])}_${RandomUtil.getRandomString(3)}";
    await Storage().setString(StorageKey.CURERNT_USER, jsonEncode(U.User(name, email).toMap()));

    return true;
  }

  static logout() async {
    await Storage().remove(StorageKey.CURERNT_USER);
    FirebaseAuth.instance.signOut();
  }

  static delete() async{
    var user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }
}
