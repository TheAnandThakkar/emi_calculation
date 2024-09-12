import 'package:flutter/material.dart';

import '../../utils/app_commons/app_colors.dart';
import '../../utils/app_commons/app_strings.dart';

class TextFieldComponent extends StatelessWidget {
  // final TextFieldType? textFieldType;
  final TextEditingController? textEditingController;
  final TextCapitalization capitalization;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscure;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? style;
  final String? hint;
  final String? label;
  final bool enabled;
  final Function(String s)? onChange;
  final Function(String s)? onSubmit;
  final Widget? iconSuffix;
  final int? minLength;
  final FocusNode? focusNode;
  final bool? isExpand;
  final VoidCallback? onTap;
  final bool? readOnly;

  const TextFieldComponent({
    Key? key,
    // this.textFieldType = TextFieldType.none,
    this.minLength,
    this.textEditingController,
    this.capitalization = TextCapitalization.none,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscure = false,
    this.maxLength,
    this.maxLines,
    this.style,
    this.hint,
    this.label,
    this.enabled = true,
    this.onChange,
    this.onSubmit,
    this.iconSuffix,
    this.focusNode,
    this.isExpand,
    this.onTap,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<TextInputFormatter> arrInputFormatter = getListOfFormatter(textFieldType!, maxLength ?? getMaxLength(textFieldType!));
    return TextField(
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor,
      ),
      controller: textEditingController,
      enabled: enabled,
      focusNode: focusNode,
      expands: isExpand ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.lightGreyColor),
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.lightGreyColor),
        counterText: '',
        suffixIcon: iconSuffix,
        disabledBorder: InputBorder.none,
        border: InputBorder.none,
        // contentPadding: EdgeInsets.all(
        //   MediaQuery.of(context).size.longestSide * 0.02,
        // ),
        isDense: true,
        // enabledBorder: setEnabledBorder(),
        // disabledBorder: setDisabledBorder(),
        // focusedBorder: setFocusedBorder(),
      ),
      textCapitalization: capitalization,
      // style: style ?? IPOTextStyles.textFieldTextStyle(),
      textAlignVertical: TextAlignVertical.center,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      obscureText: obscure,
      // inputFormatters: arrInputFormatter,
      maxLength: maxLength,
      maxLines: maxLines,
      onChanged: (v) => onChange == null ? null : onChange!(v),
      onSubmitted: (v) => onSubmit == null ? null : onSubmit!(v),
      onTap: () => onTap,
    );
  }
}

Widget buildLabelForTextField({
  required BuildContext context,
  required String text,
}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          // style: IPOTextStyles.textFieldTitleTextStyle(),
        ),
        const TextSpan(
          text: " ${AppStrings.mandatoryAsterisk}",
          style: TextStyle(color: Colors.red),
        )
      ],
    ),
  );
}

InputBorder setEnabledBorder() {
  return const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGreyColor));
}

InputBorder setDisabledBorder() {
  return const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGreyColor));
}

InputBorder setFocusedBorder() {
  return const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.lightGreyColor));
}
