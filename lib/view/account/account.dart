import 'package:doctor_apk/generated/assets.dart';
import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/common_delete_popup.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view/account/bank_account.dart';
import 'package:doctor_apk/view/account/create_schedule.dart';
import 'package:doctor_apk/view/account/document.dart';
import 'package:doctor_apk/view/account/faqs.dart';
import 'package:doctor_apk/view/account/help_support.dart';
import 'package:doctor_apk/view/account/policy.dart';
import 'package:doctor_apk/view/account/profile.dart';
import 'package:doctor_apk/view/account/terms.dart';
import 'package:doctor_apk/view/bottombar/bottom_bar.dart';
import 'package:doctor_apk/view_model/document_verify_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String online = "notification";
  bool indexValue = false;
  @override
  void initState() {
    super.initState();
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);
    profileViewModel.profileApi(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).modelData?.data;

    void passFunction(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    }

    void contact(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HelpSupport()),
      );
    }

    void bank(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BankAccount()));
    }

    void faqs(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Faqs()));
    }

    void termsAdd(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Terms()));
    }

    void policy(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Policy()));
    }

    void document(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Document()));
    }

    void schedulePage(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CreateSchedule()));
    }

    void login(BuildContext context) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return CommonDeletePopup(
                title: 'Do you want to logout from the account ?',
                yes: () {
                  UserViewModel userViewModel = UserViewModel();
                  userViewModel.remove();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutesName.mainScreen,
                    (Route<dynamic> route) => false,
                  );
                });
          });
    }

    List<dynamic> accountData = [
      {
        "tittle": "My Profile",
        "subtitle": "Complete profile",
        "img": "assets/icon/my_profile.png",
        "navigate": () => passFunction(context),
        "icon": Icons.store
      },
      {
        "tittle": "Schedule",
        "subtitle": "MY Schedule",
        "img": "assets/icon/appointment.png",
        "navigate": () => schedulePage(context),
        "icon": Icons.store
      },
      {
        "tittle": "Document",
        "subtitle": "My Document",
        "img": "assets/icon/ambulance.png",
        "navigate": () => document(context),
        "icon": Icons.description
      },
      {
        "tittle": "Bank",
        "subtitle": "Bank Detail",
        "img": "assets/icon/my_orders.png",
        "navigate": () => bank(context),
        "icon": Icons.food_bank
      },
      {
        "tittle": "Contact Us",
        "subtitle": "Let us help you",
        "img": "assets/icon/my_address.png",
        "navigate": () => contact(context),
        "icon": Icons.mail
      },
      {
        "tittle": "T&C",
        "subtitle": "Terms & Condition",
        "img": "assets/icon/helpe.png",
        "navigate": () => termsAdd(context),
        "icon": Icons.assignment
      },
      {
        "tittle": "Policy",
        "subtitle": "Our Policy",
        "img": "assets/icon/policy.png",
        "navigate": () => policy(context),
        "icon": Icons.policy
      },
      {
        "tittle": "FAQs",
        "subtitle": "Quick Answer",
        "img": "assets/icon/tc.png",
        "navigate": () => faqs(context),
        "icon": Icons.announcement
      },
      {
        "tittle": "Logout",
        "subtitle": "See you soon",
        "img": "assets/icon/faqes.png",
        "navigate": () => login(context),
        "icon": Icons.exit_to_app
      },
    ];
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              NavigatorService.navigateToScreenOne(context);
            },
            child: Image.asset(
              "assets/icon/arrow_1.png",
              scale: 6,
              color: const Color(0xff1E1E1E),
            )),
        centerTitle: true,
        title: const TextContext(
          data: "Account",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.whiteColor,
      ),
      body: profileViewModel != null
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstant.primaryColor,
            ))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.030),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width,
                      child: Stack(children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              width * 0.12, height * 0.030, 0, 0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/bgimg/acountBgi.png",
                                ),
                                fit: BoxFit.fitWidth),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 17),
                                    child: CircleAvatar(
                                      backgroundImage:
                                          profileViewModel?.profile == null
                                              ? AssetImage(
                                                  Assets.imgDoctor2.toString())
                                              : NetworkImage(profileViewModel?.profile.toString()??""),
                                      radius: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.05,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextContext(
                                        data: "Hello,",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000),
                                        fontFamily: "poppins_reg",
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextContext(
                                        data:
                                            "Dr. ${profileViewModel?.name.toString()}",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: const Color(0xff1E1E1E),
                                        fontFamily: "poppins_reg",
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextContext(
                                          data:
                                              "+91-${profileViewModel?.phone.toString()}",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: const Color(0xff979797),
                                          fontFamily: "poppins_reg"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      profileViewModel?.document.toString() ==
                                              "2"
                                          ? SizedBox(
                                              height: 20,
                                              child: Image.asset(
                                                "assets/img/trangale.png",
                                              ),
                                            )
                                          : Container(),
                                       Consumer<DocumentVerifyViewModel>(
                                              builder: (context, statusProvider,
                                                  child) {
                                                return Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Switch(
                                                        inactiveTrackColor:
                                                            ColorConstant
                                                                .redColor,
                                                        inactiveThumbColor:
                                                            ColorConstant
                                                                .whiteColor,
                                                        activeTrackColor:
                                                            ColorConstant
                                                                .greenColor,
                                                        activeColor:
                                                            profileViewModel?.status
                                                                        .toString() ==
                                                                    "0"
                                                                ? ColorConstant
                                                                    .whiteColor
                                                                : ColorConstant
                                                                    .whiteColor,
                                                        value: profileViewModel?.status
                                                                    .toString() ==
                                                                "0"
                                                            ? false
                                                            : true,
                                                        onChanged: (value) {
                                                          if(profileViewModel?.document.toString() ==
                                                              "2"
                                                              ){
                                                            statusProvider.setIndexValue(value);
                                                            statusProvider.updateStatusApi(context);
                                                          }else{
                                                           Utils.show("Action not allowed! verify your document to access", context);
                                                          }

                                                        },
                                                      ),
                                                    ),
                                                    Text(
                                                      profileViewModel?.status
                                                                  .toString() ==
                                                              "0"
                                                          ? "Offline"
                                                          : "Online",
                                                      style: TextStyle(
                                                        color: profileViewModel?.status
                                                                    .toString() ==
                                                                "0"
                                                            ? ColorConstant
                                                                .redColor
                                                            : ColorConstant
                                                                .greenColor,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          // : Container()
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: width * 0.020,
                          top: height * 0.010,
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: profileViewModel?.document.toString() == "2"
                                ? ColorConstant.primaryColor
                                : const Color(0xffD1CDCD),
                          ),
                        )
                      ]),
                    ),
                    AppConstant.spaceHeight15,
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: accountData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 4 / 1.5),
                        itemBuilder: (context, index) {
                          final data = accountData[index];
                          return GestureDetector(
                            onTap: data["navigate"],
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstant.whiteColor,
                                border: Border.all(
                                    width: 0.2, color: ColorConstant.greyColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextContext(
                                            data: data["tittle"],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: const Color(0xff353535),
                                            fontFamily: "poppins_reg"),
                                        TextContext(
                                            data: data["subtitle"],
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff979797),
                                            fontFamily: "poppins_reg")
                                      ],
                                    ),
                                    Icon(
                                      data["icon"],
                                      color: ColorConstant.greyColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    AppConstant.spaceHeight20,
                    Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: width,
                        alignment: Alignment.center,
                        child: const TextContext(
                          data:
                              "HealthCRAD Doctor by\nBhavah Healthcare Pvt. Ltd.",
                          maxLines: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff979797),
                          fontFamily: "poppins_reg",
                          textAlign: TextAlign.center,
                        )),
                    AppConstant.spaceHeight10,
                  ],
                ),
              ),
            ),
    );
  }
}
