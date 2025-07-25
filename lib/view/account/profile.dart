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
  final profession = TextEditingController();
  final fees = TextEditingController();
  final specialist = TextEditingController();
  final about = TextEditingController();
  String dropdownValue = 'Heart';
  bool _isTextFieldEnabled = false;
  String? selectedItemId;
  setData(){
    final profileViewModel =
    Provider.of<ProfileViewModel>(context, listen: false);
    name.text=profileViewModel.modelData?.data?.name;
    number.text=profileViewModel.modelData?.data?.mobile;
    email.text=profileViewModel.modelData?.data?.email;
    qualification.text=profileViewModel.modelData?.data?.qualification;
    experience.text=profileViewModel.modelData?.data?.exp;
    profession.text=profileViewModel.modelData?.data?.profession;
    fees.text=profileViewModel.modelData?.data?.fees;
    specialist.text=profileViewModel.modelData?.data?.specialties;
    about.text=profileViewModel.modelData?.data?.about;
  }
  @override
  void initState() {
    super.initState();
    setData();
    final stateCityViewModel =
    Provider.of<StateCityViewModel>(context, listen: false);
    stateCityViewModel.getStateApi();
    stateCityViewModel.getDistrictApi("1");
    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileApi(context);
    if (profileViewModel.modelData != null && profileViewModel.modelData!.data != null && profileViewModel.modelData!.data!.specialties != null) {
      List<dynamic> listId = jsonDecode(profileViewModel.modelData!.data!.specialties);
      for (var resId in listId) {
        final resName = profileViewModel.doctorDepartmentModelData!.data!.where((e) => e.id == resId);
        selectedNotRemoveVal.addAll(resName);
      }
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
              final selectedSpecialitiesIds = selectedValues.isNotEmpty
                  ? selectedValues.map((e) => e.id).toList()
                  : selectedNotRemoveVal.map((e) => e.id).toList();
              updateProfileViewModel.updateProfileApi(
                name.text,
                email.text,
                qualification.text,
                experience.text,
                fees.text,
                selectedSpecialitiesIds,
                profession.text,
                about.text,
                condition,
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
              color: ColorConstant.whiteColor,
            )),
        centerTitle: true,
        title: TextContext(
          data: _isTextFieldEnabled ? "Edit Account" : "View Account",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: ColorConstant.whiteColor,
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          AppConstant.spaceHeight5,

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
                            'If you want to change/correct mistakes , Go to "contact Us section. We will reach you out soon"',
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
                                  : NetworkImage(profileViewModel!.image.toString())
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
                  hintText: 'Enter Your Name',
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
                  enabled: _isTextFieldEnabled,
                  hintText: "Enter your mobile",
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
                  hintText:  'Enter Your Email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email,
                    color: ColorConstant.primaryColor,
                  ),
                ),
          AppConstant.spaceHeight10,
          Divider(
            thickness: 3,
            color: ColorConstant.scaffoldBgColor,
          ),
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
                  hintText:
                      'Enter Your Qualification',
                  enabled: _isTextFieldEnabled,
                  controller: qualification,
                ),
          Divider(
            thickness: 3,
            color: ColorConstant.scaffoldBgColor,
          ),
          AppConstant.spaceHeight10,
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
                  hintText: 'Enter Yor Experience ',
                  keyboardType: TextInputType.number,
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
          AppConstant.spaceHeight10,
          Divider(
            thickness: 3,
            color: ColorConstant.scaffoldBgColor,
          ),
          AppConstant.spaceHeight5,
          const TextContext(
              data: "Profession",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff000000),
              fontFamily: "poppins_reg"),
          AppConstant.spaceHeight5,
          TextfieldContext(
            hintStyle: TextStyle(
                color: profileViewModel?.profession == null
                    ? Colors.grey
                    : Colors.black),
            intBorder: false,
            fillColor: ColorConstant.whiteColor,
            filled: true,
            hintText: 'Enter Yor Profession ',
            enabled: _isTextFieldEnabled,
            controller: profession,
          ),
          AppConstant.spaceHeight15,
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
                AppConstant.spaceHeight5,
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
                                            // data: profileViewModel!.specialties,
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
          Text(condition),
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
                    hintText:'Enter Your About',
                    enabled: _isTextFieldEnabled,
                    controller: about,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
        ],
      ),
    );
  }

  dynamic selectedState;
  dynamic selectedDistrict;
