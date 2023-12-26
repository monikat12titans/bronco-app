import 'package:bronco_trucking/di/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BroncoTextFormField extends StatelessWidget {
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final IconData? rightIcon;
  final String? hintText;
  final String? errorText;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? suffixText;
  final int? maxLength;

  const BroncoTextFormField(
      {Key? key,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.controller,
      this.rightIcon,
      this.hintText,
      this.errorText,
      this.style,
      this.errorStyle,
      this.obscureText = false,
      this.keyboardType,
      this.suffixText,
      this.maxLength})
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
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 20, right: 5, bottom: 1),
          child: TextFormField(
            validator: validator,
            controller: controller,
            maxLength: maxLength,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            keyboardType: keyboardType,
            onSaved: onSaved,
            obscureText: obscureText,
            cursorColor: Colors.black,
            style: style ??
                TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: FontFamily.OpenSans,
                    fontSize: 40.sp),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
                counterText: '',
                suffixText: suffixText,
                suffixStyle: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.OpenSans,
                    color: Colors.grey),
                suffixIcon: rightIcon != null
                    ? Icon(
                        rightIcon,
                        color: const Color(0xff536172),
                      )
                    : const Offstage(),
                errorStyle: errorStyle,
                hintText: hintText,
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
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                errorText: errorText),
          ),
        ),
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains('.') &&
        value.substring(value.indexOf('.') + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == '.') {
      truncated = '0.';
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
    return newValue;
  }
}
