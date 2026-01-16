import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Support {
  static Future<dynamic> showCustomBottomSheet(
    BuildContext context,
    Widget Function(BuildContext) builder,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      builder: builder,
    );
  }

  static Widget iosSpinner({Color? color, double radius = 15.0}) {
    return CupertinoActivityIndicator(
      color: color ?? Colors.white,
      radius: radius,
    );
  }
}
