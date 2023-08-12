import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:onemm/app/ui/common/bottom_navigator.dart';

import 'component/my_login_view.dart';
import 'component/user_info_view.dart';

class MyPage extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigator(),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const UserInfoView();
          } else {
            return const MyLoginView();
          }
        },
      ),
    );
  }
}
