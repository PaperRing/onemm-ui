import 'package:flutter/cupertino.dart';

import '../../../common/style.dart';

class DetailBox extends StatelessWidget {
  final children;

  DetailBox(this.children);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: CustomStyle.PADDING,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}

