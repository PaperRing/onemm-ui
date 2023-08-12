import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../controller/store_controller.dart';
import '../common/bottom_navigator.dart';
import '../my_page/component/login_view.dart';
import 'component/like_place.dart';

class LikedPlacePage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigator(),
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return LikePlace();
            } else {
              return LoginView();
            }
          },
        ),
      ),
    );
  }
}
