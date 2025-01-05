import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/all_policies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllPoliciesViewModel>(context,listen: false).allPoliciesApi(context,"4");
  }
  @override
  Widget build(BuildContext context) {
    final policies= Provider.of<AllPoliciesViewModel>(context).policiesResponse;
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar:  AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: const Color(0xff1E1E1E),
            )),
        centerTitle: true,
        title: const TextContext(
          data: "Terms & Conditions",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body:policies?.data.toString()!=null||policies!.data.toString().isNotEmpty? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HtmlWidget(
                policies?.data.toString()??""
            ),
          )):const Center(child: CircularProgressIndicator())
    );
  }
}
