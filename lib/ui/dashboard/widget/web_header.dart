import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:get/get.dart';

class WebHeader extends StatelessWidget {
  final String headerTitle;
  final TextEditingController? searchTextEditController;
  final Function(String)? onSearchTextChange;
  final bool hasSearch;
  final TextInputType? searchInputType;
  final String? searchHintText;
  final EdgeInsets? bottomPadding;

  const WebHeader(
      {Key? key,
      this.headerTitle = 'Header Title',
      this.searchTextEditController,
      this.onSearchTextChange,
      this.hasSearch = false,
      this.searchInputType,
      this.searchHintText,
      this.bottomPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: SizedBox(
            height: 45,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    SVGPath.icon,
                    color: AppTheme.of(context).primaryColor,
                    height: 50,
                    width: 50,
                  ),
                ),
                Text(
                  headerTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 70.sp,
                      letterSpacing: 1.5,
                      color: Colors.black54,
                      fontFamily: FontFamily.OpenSans),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Spacer(),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onTap: () => Get.back(),
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: SvgPicture.asset(
                      SVGPath.backIc,
                      width: 80.w,
                      height: 80.h,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (hasSearch)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: SearchBox(
                      textInputType: searchInputType,
                      hintText: searchHintText,
                      isDesktop: true,
                      textEditingController:
                          searchTextEditController ?? TextEditingController(),
                      onChange: onSearchTextChange,
                    ),
                  )
              ],
            ),
          ),
        ),
        Padding(
          padding: bottomPadding ?? const EdgeInsets.only(bottom: 8),
          child: const Divider(
            color: Colors.black54,
            height: 1,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
