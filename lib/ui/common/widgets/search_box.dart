import 'dart:ui';

import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBox extends StatelessWidget {
  final Function(String)? onChange;
  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType? textInputType;
  final bool isDesktop;

  const SearchBox(
      {Key? key,
      this.onChange,
      this.textEditingController,
      this.hintText,
      this.textInputType,
      this.isDesktop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(isDesktop ? 15 : 10.0),
              child: SvgPicture.asset(
                SVGPath.search,
                height: 20,
                width: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller:
                    textEditingController ?? TextEditingController(),
                style: TextStyle(
                    fontFamily: FontFamily.OpenSans,
                    fontSize: 35.sp,
                    // height: 1,
                    color: Colors.black),
                onChanged: onChange,
                cursorColor: Colors.black,
                keyboardType: textInputType ?? TextInputType.name,
                textAlign: TextAlign.justify,
                // cursorHeight: 25,
                decoration: InputDecoration(
                  hintText: hintText ?? StringConstants.search,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  labelStyle: TextStyle(
                    fontFamily: FontFamily.OpenSans,
                    color: Colors.white,
                    fontSize: 35.sp,
                  ),
                  /* hintStyle: const TextStyle(
                            fontFamily: FontFamily.Interstate,
                          )*/
                ),
              ),
            ),
          ],
        ));
  }
}
