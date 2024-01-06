import 'package:flutter/material.dart';

import '../utils/screen.dart';
import '../values/colors.dart';

/// 透明背景 AppBar
PreferredSizeWidget transparentAppBar({
  required BuildContext context,
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColors.secondaryElement}) {
  return Container(
    height: duSetWidth(10),
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}
