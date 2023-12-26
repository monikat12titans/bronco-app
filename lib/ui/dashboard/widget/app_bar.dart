
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BroncoAppBar extends StatelessWidget {
  final Function? onLogoutTap;
  final Function? onBackTap;
  final Function? onSearchTap;
  final bool hasLogout;
  final bool hasBack;
  final bool hasSearchIcon;
  final Widget child;
  final bool isDeskTop;

  const BroncoAppBar({
    required this.child,
    this.onLogoutTap,
    Key? key,
    this.hasLogout = false,
    this.hasBack = true,
    this.onBackTap,
    this.onSearchTap,
    this.hasSearchIcon = false,
    this.isDeskTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: isDeskTop
          ? Stack(
              children: [
                Positioned(top: 0, bottom: 0, left: 0, right: 0, child: child),
                Positioned(
                  top: 10,
                  right: 0,
                  child: hasSearchIcon
                      ? MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            width: 40.w,
                            height: 120.h,
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                border: Border.all(
                                  color: Colors.black38,
                                ),
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(60),
                                    topLeft: Radius.circular(60))),
                            child: GestureDetector(
                              onTap: () => onSearchTap?.call(),
                              child: const Icon(
                                Icons.search,
                                color: Colors.black54,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                      : const Offstage(),
                ),
                Positioned(
                    top: 60.w,
                    right: 0,
                    child: hasLogout
                        ? MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => onLogoutTap?.call(),
                              child: Container(
                                width: 40.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(
                                      color: Colors.black38,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(60),
                                        topLeft: Radius.circular(60))),
                                padding: const EdgeInsets.all(10.0),
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        : const Offstage()),
              ],
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 160.h,
                  padding: const EdgeInsets.only(top: 20),
                  color: const Color(0xff052135),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (hasBack)
                        Positioned(
                          left: 0,
                          top: 5,
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 40.w,
                                right: 40.w,
                                top: 15.h,
                                bottom: 15.h),
                            child: GestureDetector(
                              onTap: () => onBackTap?.call(),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  SVGPath.backIc,
                                  width: 50.w,
                                  height: 65.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 5,
                        child: SvgPicture.asset(
                          SVGPath.icon,
                          width: 50.w,
                          height: 60.h,
                          color: AppTheme.of(context).primaryColor,
                        ),
                      ),
                      Positioned(
                        right: 90,
                        bottom: 0,
                        top: 0,
                        child: SizedBox(
                          width: 80.w,
                          height: 80.h,
                          child: hasSearchIcon
                              ? GestureDetector(
                                  onTap: () => onSearchTap?.call(),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white54,
                                    size: kIsWeb ? 30 : 55.w,
                                  ),
                                )
                              : const Offstage(),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 5,
                        top: 5,
                        child: hasLogout
                            ? GestureDetector(
                                onTap: () => onLogoutTap?.call(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                      StringConstants.labelLogout,
                                      style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 15,
                                          fontFamily: FontFamily.OpenSans),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.logout,
                                      color: Colors.white54,
                                      size: 20,
                                    )
                                  ],
                                ),
                              )
                            : const Offstage(),
                      ),
                    ],
                  ),
                ),
                //   Container(color: Colors.red,),
                Expanded(child: child)
              ],
            ),
    );
  }
}
