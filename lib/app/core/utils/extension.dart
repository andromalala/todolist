import 'dart:math';

import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/utils/responsive.dart';

extension TestString on String {

  isValidatePassword() => length >= 4 ? true : false;

  bool isdouble() {
    try {
      double.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

Map<String, dynamic> removeNullsFromMap(Map<String, dynamic> json) => json
  ..removeWhere((String key, dynamic value) => value == null)
  ..map<String, dynamic>((key, value) => MapEntry(key, removeNulls(value)));

List removeNullsFromList(List<dynamic> list) => list
  ..removeWhere((value) => value == null)
  ..map((e) => removeNulls(e)).toList();

dynamic removeNulls(dynamic e) => (e is List)
    ? removeNullsFromList(e)
    : (e is Map<String, dynamic> ? removeNullsFromMap(e) : e);

extension ListExtension on List {
  List get removeNulls => removeNullsFromList(this);
}

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> get removeNulls => removeNullsFromMap(this);
}

extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double h(BuildContext context) => this * Responsive.height(context) / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double w(BuildContext context) => this * Responsive.width(context) / 100;

  static Size resolution(BuildContext context) =>
      Size(Responsive.width(context), Responsive.height(context));

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double sp(BuildContext context) =>
      (this * scaleText(context)).roundToDouble();

  double scaleText(BuildContext context) =>
      min(scaleWidth(context), scaleHeight(context));

  /// The ratio of actual width to UI design
  double scaleWidth(BuildContext context) =>
      (Responsive.width(context) / (Responsive.isMobile(context) ? 3.5 : 5)) /
      100;

  /// The ratio of actual height to UI design
  double scaleHeight(BuildContext context) =>
      (Responsive.height(context) / (Responsive.isMobile(context) ? 3.5 : 5)) /
      100;
}
