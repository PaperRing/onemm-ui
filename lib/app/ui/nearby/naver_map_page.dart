  // import 'dart:async';
  //
  // import 'package:flutter/cupertino.dart';
  // import 'package:flutter/foundation.dart';
  // import 'package:flutter/material.dart';
  // import 'package:naver_map_plugin/naver_map_plugin.dart';
  //
  // class MyNaverMap extends StatelessWidget {
  //   @override
  //   Widget build(BuildContext context) {
  //     return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       title: 'Naver Map',
  //       home: NaverMapTest(),
  //     );
  //   }
  // }
  //
  // class NaverMapTest extends StatefulWidget {
  //   @override
  //   _NaverMapTestState createState() => _NaverMapTestState();
  // }
  //
  // class _NaverMapTestState extends State<NaverMapTest> {
  //   Completer<NaverMapController> _controller = Completer();
  //   MapType _mapType = MapType.Basic;
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(title: const Text('NaverMap Test')),
  //       body: Container(
  //         child: NaverMap(
  //           useSurface: kReleaseMode,
  //           onMapCreated: onMapCreated,
  //           mapType: _mapType,
  //         ),
  //       ),
  //     );
  //   }
  //
  //   void onMapCreated(NaverMapController controller) {
  //     if (_controller.isCompleted) _controller = Completer();
  //     _controller.complete(controller);
  //   }
  // }
