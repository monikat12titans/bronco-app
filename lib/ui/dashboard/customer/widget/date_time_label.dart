import 'package:bronco_trucking/enum/font_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimeLabel extends StatelessWidget {
  final String dateTime;

  const DateTimeLabel({
    required this.dateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime,
      style: TextStyle(
          fontSize: 27.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          fontFamily: FontFamily.OpenSans,
          color: Colors.black54),
    );
  }
}
