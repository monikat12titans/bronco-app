import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BroncoSendMessageTextFormField extends StatelessWidget {
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? submitIcon;

  const BroncoSendMessageTextFormField(
      {Key? key,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.controller,
      this.submitIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.07),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, left: 20, right: 5, bottom: 1),
                child: TextFormField(
                  validator: validator,
                  controller: controller,
                  maxLength: 150,
                  onEditingComplete: onEditingComplete,
                  onFieldSubmitted: onFieldSubmitted,
                  onSaved: onSaved,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: FontFamily.OpenSans,
                      fontSize: 40.sp),
                  inputFormatters: inputFormatters,
                  decoration: InputDecoration(
                      counterText: '',
                      hintText: StringConstants.hintEnterMessage,
                      hintStyle: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.OpenSans,
                          color: Colors.grey),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
              ),
            ),
            submitIcon ??
                const Icon(
                  Icons.send,
                  size: 15,
                  color: Colors.white,
                )
          ],
        ),
      ),
    );
  }
}
