import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/view_model/all_policies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Faqs extends StatefulWidget {
  const Faqs({super.key});

  @override
  State<Faqs> createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllPoliciesViewModel>(context,listen: false).allPoliciesApi(context,"2");
  }
  @override
  Widget build(BuildContext context) {
    final faqResponse= Provider.of<AllPoliciesViewModel>(context).faqResponse;
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
                color: const Color(0xff1E1E1E),
              )),
          centerTitle: true,
          title: const TextContext(
            data: "FAQs",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xff1E1E1E),
          ),
          backgroundColor: ColorConstant.containerFillColor,
        ),
        body:faqResponse!=null||faqResponse!.isNotEmpty?
        ListView.builder(
          itemCount: faqResponse.length ?? 0, // Get length from faqResponse
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final faq = faqResponse[index]; // Get the FAQ at the current index
            return Column(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    splashColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    minTileHeight: 10,
                    title: Row(
                      children: [
                        TextContext(data: "${index + 1}. "), // Display index + 1
                        AppConstant.spaceWidth5,
                        SizedBox(
                          width: width*0.7,
                          child: TextContext(
                            data: faq.title ?? "No title", // Display the title
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextContext(
                          data: faq.content ?? "No content available", // Display the content
                          // maxLines: 3,
                          fontSize: 13,
                          color: ColorConstant.textColor,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 5,
                  color: ColorConstant.scaffoldBgColor,
                ),
              ],
            );
          },
        ):const Center(child: CircularProgressIndicator())

    );
  }
}
