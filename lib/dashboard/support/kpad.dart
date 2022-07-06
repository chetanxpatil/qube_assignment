import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Kpad {
  Kpad._();

  static double width22 = (Get.width / 20).toPrecision(0);

  static Widget h22({required Widget child, double? top, double? bottom}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width22).copyWith(top: top, bottom: bottom),
      child: child,
    );
  }
}
