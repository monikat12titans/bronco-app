import 'dart:io';

import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/common/widgets/bronco_button.dart';
import 'package:bronco_trucking/ui/dashboard/upload_pod/upload_pod_and_signature_controller.dart';
import 'package:bronco_trucking/ui/dashboard/widget/app_bar.dart';
import 'package:bronco_trucking/ui/dashboard/widget/web_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UploadPODAndSignaturePage
    extends GetResponsiveView<UploadPODAndSignatureController> {
  @override
  Widget? builder() {
    var height = Get.height * (0.4) - 100;
    var width = Get.width - 120;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BroncoAppBar(
        isDeskTop: screen.isDesktop,
        onBackTap: () => Get.back(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            if (screen.isDesktop)
              const WebHeader(
                headerTitle: StringConstants.labelUploadPOD,
              ),
            if (screen.isDesktop)
              DesktopSectionView(uploadPODAndSignatureController: controller)
            else ...[
              Obx(() => controller.uploadImage.value.isNotEmpty
                  ? kIsWeb
                      ? Image.memory(
                          controller.imageByteData!,
                          height: height,
                          width: height,
                        )
                      : Image.file(
                          File(controller.uploadImage.value),
                          height: height,
                          width: width,
                        )
                  : controller.productImage.isNotEmpty
                      ? Image.network(
                          Utils.productImagePath(controller.productImage),
                          fit: BoxFit.fill,
                          height: Get.height * 0.3 - 50,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      : SizedBox(
                          height: Get.height * 0.3 - 50,
                        )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AttachmentHeader(
                  onTap: () => openBottomSheet(controller),
                  headerText: StringConstants.btnUploadPOD,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<UploadPODAndSignatureController>(
                  // no need to initialize Controller ever again, just mention the type
                  builder: (value) => controller.hasSignature.isTrue &&
                          controller.getSignatureUInt8List != null
                      ? ColoredBox(
                          color: const Color(0xffF5F5F5),
                          child: Image.memory(
                            controller.getSignatureUInt8List!,
                            height: height / 2,
                            width: width,
                          ),
                        )
                      : controller.signature.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.network(
                                Utils.productSignaturePath(
                                    controller.signature),
                                fit: BoxFit.fill,
                                height: Get.height * 0.3 - 50,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            )
                          : SizedBox(
                              height: Get.height * 0.3 - 50,
                            )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AttachmentHeader(
                  onTap: () => controller.onAddDigitalSignatureTap(),
                  headerText: StringConstants.btnAddDigitalSignature,
                ),
              ),
            ],
            const Spacer(),
            BroncoButton(
              onPress: () => controller.uploadFile(),
              rounder: 30,
              hasGradientBg: false,
              width: Get.width * 0.8 - 30,
              blurRadius: 0,
              text: StringConstants.btnSubmit.toUpperCase(),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class DesktopSectionView extends StatelessWidget {
  final UploadPODAndSignatureController uploadPODAndSignatureController;

  const DesktopSectionView(
      {required this.uploadPODAndSignatureController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Obx(() => uploadPODAndSignatureController
                            .uploadImage.value.isNotEmpty
                        ? kIsWeb
                            ? Image.memory(
                                uploadPODAndSignatureController.imageByteData!,
                                height: Get.height * 0.6,
                                width: Get.height * 0.6,
                              )
                            : Image.file(
                                File(uploadPODAndSignatureController
                                    .uploadImage.value),
                                height: Get.height * 0.6,
                                width: Get.height * 0.6,
                              )
                        : uploadPODAndSignatureController
                                .productImage.isNotEmpty
                            ? Image.network(
                                Utils.productImagePath(
                                    uploadPODAndSignatureController
                                        .productImage),
                                fit: BoxFit.fill,
                                height: Get.height * 0.6,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )
                            : SizedBox(
                                height: Get.height * 0.6,
                              )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AttachmentHeader(
                        onTap: () =>
                            uploadPODAndSignatureController.onUploadImageTap(),
                        headerText: StringConstants.btnUploadPOD,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GetBuilder<UploadPODAndSignatureController>(
                        // no need to initialize Controller ever again, just mention the type
                        builder: (value) => uploadPODAndSignatureController
                                    .hasSignature.isTrue &&
                                uploadPODAndSignatureController
                                        .getSignatureUInt8List !=
                                    null
                            ? ColoredBox(
                                color: const Color(0xffF5F5F5),
                                child: Image.memory(
                                  uploadPODAndSignatureController
                                      .getSignatureUInt8List!,
                                  height: Get.height * 0.6,
                                  width: Get.height * 0.6,
                                ),
                              )
                            : uploadPODAndSignatureController
                                    .signature.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Image.network(
                                      Utils.productSignaturePath(
                                          uploadPODAndSignatureController
                                              .signature),
                                      fit: BoxFit.fill,
                                      height: Get.height * 0.6,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    height: Get.height * 0.6,
                                  )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AttachmentHeader(
                        onTap: () => uploadPODAndSignatureController
                            .onAddDigitalSignatureTap(),
                        headerText: StringConstants.btnAddDigitalSignature,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  final String name;

  const BottomSheetItem({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: Get.width * 0.8,
        child: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 40.sp,
              color: Colors.black54,
              fontFamily: FontFamily.OpenSans),
        ),
      ),
    );
  }
}

class AttachmentHeader extends StatelessWidget {
  final String headerText;
  final Function onTap;

  const AttachmentHeader({
    required this.headerText,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                headerText,
                style: TextStyle(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.OpenSans,
                    fontSize: 40.sp,
                    color: Colors.black87),
              ),
              const Spacer(),
              SvgPicture.asset(SVGPath.uploadIc)
            ],
          ),
          const Divider(
            height: 20,
            thickness: 1,
          )
        ],
      ),
    );
  }
}

void openBottomSheet(UploadPODAndSignatureController controller) {
  Get.bottomSheet(
      Container(
          height: 150,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                child: Container(
                  width: 120,
                  height: 5,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                ),
              ),
              InkWell(
                onTap: () => controller.onUploadImageTap(),
                child: const BottomSheetItem(
                  name: StringConstants.gallery,
                ),
              ),
              const Divider(
                height: 5,
              ),
              InkWell(
                onTap: () => controller.onUploadImageTap(isCamera: true),
                child: const BottomSheetItem(
                  name: StringConstants.camera,
                ),
              )
            ],
          )),
      isDismissible: true,
      enableDrag: true,
      elevation: 10);
}
