import 'package:flutter/material.dart';
class TextContext extends StatelessWidget {
  const TextContext({super.key, this.fontWeight, required this.data, this.fontSize, this.color, this.maxLines, this.textAlign, this.wordSpacing, this.letterSpacing, this.decoration, this.fontFamily, this.overflow});
  final FontWeight? fontWeight;
  final String data;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? wordSpacing;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final String? fontFamily;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
 data,
      textAlign:textAlign??TextAlign.start,
      maxLines:maxLines??null,
      style: TextStyle(
        overflow: overflow,
        fontWeight:fontWeight??FontWeight.w600,
        fontSize: fontSize??15,
       color: color??Colors.black,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        decoration: decoration,
        fontFamily:fontFamily?? "poppins_reg",

      )
    );
  }
}
