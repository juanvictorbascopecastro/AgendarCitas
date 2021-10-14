import 'package:agenda/src/ui/widgets/configure.dart';
import 'package:flutter/cupertino.dart';

class ThemeController{
  ThemeController._();
  static final instance = ThemeController._();
  ValueNotifier<bool> brightness = ValueNotifier<bool>(true);
  bool get brightnessValue => brightness.value;

  Color primary() => brightnessValue?Configure.PRIMARY:Configure.PRIMARY_BLACK;
  Color secondary() => Configure.SECONDARY;

}