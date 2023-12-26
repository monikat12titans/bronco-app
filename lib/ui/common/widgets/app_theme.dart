import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bronco_trucking/enum/font_type.dart';

///
/// This class contains all UI related styles
///
class AppTheme extends StatefulWidget {
  final Widget? child;

  const AppTheme({@required this.child});

  @override
  State<StatefulWidget> createState() {
    return AppThemeState();
  }

  static AppThemeState of(BuildContext context) {
    final _InheritedStateContainer? inheritedStateContainer =
        context.dependOnInheritedWidgetOfExactType();
    if (inheritedStateContainer == null) {
      return AppThemeState();
    } else {
      return inheritedStateContainer.data!;
    }
  }
}

class AppThemeState extends State<AppTheme> {
  ///
  /// Define All your colors here which are used in whole application
  ///
  Color get whiteColor => const Color(0xFFFFFFFF);

  Color get primaryColor => const Color(0xffEE4D17);

  Color get redColor => const Color(0xFFD9534F);

  Color get dividerColor => const Color(0xFFC2C2C2);

  Color get blackColor => const Color(0xFF000000);

  Color get shimmerBackgroundColor => const Color(0xff484848).withOpacity(0.3);

  Color get shimmerBaseColor => Colors.grey[300] ?? Colors.grey;

  Color get shimmerHighlightColor => Colors.grey[100] ?? Colors.grey;

  ///
  /// Mention height and width which are mentioned in your design file(i.e XD)
  /// to maintain ratio for all other devices
  ///
  double get expectedDeviceWidth => 1080;

  double get expectedDeviceHeight => 1920;

  TextStyle customTextStyle(
      {double fontSize = 12,
      Color? color,
      FontWeight? fontWeightType,
      String fontFamilyType = FontFamily.OpenSans,
      TextDecoration? decoration}) {
    return TextStyle(
        decoration: decoration,
        fontWeight: fontWeightType,
        fontFamily: fontFamilyType,
        fontSize: fontSize.sp,
        color: color);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final AppThemeState? data;

  _InheritedStateContainer({
    @required this.data,
    @required Widget? child,
    Key? key,
  })  : assert(child != null),
        super(key: key, child: child!);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
