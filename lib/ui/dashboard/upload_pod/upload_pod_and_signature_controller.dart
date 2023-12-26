import 'dart:io';
import 'dart:typed_data';

import 'package:bronco_trucking/di/app_component_base.dart';
import 'package:bronco_trucking/di/app_core.dart';
import 'package:bronco_trucking/models/response/api_states.dart';
import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:bronco_trucking/ui/common/routes.dart';
import 'package:bronco_trucking/ui/common/utils.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/success_error_controller.dart';
import 'package:bronco_trucking/ui/dashboard/success_error/widget/animated_icon_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadPODAndSignatureController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  RxString uploadImage = ''.obs;
  final RxBool hasSignature = false.obs;
  Uint8List? _signatureUInt;
  XFile? productImgFile;
  ByteData? byteData;
  Uint8List? imageByteData;
  String mawb = '';
  UploadFrom uploadFrom = UploadFrom.pickUpCheckIn;

  String productImage = '';
  String signature = '';
  bool isEdit = false;
  UserData userData = UserData.empty();

  @override
  void onInit() {
    super.onInit();
    var mapArgument = Get.arguments as Map<String, dynamic>;

    mawb = mapArgument[Constant.argumentMBN] as String;
    uploadFrom = UploadFrom.values[(mapArgument[Constant.argumentFrom] as int)];

    if (mapArgument.containsKey(Constant.argumentProductImage)) {
      productImage = mapArgument[Constant.argumentProductImage] as String;
      isEdit = true;
    }
    if (mapArgument.containsKey(Constant.argumentSignature)) {
      signature = mapArgument[Constant.argumentSignature] as String;
      isEdit = true;
    }
  }

  @override
  void onReady() {
    if (signature.isNotEmpty) {
      update();
    }
  }

  Future<void> onUploadImageTap({
    bool isCamera = false,
  }) async {
    productImgFile = await _picker.pickImage(
        imageQuality: 50,
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (productImgFile != null && productImgFile!.path.isNotEmpty) {
      if (kIsWeb) {
        imageByteData = await productImgFile!.readAsBytes();
      }
      uploadImage.value = productImgFile!.path;
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    }
  }

  Future<void> onAddDigitalSignatureTap() async {
    byteData = await Get.toNamed(RouteName.addDigitalSignature) as ByteData;
    if (byteData != null) {
      hasSignature.value = true;
      _signatureUInt = byteData!.buffer.asUint8List();
      update();
    }
  }

  Uint8List? get getSignatureUInt8List => _signatureUInt;

  Future<void> uploadFile() async {
    if ((productImgFile != null &&
        uploadImage.isNotEmpty &&
        hasSignature.value) ||
        isEdit) {
      if (isEdit && productImgFile == null && !hasSignature.value) {
        Get.back();
        return;
      }
      AppComponentBase.instance.showProgressDialog();
      userData = await AppComponentBase.instance.sharedPreference.getUserData();
      Response response;
      if (kIsWeb) {
        response = await AppComponentBase.instance.apiProvider.webUploadFile(
            mawb,
            imageByteData,
            _signatureUInt,
            uploadFrom.index == UploadFrom.pickUpCheckIn.index ||
                uploadFrom.index == UploadFrom.pickUpSubmitToOffice.index,
            userData.userid ?? '0',
            productImgFile != null
                ? File(productImgFile!.path).path
                .split('.')
                .last
                : '');
      } else {
        File? signatureFile;
        if (byteData != null) {
          signatureFile = await writeToFile(byteData!);
        }

        response = await AppComponentBase.instance.apiProvider.uploadFile(
            mawb,
            productImgFile == null ? null : File(productImgFile!.path),
            signatureFile,
            uploadFrom.index == UploadFrom.pickUpCheckIn.index ||
                uploadFrom.index == UploadFrom.pickUpSubmitToOffice.index,
            userData.userid ?? '0');
      }

      if (response.isOk) {
        if (response.body is Map<String, dynamic>) {
          APIStatus apiStatus =
          APIStatus.fromJson(response.body as Map<String, dynamic>);
          openSuccessErrorPage(apiStatus.isOKay, apiStatus.message);
        }
      } else {
        if (response.body is Map<String, dynamic>) {
          Utils.displaySnack(
              message: APIStatus
                  .fromJson(response.body as Map<String, dynamic>)
                  .errorMessage);
        } else {
          openSuccessErrorPage(false, StringConstants.errorSomethingWentWrong2);
        }
      }
      AppComponentBase.instance.hideProgressDialog();
    }
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        '$tempPath/file_01.png'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void openSuccessErrorPage(bool isSuccess, String message) {
    if (kIsWeb) {
      SuccessErrorController controller = SuccessErrorController();
      Future.delayed(const Duration(milliseconds: 600))
          .then((value) => controller.onInit());
      Get.defaultDialog(
        backgroundColor: Colors.white,
        title: '',
        content: AnimatedIconName(
            isSuccess: isSuccess,
            message: message,
            successErrorController: controller,
            uploadFrom: uploadFrom),
      )
          .then((value) => Get.back());
    } else {
      Get.offAndToNamed(RouteName.successError, arguments: {
        Constant.argumentIsSuccess: isSuccess,
        Constant.argumentMessage: message,
        Constant.argumentFrom: uploadFrom.index
      });
    }
  }
}
