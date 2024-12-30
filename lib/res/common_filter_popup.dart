
import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/color_constant.dart';
import 'package:doctor_apk/res/text_context.dart';
import 'package:doctor_apk/view_model/doctor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CommonFilterPopup extends StatefulWidget {
  final String title;

  const CommonFilterPopup({
    super.key,
    required this.title,
  });

  @override
  State<CommonFilterPopup> createState() => _CommonFilterPopupState();
}

class _CommonFilterPopupState extends State<CommonFilterPopup> {
  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    final doctorViewModel = Provider.of<DoctorViewModel>(context);
    return Dialog(
      elevation: 3,
      insetPadding: const EdgeInsets.symmetric(horizontal: 25),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstant.whiteColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextContext(
                  data: widget.title,
                  fontSize: AppConstant.fontSizeThree,
                  color: ColorConstant.blackColor,
                  fontWeight: FontWeight.w500,
                ),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.clear))
              ],
            ),
            AppConstant.spaceHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildFilterContainer("Rejected", 3,height*0.05,width*0.3),
                const SizedBox(width: 10),
                buildFilterContainer("Cancelled", 4,height*0.05,width*0.3),
              ],
            ),
            const SizedBox(height: 15),
            buildFilterContainer("Consultancy Done", 2,height*0.05,width*0.45),
            AppConstant.spaceHeight10,
            TextContext(
              data: 'Filter by date',
              fontSize: AppConstant.fontSizeThree,
              color: ColorConstant.blackColor,
              fontWeight: FontWeight.w500,
            ),
            AppConstant.spaceHeight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFilterContainer("Last 1 month", 4,height*0.06,width*0.35),
                buildFilterContainer("Last 3 months", 5,height*0.06,width*0.35),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFilterContainer("Last 6 months", 6,height*0.06,width*0.35),

                buildFilterContainer("Last 1 year", 7,height*0.06,width*0.35),
              ],
            ),
            AppConstant.spaceHeight25,
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {

            doctorViewModel.doctorHistoryApi(selectedIndex, 1,context);

                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height * 0.055,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: ColorConstant.greyColor.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: ColorConstant.buttonBlueColor,
                  ),
                  child: TextContext(
                    data: 'Apply',
                    fontSize: AppConstant.fontSizeThree,
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterContainer(String text, int index, double? height,double? width,) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // Update the selected index
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width ,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: selectedIndex == index
                ? ColorConstant
                .primaryColor // Change this to your primary color
                : const Color(0xffB1B1B1),
          ),
          borderRadius: BorderRadius.circular(5),
          color: ColorConstant.whiteColor,
        ),
        child: TextContext(
          data: text,
          fontSize: AppConstant.fontSizeTwo,
          color: selectedIndex == index
              ? ColorConstant.primaryColor // Highlight text if selected
              : const Color(0xffB1B1B1),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}


