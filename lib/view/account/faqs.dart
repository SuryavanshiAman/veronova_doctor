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
    List<dynamic> quick = [
      {
        "item": "How to login App?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "How to book to appointment?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "How to cancel an appointment",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "What if felled to book?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "How to payment?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "What if i felled to book?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "How to pay?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "How to payment?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
      {
        "item": "Payment modes available?",
        "subtitle":
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point"
      },
    ];
    final policies= Provider.of<AllPoliciesViewModel>(context).faqResponse?.data;
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
            data: "FAQs",
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xff1E1E1E),
          ),
          backgroundColor: ColorConstant.containerFillColor,
        ),
        body: ListView.builder(
            itemCount: policies?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
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
                            TextContext(data: "$index."),
                            AppConstant.spaceWidth5,
                            TextContext(
                              data: policies?[index].title.toString()??"jjj",
                              fontWeight: FontWeight.w800,
                            )
                          ],
                        ),
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextContext(
                              data: policies?[index].content.toString()??"jjj",
                              maxLines: 3,
                              fontSize: 13,
                              color: ColorConstant.textColor,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ]),
                  ),
                  Divider(
                    thickness: 5,
                    color: ColorConstant.scaffoldBgColor,
                  )
                ],
              );
            }));
  }
}
