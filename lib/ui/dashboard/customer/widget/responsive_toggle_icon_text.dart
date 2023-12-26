import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveToggleIconText extends StatelessWidget {
  final List<String> text;
  final List<String> imgPath;
  final int selectedIndex;
  final Function(int) onSelected;
  final bool isDesktop;

  final Function()? onLogOut;

  const ResponsiveToggleIconText({
    required this.text,
    required this.imgPath,
    required this.selectedIndex,
    required this.onSelected,
    required this.isDesktop,
    Key? key,
    this.onLogOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(text.length == imgPath.length);
    return isDesktop
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  const Color(0xffff7e5f),
                  AppTheme.of(context).primaryColor,
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset(
                    PNGPath.appLogo,
                    height: 210.h,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () => onSelected.call(0),
                      child: ToggleItem(
                        isDesktop: true,
                        text: text[0],
                        isSelected: selectedIndex == 0,
                        imgPath: imgPath[0],
                      ),
                    ),
                    Container(
                      height: 0.7,
                      width: Get.width * 0.2,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () => onSelected.call(1),
                      child: ToggleItem(
                        isDesktop: true,
                        text: text[1],
                        isSelected: selectedIndex == 1,
                        imgPath: imgPath[1],
                      ),
                    ),
                    Container(
                      height: 0.7,
                      width: Get.width * 0.2,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () => onSelected.call(2),
                      child: ToggleItem(
                        isDesktop: true,
                        text: text[2],
                        isSelected: selectedIndex == 2,
                        imgPath: imgPath[2],
                      ),
                    ),
                    Container(
                      height: 0.7,
                      width: Get.width * 0.2,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () => onLogOut?.call(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            Text(
                              StringConstants.labelLogout,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 30.sp,
                                  fontFamily: FontFamily.OpenSans),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => onSelected.call(0),
                child: ToggleItem(
                  text: text[0],
                  isSelected: selectedIndex == 0,
                  imgPath: imgPath[0],
                ),
              ),
              InkWell(
                onTap: () => onSelected.call(1),
                child: ToggleItem(
                  text: text[1],
                  isSelected: selectedIndex == 1,
                  imgPath: imgPath[1],
                ),
              ),
              InkWell(
                onTap: () => onSelected.call(2),
                child: ToggleItem(
                  text: text[2],
                  isSelected: selectedIndex == 2,
                  imgPath: imgPath[2],
                ),
              )
            ],
          );
  }
}

class ToggleItem extends StatelessWidget {
  final String text;
  final String imgPath;
  final bool isSelected;
  final bool isDesktop;

  const ToggleItem(
      {required this.text,
      required this.imgPath,
      required this.isSelected,
      Key? key,
      this.isDesktop = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDesktop
        ? ColoredBox(
            color: isSelected ? Colors.white : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Image.asset(
                    imgPath,
                    width: 15,
                    height: 15,
                    color: isSelected
                        ? AppTheme.of(context).primaryColor
                        : Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.w300,
                        fontSize: 30.sp,
                        fontFamily: FontFamily.OpenSans),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imgPath,
                width: 15,
                height: 15,
                color: isSelected
                    ? AppTheme.of(context).primaryColor
                    : const Color(0xffC1C1C1),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                text,
                style: TextStyle(
                    color: isSelected ? Colors.black : Colors.black87,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
                    fontSize: 30.sp,
                    fontFamily: FontFamily.OpenSans),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 0.7,
                width: Get.width * 0.29,
                color: isSelected
                    ? AppTheme.of(context).primaryColor
                    : const Color(0xffC1C1C1),
              )
            ],
          );
  }
}
