import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_text.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final int? maxLength;
  final TextInputType? inputType;
  final bool initial;
  final String? initialText;
  final bool isObscure;
  final bool alignRight;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Widget? suffixWidget;
  final BoxConstraints? suffixConstraints;
  final bool isEnabled;
  final bool readOnly;
  final bool needAutoValidate;
  final int maxLines;

  const DefaultTextField({
    Key? key,
    required this.hintText,
    this.onSaved,
    this.controller,
    this.labelText,
    this.maxLength,
    this.inputType = TextInputType.text,
    this.initial = false,
    this.initialText,
    this.isObscure = false,
    this.alignRight = false,
    this.onChanged,
    this.validator,
    this.suffixWidget,
    this.suffixConstraints,
    this.isEnabled = true,
    this.readOnly = false,
    this.needAutoValidate = false,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged ?? (value) {},
      textAlign: alignRight ? TextAlign.end : TextAlign.start,
      cursorColor: AppColors.blackColor,
      initialValue: initialText,
      keyboardType: inputType,
      obscureText: isObscure,
      style: AppText.text12,
      maxLines: maxLines,
      autovalidateMode: needAutoValidate ? AutovalidateMode.always : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteSoftColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.blueColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: hintText,
        hintStyle: AppText.text12.copyWith(
          color: AppColors.blackColor,
        ),
        labelText: labelText,
        labelStyle: AppText.text12,
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: suffixWidget,
        suffixIconConstraints: suffixConstraints,
      ),
      maxLength: maxLength,
      validator: validator,
      onSaved: onSaved ?? (value) {},
    );
  }
}
