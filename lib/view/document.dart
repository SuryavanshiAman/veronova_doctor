import 'package:doctor_apk/main.dart';

import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ReqDocsVerification extends StatefulWidget {
  const ReqDocsVerification({super.key});

  @override
  State<ReqDocsVerification> createState() => _ReqDocsVerificationState();
}

class _ReqDocsVerificationState extends State<ReqDocsVerification> {
  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to clear images after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final documentVerifyViewModel =
          Provider.of<DocumentVerifyViewModel>(context, listen: false);

      documentVerifyViewModel.clearImage("idProof");
      documentVerifyViewModel.clearImage("degree");
    });
  }

  @override
  Widget build(BuildContext context) {
    final documentVerifyViewModel =
        Provider.of<DocumentVerifyViewModel>(context);
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leadingWidth: width,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icon/arrow_1.png",
                    scale: 6,
                    color: ColorConstant.whiteColor,
                  )),
              const SizedBox(
                width: 15,
              ),
              const TextContext(
                data: "Documents",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xff13C7EB),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.040),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.020,
            ),
            const TextContext(
              data: "Please Upload a valid document",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff000000),
            ),
            SizedBox(
              height: height * 0.020,
            ),
            SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextContext(
                    data: "Id Proof",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff444343),
                  ),
                  SizedBox(
                    height: height * 0.010,
                  ),
                  GestureDetector(
                    onTap: () {
                      documentVerifyViewModel.pickImage(
                          ImageSource.gallery, context, "idProof");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 0.8, color: const Color(0xff68E5FE)),
                        color: const Color(0xffF1FCFF),
                      ),
                      height: height * 0.055,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.020),
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextContext(
                            data: "Upload valid Id proof",
                            color: Color(0xffBBB7B7),
                            fontWeight: FontWeight.w400,
                            fontFamily: "poppins_reg",
                            fontSize: 12,
                          ),
                          documentVerifyViewModel.idProofImage != null
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : Image.asset(
                                  "assets/icon/reqRep.png",
                                  scale: 5,
                                )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.020,
            ),
            SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextContext(
                    data: "Medical Degree",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff444343),
                  ),
                  SizedBox(
                    height: height * 0.010,
                  ),
                  GestureDetector(
                    onTap: () {
                      documentVerifyViewModel.pickImage(
                          ImageSource.gallery, context, "degree");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 0.8, color: const Color(0xff68E5FE)),
                        color: const Color(0xffF1FCFF),
                      ),
                      height: height * 0.055,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.020),
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextContext(
                            data: "Upload latest medical degree",
                            color: Color(0xffBBB7B7),
                            fontWeight: FontWeight.w400,
                            fontFamily: "poppins_reg",
                            fontSize: 12,
                          ),
                          documentVerifyViewModel.degreeImage != null
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Image.asset(
                                  "assets/icon/reqRep.png",
                                  scale: 5,
                                )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.060,
            ),
            GestureDetector(
              onTap: () {
                if (documentVerifyViewModel.idProofImage == null) {
                  Utils.show("Please enter Id proof", context);
                } else if (documentVerifyViewModel.degreeImage == null) {
                  Utils.show("Please enter Degree", context);
                } else {
                  documentVerifyViewModel.documentVerifyApi(context);
                }
              },
              child: ButtonConst(
                loading: documentVerifyViewModel.loading,
                borderRadius: BorderRadius.circular(8),
                alignment: Alignment.center,
                width: width,
                height: height * 0.055,
                color: const Color(0xff13C7EB),
                label: "Submit",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: height * 0.060,
            ),
            const TextContext(
              data: "Note :",
              fontSize: 17,
              color: Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
            // SizedBox(
            //   height: height * 0.01,
            // ),
            SizedBox(
              width: width * 0.8,
              child: const TextContext(
                data:
                    "Government issued photo ID (Passport/Aadhaar/PAN Card).",
                maxLines: 2,
                color: Color(0xff7C7979),
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
