import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/bank_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccount extends StatefulWidget {
  const BankAccount({super.key});

  @override
  State<BankAccount> createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  bool update = false;

  final TextEditingController accountNumberConOne = TextEditingController();
  final TextEditingController accountNumberCon = TextEditingController();
  final TextEditingController accountNameCon = TextEditingController();
  final TextEditingController ifscCode = TextEditingController();
  bool isFieldEnabled = false;

  @override
  void initState() {
    super.initState();
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileApi(context);
    // checkIsAlreadyFilled(context);
  }

  // checkIsAlreadyFilled(context) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final profileViewModel =
  //         Provider.of<ProfileViewModel>(context, listen: false).modelData?.data;
  //     if (profileViewModel!.ifscCode == null &&
  //         profileViewModel.accountName == null &&
  //         profileViewModel.accountNumber == null) {
  //       print("iff case executed");
  //       setState(() {
  //         isFieldEnabled = true;
  //       });
  //     } else {
  //       print("else case executed");
  //
  //       setState(() {
  //         isFieldEnabled = false;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).modelData?.data;
    final bankViewModel = Provider.of<BankViewModel>(context);
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
          data: "Bank Details",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      // body: ListView(
      //   shrinkWrap: true,
      //   children: [
      //     AppConstant.spaceHeight10,
      //     Container(
      //       margin: const EdgeInsets.symmetric(horizontal: 15),
      //       alignment: Alignment.center,
      //       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      //       decoration: BoxDecoration(
      //         border: Border.all(width: 0.5),
      //         borderRadius: BorderRadius.circular(5),
      //       ),
      //
      //       width: width,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Icon(
      //             Icons.info_outline,
      //             color: ColorConstant.textColor,
      //           ),
      //           const TextContext(
      //             textAlign: TextAlign.center,
      //             data:
      //                 'please fil the details carefully. If you want TO change/correct mistakes, Go to "Contact Us" section. we reach you out soon',
      //             fontWeight: FontWeight.w500,
      //             fontSize: 11,
      //               color:  Color(0xff000000),
      //               fontFamily: "poppins_reg"
      //           ),
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           AppConstant.spaceHeight20,
      //           const TextContext(
      //             data: "Enter Account Number",
      //             fontSize: 15,
      //               fontWeight: FontWeight.w500,
      //
      //               color:  Color(0xff353535),
      //               fontFamily: "poppins_reg"
      //           ),
      //           AppConstant.spaceHeight10,
      //           TextfieldContext(
      //             maxLength: 20,
      //             hintStyle: TextStyle(
      //                 color: profileViewModel?.accountNumber == null
      //                     ? Colors.grey
      //                     : Colors.black),
      //             keyboardType: TextInputType.number,
      //             controller: accountNumberConOne,
      //             intBorder: true,
      //             filled: true,
      //             fillColor: ColorConstant.whiteColor,
      //             enabled: isFieldEnabled,
      //             hintText:
      //                 profileViewModel!.accountNumber ?? "000000000000000",
      //           ),
      //           AppConstant.spaceHeight15,
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       thickness: 5,
      //       color: ColorConstant.scaffoldBgColor,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           TextContext(
      //             data: "Re-Enter Account Number",
      //               fontSize: 15,
      //               fontWeight: FontWeight.w500,
      //
      //               color:  Color(0xff353535),
      //               fontFamily: "poppins_reg"
      //           ),
      //           AppConstant.spaceHeight10,
      //           TextfieldContext(
      //             maxLength: 20,
      //             hintStyle: TextStyle(
      //                 color: profileViewModel.accountNumber == null
      //                     ? Colors.grey
      //                     : Colors.black),
      //             keyboardType: TextInputType.number,
      //             controller: accountNumberCon,
      //             intBorder: false,
      //             filled: true,
      //             fillColor: ColorConstant.whiteColor,
      //             enabled: isFieldEnabled,
      //             hintText: profileViewModel.accountNumber ?? "000000000000000",
      //           ),
      //           AppConstant.spaceHeight15,
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       thickness: 5,
      //       color: ColorConstant.scaffoldBgColor,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const TextContext(
      //             data: "Enter Account Holder Name",
      //               fontSize: 15,
      //               fontWeight: FontWeight.w500,
      //
      //               color:  Color(0xff353535),
      //               fontFamily: "poppins_reg"
      //           ),
      //           AppConstant.spaceHeight10,
      //           TextfieldContext(
      //             hintStyle: TextStyle(
      //                 color: profileViewModel.accountName == null
      //                     ? Colors.grey
      //                     : Colors.black),
      //             controller: accountNameCon,
      //             intBorder: false,
      //             filled: true,
      //             fillColor: ColorConstant.whiteColor,
      //             enabled: isFieldEnabled,
      //             hintText: profileViewModel.accountName ?? "Enter Account Holder Name ",
      //           ),
      //           AppConstant.spaceHeight15,
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       thickness: 5,
      //       color: ColorConstant.scaffoldBgColor,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const TextContext(
      //             data: "Enter IFSC CODE",
      //               fontSize: 15,
      //               fontWeight: FontWeight.w500,
      //
      //               color:  Color(0xff353535),
      //               fontFamily: "poppins_reg"
      //           ),
      //           AppConstant.spaceHeight10,
      //           TextfieldContext(
      //             hintStyle: TextStyle(
      //                 color: profileViewModel.ifscCode == null
      //                     ? Colors.grey
      //                     : Colors.black),
      //             controller: ifscCode,
      //             intBorder: false,
      //             filled: true,
      //             fillColor: ColorConstant.whiteColor,
      //             enabled: isFieldEnabled,
      //             hintText: profileViewModel.ifscCode ?? "Enter your ifsc Code",
      //           ),
      //           AppConstant.spaceHeight15,
      //         ],
      //       ),
      //     ),
      //     Divider(
      //       thickness: 5,
      //       color: ColorConstant.scaffoldBgColor,
      //     ),
      //     if (isFieldEnabled)
      //       GestureDetector(
      //         onTap: () {
      //           if (!isFieldEnabled) {
      //             return;
      //           }
      //           if (accountNumberCon.text.isEmpty) {
      //             Utils.show("Please enter Account Number", context);
      //           }else if (accountNumberCon.text != accountNumberConOne.text) {
      //             Utils.show("Please Enter Correct Account Number", context);
      //           }
      //           else if (accountNameCon.text.isEmpty) {
      //             Utils.show("Please Enter Your Name", context);
      //           } else if (ifscCode.text.isEmpty) {
      //             Utils.show("Please Enter ifscCode", context);
      //           } else {
      //             bankViewModel.bankDetailsApi(accountNameCon.text,
      //                 accountNumberConOne.text, ifscCode.text, context);
      //           }
      //         },
      //         child: profileViewModel.ifscCode != null &&
      //                 profileViewModel.accountName != null &&
      //                 profileViewModel.accountNumber != null
      //             ? Container()
      //             : ButtonConst(
      //                 alignment: Alignment.center,
      //                 borderRadius: BorderRadius.circular(5),
      //                 padding: const EdgeInsets.symmetric(
      //                   vertical: 10,
      //                 ),
      //                 margin: const EdgeInsets.symmetric(horizontal: 15),
      //                 color: ColorConstant.primaryColor,
      //                 label: "Submit",
      //             fontWeight: FontWeight.w600,
      //             fontSize: 18,
      //         )
      //       ),
      //   ],
      // ),
    );
  }
}
