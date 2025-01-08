import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/auth_view_model.dart';
import 'package:doctor_apk/view_model/state_city_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _selectedGender = "Select";
  final List<String> _gender = ["Select", "Male", "Female", "Others"];
  bool itemShow = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (arguments != null) {
        mobileCon.text = arguments['phone'] ?? '';
      } else {
        // Handle the case when no arguments were passed
        print('No arguments found');
      }
    });
    final stateCityViewModel =
        Provider.of<StateCityViewModel>(context, listen: false);
    stateCityViewModel.getStateApi();
    stateCityViewModel.getDistrictApi("1");
  }

  // final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  final TextEditingController mobileCon = TextEditingController();
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController registerNumberCon = TextEditingController();
  final TextEditingController registerYearCon = TextEditingController();
  final TextEditingController medicalCouncilNameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        leadingWidth: width,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icon/arrow_1.png",
                    scale: 6,
                    color: ColorConstant.whiteColor,
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: width,
                child: TextContext(
                  data: "Sign-up as Doctor",
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.whiteColor,
                  fontSize: 21,
                  fontFamily: "poppins_reg",
                ),
              ),
              SizedBox(
                width: width,
                child: TextContext(
                  data: "Fill some basic details and Create new account",
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "poppins_reg",
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: ColorConstant.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 50),
              decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    const TextContext(
                      data: "Phone Number *",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff444343),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldContext(
                      maxLength: 10,
                      controller: mobileCon,
                      keyboardType: TextInputType.number,
                      intBorder: true,
                      enabled: true,
                      filled: true,
                      fillColor: ColorConstant.whiteColor,
                      hintText: "enter your phone number",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextContext(
                      data: "Name *",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff444343),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldContext(
                      controller: nameCon,
                      enabled: true,
                      filled: true,
                      fillColor: ColorConstant.whiteColor,
                      intBorder: true,
                      keyboardType: TextInputType.streetAddress,
                      hintText: "Enter your name",
                      prefixIcon: Container(
                          alignment: Alignment.center,
                          width: width * 0.01,
                          child: const TextContext(
                            data: "Dr .",
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Row(
                      children: [
                        TextContext(
                          data: "Email * ",
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color(0xff444343),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldContext(
                      controller: emailCon,
                      enabled: true,
                      filled: true,
                      fillColor: ColorConstant.whiteColor,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter your email",
                      intBorder: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextContext(
                      data: "Gender *",
                      fontWeight: FontWeight.w500,
                      color: Color(0xff444343),
                      fontSize: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 5, left: 15),
                      width: width,
                      height: height * 0.058,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xffD1CDCD))),
                      child: DropdownButton(
                        icon: itemShow == false
                            ? const Icon(
                                Icons.keyboard_arrow_up,
                                color: Color(0xffBBB7B7),
                              )
                            : const Icon(Icons.keyboard_arrow_down_outlined,
                                color: Color(0xffBBB7B7)),
                        iconSize: 36,
                        isExpanded: true,
                        underline: const SizedBox(),
                        style: TextStyle(
                          color: ColorConstant.blackColor,
                          fontSize: 17,
                        ),
                        value: _selectedGender,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = (newValue)!;
                            itemShow = !itemShow;
                          });
                        },
                        items: _gender.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(
                              valueItem,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // stateDistrict(),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextContext(
                      data: "Registration Number *",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff444343),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldContext(
                      controller: registerNumberCon,
                      enabled: true,
                      filled: true,
                      fillColor: ColorConstant.whiteColor,
                      keyboardType: TextInputType.number,
                      hintText: "Enter your registration number",
                      intBorder: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextContext(
                      data: "Registration Year *",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff444343),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: width,
                        height: height * 0.055,
                        child: TextfieldContext(
                          maxLength: 4,
                          controller: registerYearCon,
                          enabled: true,
                          filled: true,
                          fillColor: ColorConstant.whiteColor,
                          keyboardType: TextInputType.number,
                          hintText: "Enter your registration Year",
                          intBorder: true,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const TextContext(
                      data: "Medical Council Name *",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xff444343),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextfieldContext(
                      controller: medicalCouncilNameCon,
                      enabled: true,
                      filled: true,
                      fillColor: ColorConstant.whiteColor,
                      keyboardType: TextInputType.streetAddress,
                      hintText: "Enter your medical council name",
                      intBorder: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: InkWell(
        onTap: () {
          if (mobileCon.text.isEmpty || mobileCon.text.length <10) {
            Utils.show("Please enter your Phone Number", context);
          } else if (nameCon.text.isEmpty) {
            Utils.show("Please Enter Your Name", context);
          }  else if (emailCon.text.isEmpty) {
            Utils.show("Please Enter Your Email", context);
          }
          else if (_selectedGender=="Select") {
            Utils.show("Please select your gender", context);
          } else if (registerNumberCon.text.isEmpty) {
            Utils.show("Please Enter Register Number", context);
          } else if (registerYearCon.text.isEmpty) {
            Utils.show("Please Enter Register Year", context);
          } else if (medicalCouncilNameCon.text.isEmpty) {
            Utils.show("Please Enter medicalCouncil Name", context);
          } else {
            authViewModel.registerApi(
                mobileCon.text,
                nameCon.text,
                emailCon.text,
                registerNumberCon.text,
                registerYearCon.text,
                medicalCouncilNameCon.text,
                _selectedGender.toString(),
                // selectedState, selectedDistrict,
                context);
          }
        },
        child: ButtonConst(
          loading: authViewModel.loadingRegister,
          color: ColorConstant.primaryColor,
          alignment: Alignment.center,
          width: width,
          height: 50,
          label: "Continue",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  dynamic selectedState;
  dynamic selectedDistrict;
  Widget stateDistrict() {
    final stateCityViewModel = Provider.of<StateCityViewModel>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextContext(
              data: "State *",
              fontWeight: FontWeight.w500,
              color: Color(0xff444343),
              fontSize: 15,
            ),
            AppConstant.spaceHeight10,
            Container(
              padding: const EdgeInsets.only(right: 5, left: 15),
              width: width / 2.3,
              height: height * 0.058,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffD1CDCD))),
              child: DropdownButton(
                icon: itemShow == false
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xffBBB7B7),
                      )
                    : const Icon(Icons.keyboard_arrow_down_outlined,
                        color: Color(0xffBBB7B7)),
                iconSize: 36,
                isExpanded: true,
                underline: const SizedBox(),
                style: TextStyle(
                  color: ColorConstant.blackColor,
                  fontSize: 17,
                ),
                value: selectedState,
                onChanged: (newValue) {
                  print("jcfkjb $newValue");
                  setState(() {
                    selectedState = (newValue)!;
                    selectedDistrict=null;
                  });
                  final selectedStateId = stateCityViewModel
                      .stateListModel!.data!
                      .firstWhere((e) => e.name.toString() == (newValue))
                      .id
                      .toString();
                  stateCityViewModel.getDistrictApi(selectedStateId);
                },
                items:stateCityViewModel.stateListModel != null? stateCityViewModel.stateListModel!.data!
                    .map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem.name,
                    child: Text(
                      valueItem.name!,
                    ),
                  );
                }).toList():[],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextContext(
              data: "District *",
              fontWeight: FontWeight.w500,
              color: Color(0xff444343),
              fontSize: 15,
            ),
            AppConstant.spaceHeight10,
            Container(
              padding: const EdgeInsets.only(right: 5, left: 15),
              width: width / 2.3,
              height: height * 0.058,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffD1CDCD))),
              child: DropdownButton(
                icon: itemShow == false
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xffBBB7B7),
                      )
                    : const Icon(Icons.keyboard_arrow_down_outlined,
                        color: Color(0xffBBB7B7)),
                iconSize: 36,
                isExpanded: true,
                underline: const SizedBox(),
                style: TextStyle(
                  color: ColorConstant.blackColor,
                  fontSize: 17,
                ),
                value: selectedDistrict,
                onChanged: (newValue) {
                  setState(() {
                    selectedDistrict = (newValue)!;
                  });
                },
                items:stateCityViewModel.districtListModel != null? stateCityViewModel.districtListModel!.data!
                    .map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem.city,
                    child: Text(
                      valueItem.city!,
                    ),
                  );
                }).toList():[],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
