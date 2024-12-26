import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:flutter/material.dart';
class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: Color(0xff1E1E1E),
            )),
        centerTitle: true,
        title: TextContext(
          data: "Policy",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          shrinkWrap: true,
          children: [

            AppConstant.spaceHeight15,
            TextContext(
                textAlign:TextAlign.justify,
                // letterSpacing: 1,
                fontSize: 13,
                fontWeight: FontWeight.w500,

                color:  Color(0xff353535),
                data:
                "is simply dummy text of the printing and typesetting industry."
                    " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                    "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
                    " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,"
                    " and more recently with desktop publishing software"
                    " like Aldus PageMaker including versions of Lorem Ipsum."),
            TextContext(
                textAlign:TextAlign.justify,
                // letterSpacing: 1,
                fontSize: 13,
                fontWeight: FontWeight.w500,

                color:  Color(0xff353535),
                data:
                "is simply dummy text of the printing and typesetting industry."
                    " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                    "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
                    " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,"
                    " and more recently with desktop publishing software"
                    " like Aldus PageMaker including versions of Lorem Ipsum."),
            TextContext(
                textAlign:TextAlign.justify,
                // letterSpacing: 1,
                fontSize: 13,
                fontWeight: FontWeight.w500,

                color:  Color(0xff353535),
                data:
                "is simply dummy text of the printing and typesetting industry."
                    " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                    "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
                    "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
                    " It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,"
                    " and more recently with desktop publishing software"
                    " like Aldus PageMaker including versions of Lorem Ipsum.")
          ],
        ),
      ),
    );
  }
}
