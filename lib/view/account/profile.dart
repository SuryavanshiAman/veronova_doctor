import 'dart:convert';

import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/button_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/textField_context.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:doctor_apk/view_model/update_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/doc_cat_model.dart';
import '../../view_model/state_city_view_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final name = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final qualification = TextEditingController();
  final experience = TextEditingController();
  final fees = TextEditingController();
  final specialist = TextEditingController();
  final about = TextEditingController();
  String dropdownValue = 'Heart';
  bool _isTextFieldEnabled = false;
  String? selectedItemId;
  @override
  void initState() {
    super.initState();
    final stateCityViewModel =
    Provider.of<StateCityViewModel>(context, listen: false);
    stateCityViewModel.getStateApi();
    stateCityViewModel.getDistrictApi("1");
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileApi(context);
    profileViewModel.doctorCatApi(context);
    if (profileViewModel.modelData != null &&
        profileViewModel.modelData!.data != null &&
        profileViewModel.modelData!.data!.specialties != null) {
      List<dynamic> listId =
          jsonDecode(profileViewModel.modelData!.data!.specialties);

      for (var resId in listId) {
        final resName = profileViewModel.doctorDepartmentModelData!.data!
            .where((e) => e.id == resId);

        selectedNotRemoveVal.addAll(resName);
      }
      // selectedDistrict=  Provider.of<ProfileViewModel>(context, listen: false).modelData?.data!.city??"Select Cty";
      // selectedState=  Provider.of<ProfileViewModel>(context, listen: false).modelData?.data!.state??"Select District";
    }
  }

  List<Data> selectedValues = [];
  List<Data> selectedNotRemoveVal = [];

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).modelData?.data;

    final updateProfileViewModel = Provider.of<UpdateProfileViewModel>(context);
    final documentVerifyViewModel =
        Provider.of<DocumentVerifyViewModel>(context);
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      bottomSheet: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isTextFieldEnabled = !_isTextFieldEnabled;
            });
            if (!_isTextFieldEnabled) {
              final selectedSpecialitiesIds =
                  selectedValues.map((e) => e.id).toList();
              updateProfileViewModel.updateProfileApi(
                name.text,
                email.text,
                address.text,
                qualification.text,
                experience.text,
                fees.text,
                selectedSpecialitiesIds,
                about.text,
                selectedDistrict,
                selectedState,
                context,
              );
            }
          },
          child: ButtonConst(
            loading: updateProfileViewModel.loading,
            height: height * 0.065,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            label: !_isTextFieldEnabled ? 'Edit Profile' : "Update",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
        title: TextContext(
          data: _isTextFieldEnabled ? "Edit Account" : "View Account",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: const Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          AppConstant.spaceHeight5,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                            backgroundColor: ColorConstant.whiteColor,
                            radius: 10,
                            child: Icon(
                              (Icons.info_outline),
                              color: ColorConstant.textColor,
                            )),
                      ),
                      AppConstant.spaceHeight5,
                      const TextContext(
                        textAlign: TextAlign.center,
                        data:
                            'if you want to change/ correct mistakes , Go to "contact Us section. We will reach you out soon"',
                        maxLines: 2,
                        fontWeight: FontWeight.w100,
                        fontSize: 11,
                      ),
                    ],
                  ),
                ),
                AppConstant.spaceHeight10,
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        child: Consumer<DocumentVerifyViewModel>(
                          builder: (context, viewModel, child) {
                            return CircleAvatar(
                              radius: 60,
                              backgroundImage: viewModel.idProfileImage != null
                                  ? MemoryImage(
                                      base64Decode(viewModel.idProfileImage!))
                                  : NetworkImage(profileViewModel?.profile.toString()??"data:image/png;base64,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")
                                      as ImageProvider, // Optional: Add an icon if no image
                              backgroundColor: Colors.transparent,
                              child: viewModel.idProfileImage == null
                                  ? null
                                  : null,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: -height * 0.01,
                        right: -width * 0.01,
                        child: _isTextFieldEnabled
                            ? GestureDetector(
                                onTap: () {
                                  if (_isTextFieldEnabled) {
                                    documentVerifyViewModel.pickImage(
                                        ImageSource.gallery,
                                        context,
                                        "profile");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.029,
                                  width: width * 0.12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        width: 0.5,
                                        color: ColorConstant.primaryColor),
                                    color: ColorConstant.whiteColor,
                                  ),
                                  child: TextContext(
                                    data: 'Edit',
                                    fontSize: AppConstant.fontSizeZero,
                                    color: ColorConstant.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                ),
                AppConstant.spaceHeight25,
                TextfieldContext(
                  intBorder: false,
                  keyboardType: TextInputType.streetAddress,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  enabled: _isTextFieldEnabled,
                  hintText: profileViewModel?.name ?? 'Enter Your Name',
                  hintStyle: TextStyle(
                      color: profileViewModel?.name == null
                          ? Colors.grey
                          : Colors.black),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: ColorConstant.primaryColor,
                  ),
                  controller: name,
                ),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  enabled: false,
                  hintText: profileViewModel?.phone.toString()??"",
                  keyboardType: TextInputType.number,
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.smartphone,
                    color: ColorConstant.primaryColor,
                  ),
                  controller: number,
                ),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.email == null
                          ? Colors.grey
                          : Colors.black),
                  controller: email,
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  enabled: _isTextFieldEnabled,
                  hintText: profileViewModel?.email ?? 'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email,
                    color: ColorConstant.primaryColor,
                  ),
                ),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.address == null
                          ? Colors.grey
                          : Colors.black),
                  keyboardType: TextInputType.streetAddress,
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  hintText:
                      profileViewModel?.address ?? 'Enter Your Clinic Address',
                  prefixIcon: Icon(
                    Icons.apartment,
                    color: ColorConstant.primaryColor,
                  ),
                  enabled: _isTextFieldEnabled,
                  controller: address,
                ),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.city == null
                          ? Colors.grey
                          : Colors.black),
                  keyboardType: TextInputType.streetAddress,
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  hintText: profileViewModel?.city ?? 'Enter Your District',
                  prefixIcon: Icon(
                    Icons.apartment,
                    color: ColorConstant.primaryColor,
                  ),
                  enabled: false,
                  // controller: address,
                ),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.state == null
                          ? Colors.grey
                          : Colors.black),
                  keyboardType: TextInputType.streetAddress,
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  hintText: profileViewModel?.state ?? 'Enter Your State',
                  prefixIcon: Icon(
                    Icons.apartment,
                    color: ColorConstant.primaryColor,
                  ),
                  enabled: false,
                  // controller: address,
                ),
              ],
            ),
          ),
          AppConstant.spaceHeight10,
          Divider(
            thickness: 3,
            color: ColorConstant.scaffoldBgColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContext(
                    data: "Qualification",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff000000),
                    fontFamily: "poppins_reg"),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.qualification == null
                          ? Colors.grey
                          : Colors.black),
                  keyboardType: TextInputType.streetAddress,
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  hintText: profileViewModel?.qualification ??
                      'Enter Your Qualification',
                  enabled: _isTextFieldEnabled,
                  controller: qualification,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 3,
            color: ColorConstant.scaffoldBgColor,
          ),
          AppConstant.spaceHeight10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextContext(
                    data: "Experience",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff000000),
                    fontFamily: "poppins_reg"),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.exp == null
                          ? Colors.grey
                          : Colors.black),
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  filled: true,
                  hintText: profileViewModel?.exp ?? 'Enter Yor Experience ',
                  keyboardType: TextInputType.streetAddress,
                  enabled: _isTextFieldEnabled,
                  controller: experience,
                ),
                AppConstant.spaceHeight15,
                const TextContext(
                    data: "Fees",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff000000),
                    fontFamily: "poppins_reg"),
                AppConstant.spaceHeight5,
                TextfieldContext(
                  hintStyle: TextStyle(
                      color: profileViewModel?.fees == null
                          ? Colors.grey
                          : Colors.black),
                  intBorder: false,
                  fillColor: ColorConstant.whiteColor,
                  keyboardType: TextInputType.number,
                  filled: true,
                  enabled: _isTextFieldEnabled,
                  hintText: profileViewModel?.fees == null
                      ? "0.0"
                      : profileViewModel?.fees.toString(),
                  prefixIcon: Container(
                      margin: const EdgeInsets.only(top: 12, left: 20),
                      child: const TextContext(data: "₹")),
                  controller: fees,
                ),
              ],
            ),
          ),
          AppConstant.spaceHeight10,
          Divider(
            thickness: 3,
            color: ColorConstant.scaffoldBgColor,
          ),
          AppConstant.spaceHeight5,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextContext(
                        data: "Specialities",
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        fontFamily: "poppins_reg"),
                    if (_isTextFieldEnabled)
                      IconButton(
                        onPressed: () => _showSelectionBottomSheet(context),
                        icon:
                            Icon(Icons.add, color: ColorConstant.primaryColor),
                      ),
                  ],
                ),
                AppConstant.spaceHeight15,
                if (selectedValues.isNotEmpty)
                  Container(
                    width: width,
                    height: selectedValues.isEmpty ? height * 0.062 : null,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorConstant.textColor, width: 0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: width / 1.2,
                          child: selectedValues.isEmpty
                              ? TextContext(
                                  data: "Enter your Specialities",
                                  color: ColorConstant.textColor,
                                  fontWeight: FontWeight.w500,
                                )
                              : Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children:
                                      List.generate(selectedValues.length, (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: .5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextContext(
                                            data: selectedValues[i].name ?? "",
                                            fontSize: AppConstant.fontSizeTwo,
                                          ),
                                          AppConstant.spaceWidth5,
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectedValues.remove(
                                                      selectedValues[i]);
                                                });
                                              },
                                              child: Icon(
                                                Icons.cancel_outlined,
                                                color: ColorConstant.textColor,
                                                size: 16,
                                              ))
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: width,
                    height:
                        selectedNotRemoveVal.isEmpty ? height * 0.062 : null,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorConstant.textColor, width: 0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: width / 1.2,
                          child: selectedNotRemoveVal.isEmpty
                              ? TextContext(
                                  data: "Enter your Specialities",
                                  color: ColorConstant.textColor,
                                  fontWeight: FontWeight.w500,
                                )
                              : Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: List.generate(
                                      selectedNotRemoveVal.length, (i) {
                                    return Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: .5),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextContext(
                                            // data: profileViewModel.specialties,
                                            data:
                                                selectedNotRemoveVal[i].name ??
                                                    "",
                                            fontSize: AppConstant.fontSizeTwo,
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                        ),
                      ],
                    ),
                  ),
                AppConstant.spaceHeight15,
                TextContext(
                    data: "About",
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontFamily: "poppins_reg"),
                AppConstant.spaceHeight15,
                SizedBox(
                  width: width,
                  height: height * 0.1,
                  child: TextfieldContext(
                    hintStyle: TextStyle(
                        color: profileViewModel?.about == null
                            ? Colors.grey
                            : Colors.black),
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 5,
                    intBorder: false,
                    fillColor: ColorConstant.whiteColor,
                    filled: true,
                    hintText: profileViewModel?.about ?? 'Enter Your About',
                    enabled: _isTextFieldEnabled,
                    controller: about,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  dynamic selectedState;
  dynamic selectedDistrict;
  // Widget stateDistrict() {
  //   final stateCityViewModel = Provider.of<StateCityViewModel>(context);
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const TextContext(
  //         data: "State *",
  //         fontWeight: FontWeight.w500,
  //         color: Color(0xff444343),
  //         fontSize: 15,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.only(right: 5, left: 15),
  //         // width: width / 2.3,
  //         height: height * 0.058,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             border: Border.all(width: 1, color: const Color(0xffBBB7B7))),
  //         child: DropdownButton(
  //           icon:  const Icon(Icons.keyboard_arrow_down_outlined,
  //               color: Color(0xffBBB7B7)),
  //           iconSize: 36,
  //           isExpanded: true,
  //           underline: const SizedBox(),
  //           style: TextStyle(
  //             color: ColorConstant.blackColor,
  //             fontSize: 17,
  //           ),
  //           value: selectedState,
  //           onChanged: (newValue) {
  //             setState(() {
  //               selectedState = (newValue)!;
  //               selectedDistrict=null;
  //             });
  //             final selectedStateId = stateCityViewModel
  //                 .stateListModel!.data!
  //                 .firstWhere((e) => e.name.toString() == (newValue))
  //                 .id
  //                 .toString();
  //             stateCityViewModel.getDistrictApi(selectedStateId);
  //           },
  //           items:stateCityViewModel.stateListModel != null? stateCityViewModel.stateListModel!.data!
  //               .map((valueItem) {
  //             return DropdownMenuItem(
  //               value: valueItem.name,
  //               child: Text(
  //                 valueItem.name!,
  //               ),
  //             );
  //           }).toList():[],
  //         ),
  //       ),
  //       AppConstant.spaceHeight10,
  //       const TextContext(
  //         data: "District *",
  //         fontWeight: FontWeight.w500,
  //         color: Color(0xff444343),
  //         fontSize: 15,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.only(right: 5, left: 15),
  //         // width: width / 2.3,
  //         height: height * 0.058,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(5),
  //             border: Border.all(width: 1, color: const Color(0xffBBB7B7))),
  //         child: DropdownButton(
  //           icon:  const Icon(Icons.keyboard_arrow_down_outlined,
  //               color: Color(0xffBBB7B7)),
  //           iconSize: 36,
  //           isExpanded: true,
  //           underline: const SizedBox(),
  //           style: TextStyle(
  //             color: ColorConstant.blackColor,
  //             fontSize: 17,
  //           ),
  //           value: selectedDistrict,
  //           onChanged: (newValue) {
  //             setState(() {
  //               selectedDistrict = (newValue)!;
  //             });
  //           },
  //           items:stateCityViewModel.districtListModel != null? stateCityViewModel.districtListModel!.data!
  //               .map((valueItem) {
  //             return DropdownMenuItem(
  //               value: valueItem.city,
  //               child: Text(
  //                 valueItem.city!,
  //               ),
  //             );
  //           }).toList():[],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _showSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final items = Provider.of<ProfileViewModel>(context, listen: false)
            .doctorDepartmentModelData?.data;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Your Specialities',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color(0xff000000),
                            fontFamily: "poppins_reg"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.clear,
                          color: ColorConstant.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.grey, thickness: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: items?.length??0,
                    itemBuilder: (context, index) {
                      final item = items?[index];
                      final isSelected = selectedNotRemoveVal.contains(item) ||
                          selectedValues.contains(item);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: item?.image != null
                              ? NetworkImage(item?.image??"")
                              : null,
                        ),
                        title: Text(item?.name?.trim()??""),
                        trailing: Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: isSelected ? ColorConstant.primaryColor : null,
                        ),
                        onTap: () {
                          setModalState(() {
                            if (isSelected) {
                              selectedNotRemoveVal.clear();
                              selectedValues.clear();
                              // selectedValues.remove(item);
                            } else {
                              selectedNotRemoveVal.clear();
                              selectedValues.clear();
                              // selectedValues.add(item??);
                            }
                          });
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
                if (selectedValues.isNotEmpty)
                  Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ButtonConst(
                        height: height * 0.06,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 13),
                        borderRadius: BorderRadius.circular(5),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: ColorConstant.primaryColor,
                        label: "Done",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
