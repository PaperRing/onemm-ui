import 'package:flutter/material.dart';
import 'package:onemm/app/ui/walk/component/walk_recording.dart';

class WalkPage extends StatelessWidget {
  static const SIDE_MARGIN = 17.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: walk(),
    );
  }

  Widget walk() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(""),
        WalkRecording(),
      ],
    );
  }
}
