import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:flutter/material.dart';
//
// class TextfieldContext extends StatelessWidget {
//   const TextfieldContext({
//     super.key,
//     this.keyboardType,
//     this.focusNode,
//     this.maxLength,
//     this.decoration,
//     this.style,
//     this.maxLines,
//     this.prefixIcon,
//     this.hintText,
//     this.suffixIcon,
//     this.prefixText,
//     this.suffixText,
//     required this.intBorder,
//     this.disabledBorder,
//     this.hintStyle,
//     required this.filled,
//     required this.fillColor,
//     required this.enabled,
//     this.controller,
//     this.contentPadding,
//
//   });
//   final TextInputType? keyboardType;
//   final FocusNode? focusNode;
//   final int? maxLength;
//   final InputDecoration? decoration;
//   final bool readOnly = false;
//   final TextStyle? style;
//   final int? maxLines;
//   final Widget? prefixIcon;
//   final String? prefixText;
//   final String? hintText;
//   final Widget? suffixIcon;
//   final String? suffixText;
//   final bool intBorder;
//   final InputBorder? disabledBorder;
//   final TextStyle? hintStyle;
//   final bool filled;
//   final TextEditingController? controller;
//   final Color fillColor;
//   final bool enabled;
//   final double? contentPadding;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height * 0.06,
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//             counterText: "",
//             enabled: enabled,
//             filled: filled,
//             fillColor: fillColor,
//             contentPadding:
//                 EdgeInsets.only(top: height * 0.01, left: width * 0.05),
//             hintText: hintText,
//             hintStyle:hintStyle?? TextStyle(
//               color: Color(0xffBBB7B7),
//               fontWeight: FontWeight.w400,
//             ),
//             suffixText: suffixText,
//             suffixIcon: suffixIcon,
//             disabledBorder: disabledBorder,
//             prefixIcon: prefixIcon,
//             border: OutlineInputBorder(
//               borderSide: intBorder == intBorder
//                   ? const BorderSide(width: 1, color: Color(0xffBBB7B7))
//                   : BorderSide.none,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: intBorder == intBorder
//                     ? const BorderSide(width: 1, color: Color(0xffBBB7B7))
//                     : BorderSide.none),
//             focusedBorder: intBorder == intBorder
//                 ? const OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xff13C7EB)))
//                 : const OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xffD1CDCD)))),
//         readOnly: readOnly,
//         style: style,
//         maxLines: maxLines,
//       ),
//     );
//   }
// }
class TextfieldContext extends StatelessWidget {
  const TextfieldContext({
    super.key,
    this.keyboardType,
    this.focusNode,
    this.maxLength,
    this.decoration,
    this.style,
    this.maxLines,
    this.prefixIcon,
    this.hintText,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    required this.intBorder,
    this.disabledBorder,
    this.hintStyle,
    required this.filled,
    required this.fillColor,
    required this.enabled,
    this.controller,
    this.contentPadding,
  });

  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final int? maxLength;
  final InputDecoration? decoration;
  final bool readOnly = false;
  final TextStyle? style;
  final int? maxLines;
  final Widget? prefixIcon;
  final String? prefixText;
  final String? hintText;
  final Widget? suffixIcon;
  final String? suffixText;
  final bool intBorder;
  final InputBorder? disabledBorder;
  final TextStyle? hintStyle;
  final bool filled;
  final TextEditingController? controller;
  final Color fillColor;
  final bool enabled;
  final double? contentPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.06,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
          counterText: "",
          enabled: enabled,
          filled: filled,
          fillColor: fillColor,
          contentPadding: EdgeInsets.only(top: height * 0.01, left: width * 0.05),
          hintText: hintText,
          hintStyle: hintStyle ?? const TextStyle(
            color: Color(0xffBBB7B7),
            fontWeight: FontWeight.w400,
            fontFamily: 'poppins_reg',
            fontSize: 15// Set the hint font family here
          ),
          suffixText: suffixText,
          suffixIcon: suffixIcon,
          disabledBorder: disabledBorder??OutlineInputBorder(
            borderSide: intBorder == intBorder
                ? const BorderSide(width: 0.2, color: Color(0xffBBB7B7))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderSide: intBorder == intBorder
                ? const BorderSide(width: 1, color: Color(0xffBBB7B7))
                : BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: intBorder == intBorder
                  ? const BorderSide(width: 1, color: Color(0xffBBB7B7))
                  : BorderSide.none),
          focusedBorder: intBorder == intBorder
              ? const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff13C7EB)))
              : const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD1CDCD))),
        ),
        readOnly: readOnly,
        style: style ??
            const TextStyle(
              fontFamily: 'poppins_reg', // Set the main text font family here
            ),
        maxLines: maxLines,
      ),
    );
  }
}
