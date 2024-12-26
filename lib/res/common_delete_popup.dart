import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:flutter/material.dart';


import '../../../main.dart';

class CommonDeletePopup extends StatelessWidget {
  final String title;
  final VoidCallback yes;

  const CommonDeletePopup({
    super.key,
    required this.title,
    required this.yes,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 3,
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        backgroundColor: Colors.transparent,
        // contentPadding: const EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorConstant.whiteColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textWidget(
                  text: title,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  // fontWeight: FontWeight.w500,
                  color:  Color(0xff1E1E1E),
                  fontFamily: "poppins_reg",
                  textAlign: TextAlign.center),
              AppConstant.spaceHeight25,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: yes,
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.04,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorConstant.buttonBlueColor,
                      ),
                      child: TextContext(
                        data: 'Yes',
                        fontSize: AppConstant.fontSizeTwo,
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.04,
                      width: width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorConstant.redColor,
                      ),
                      child: TextContext(
                        data: 'No',
                        fontSize: AppConstant.fontSizeTwo,
                        color: ColorConstant.whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

Widget textWidget({
  required String text,
  double? fontSize,
  String? fontFamily,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
  TextAlign textAlign = TextAlign.start,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    style: TextStyle(
      fontFamily: fontFamily ?? "Poppins_Regular",
      fontSize: fontSize ?? 12,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}
