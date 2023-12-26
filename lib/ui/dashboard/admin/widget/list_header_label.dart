import 'package:bronco_trucking/enum/font_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListHeaderLabel extends StatelessWidget {
  final String label;
  final Color textColor;

  const ListHeaderLabel(
      {Key? key, this.label = '', this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          fontFamily: FontFamily.OpenSans,
          fontWeight: FontWeight.w600,
          color: textColor),
    );
  }
}