String condition="";
  void _showSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final items = Provider.of<ProfileViewModel>(context, listen: false).doctorDepartmentModelData!.data;

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
                    itemCount: items!.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isSelected = selectedNotRemoveVal.contains(item) ||
                          selectedValues.contains(item);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: item.image != null
                              ? NetworkImage(item.image??"")
                              : null,
                        ),
                        title: Text(item.name?.trim()??""),
                        subtitle: isSelected
                            ? DropdownButton<String>(
                          value: item.status,
                          items: const [
                            DropdownMenuItem(
                                value: "Normal",
                                child: Text("Normal")),
                            DropdownMenuItem(
                                value: "Critical",
                                child: Text("Critical")),
                          ],
                          onChanged: (val) {
                            setModalState(() {
                              item.status = val!;
                              condition=item.status!;
                            });
                          },
                        )
                            : null,
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
                              selectedValues.add(item);
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
  // List<Map<String, dynamic>> departments = [
  //   {
  //     "name": "Cardiology",
  //     "image": "https://via.placeholder.com/150",
  //     "isSelected": false,
  //     "status": "Normal",
  //   },
  //   {
  //     "name": "Neurology",
  //     "image": "https://via.placeholder.com/150",
  //     "isSelected": false,
  //     "status": "Normal",
  //   },
  //   {
  //     "name": "Orthopedics",
  //     "image": "https://via.placeholder.com/150",
  //     "isSelected": false,
  //     "status": "Normal",
  //   },
  // ];

  // void _showSelectionBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       final items = Provider.of<ProfileViewModel>(context, listen: false)
  //           .doctorDepartmentModelData!
  //           .data;
  //
  //       return StatefulBuilder(
  //         builder: (context, setModalState) {
  //           return Container(
  //             height: MediaQuery.of(context).size.height * 0.8,
  //             padding: const EdgeInsets.all(16),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     const Text(
  //                       'Select Your Specialities',
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w600,
  //                           fontSize: 15,
  //                           color: Color(0xff000000),
  //                           fontFamily: "poppins_reg"),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Icon(Icons.clear, color: ColorConstant.textColor),
  //                     ),
  //                   ],
  //                 ),
  //                 const Divider(color: Colors.grey, thickness: 1),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     itemCount: items!.length,
  //                     itemBuilder: (context, index) {
  //                       final item = items[index];
  //
  //                       final isSelected = selectedValues.contains(item);
  //
  //                       return Container(
  //                         padding: const EdgeInsets.symmetric(vertical: 5),
  //                         decoration: BoxDecoration(
  //                           color: isSelected ? Colors.grey.shade100 : null,
  //                           borderRadius: BorderRadius.circular(8),
  //                         ),
  //                         child: ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundImage: item.image != null
  //                                 ? NetworkImage(item.image ?? "")
  //                                 : null,
  //                           ),
  //                           title: Text(item.name?.trim() ?? ""),
  //                           subtitle: isSelected
  //                               ? DropdownButton<String>(
  //                             value: item.status,
  //                             items: const [
  //                               DropdownMenuItem(
  //                                   value: "Normal",
  //                                   child: Text("Normal")),
  //                               DropdownMenuItem(
  //                                   value: "Critical",
  //                                   child: Text("Critical")),
  //                             ],
  //                             onChanged: (val) {
  //                               setModalState(() {
  //                                 item.status = val!;
  //                               });
  //                             },
  //                           )
  //                               : null,
  //                           trailing: Icon(
  //                             isSelected
  //                                 ? Icons.check_box
  //                                 : Icons.check_box_outline_blank,
  //                             color: isSelected
  //                                 ? ColorConstant.primaryColor
  //                                 : null,
  //                           ),
  //                           onTap: () {
  //                             setModalState(() {
  //                               if (isSelected) {
  //                                 selectedValues.remove(item);
  //                               } else {
  //                                 selectedValues.add(item);
  //                                 item.status = "Normal"; // default status
  //                               }
  //                             });
  //                             setState(() {});
  //                           },
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 if (selectedValues.isNotEmpty)
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 13),
  //                     child: ButtonConst(
  //                       height: 50,
  //                       alignment: Alignment.center,
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: ColorConstant.primaryColor,
  //                       label: "Done",
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w600,
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


}
