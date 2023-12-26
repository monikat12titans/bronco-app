import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RounderButton extends StatelessWidget {
  final Function onPress;
  final String? text;

  const RounderButton({
    required this.onPress,
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      onTap: () => onPress.call(),
      child: Container(
        width: double.infinity,
        height: 120.h,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            /* boxShadow: [
              BoxShadow(
                color: AppTheme.of(context).primaryColor,
                blurRadius: 0.0,
              ),
            ],*/
            color: AppTheme.of(context).primaryColor,
           /* gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppTheme.of(context).primaryColor,
                AppTheme.of(context).redColor,
              ],
            ),*/
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Center(
          child: Text(
            text ?? 'Button',
            style: TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
                fontFamily: FontFamily.OpenSans,
                fontSize: 35.sp,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
