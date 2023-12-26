import 'package:bronco_trucking/enum/font_type.dart';
import 'package:bronco_trucking/ui/common/strings.dart';
import 'package:bronco_trucking/ui/common/widgets/app_theme.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/common/widgets/empty_list_error_text.dart';
import 'package:bronco_trucking/ui/common/widgets/error_text.dart';
import 'package:bronco_trucking/ui/dashboard/driver/submit_to_office/submit_to_office_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubmitToOfficePage extends GetResponsiveView<SubmitToOfficeController> {
  @override
  Widget? builder() {
    return Scaffold(
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(screen.isDesktop)...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                StringConstants.btnDeliveredToBronco,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 70.sp,
                    letterSpacing: 1.5,
                    color: Colors.black54,
                    fontFamily: FontFamily.OpenSans),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 8),
              child: Divider(
                color: Colors.black54,
                height: 5,
                thickness: 2,
              ),
            ),],
            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: AppTheme.of(Get.context!).primaryColor,
                  child: Obx(() {
                    if (controller.isSuccess) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                padding: EdgeInsets.zero,
                                itemBuilder: (_, index) {
                                  var data = controller.checkInList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Text(
                                      '${StringConstants.labelMAWB} #${data.mbn}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 50.sp,
                                          color: Colors.black.withOpacity(0.8),
                                          fontFamily: FontFamily.OpenSans),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, index) {
                                  return const Divider(
                                    height: 2,
                                  );
                                },
                                itemCount: controller.checkInList.length),
                          ),
                          if (screen.isDesktop)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BroncoButton(
                                  onPress: () => controller.tapOnSubmit(),
                                  rounder: 20,
                                  width: 120,
                                  blurRadius: 0,
                                  hasGradientBg: false,
                                  text: StringConstants.btnSubmit.toUpperCase(),
                                ),
                              ),
                            )
                          else
                            BroncoButton(
                              onPress: () => controller.tapOnSubmit(),
                              rounder: 0,
                              hasGradientBg: false,
                              text: StringConstants.btnSubmit.toUpperCase(),
                            )
                        ],
                      );
                    }
                    if (controller.isSuccessWithEmptyList) {
                      return const EmptyListErrorText();
                    }
                    if (controller.isError) {
                      return ErrorText(
                        errorMessage: controller.statusMessage,
                      );
                    }
                    return const Offstage();
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
