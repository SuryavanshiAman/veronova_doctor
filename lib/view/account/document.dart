

import 'package:doctor_apk/main.dart';
import 'package:doctor_apk/res/app_constant.dart';
import 'package:doctor_apk/res/text_context.dart';

import 'package:doctor_apk/res/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../view_model/profile_view_model.dart';

class Document extends StatefulWidget {
  const Document({super.key});

  @override
  State<Document> createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context).modelData?.data;

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
          ),
        ),
        centerTitle: true,
        title: const TextContext(
          data: "Document",
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xff1E1E1E),
        ),
        backgroundColor: ColorConstant.containerFillColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          shrinkWrap: true,
          children: [
            AppConstant.spaceHeight5,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      radius: 8,
                      child: Icon(
                        Icons.info_outline,
                        color: ColorConstant.textColor,
                      ),
                    ),
                  ),
                  AppConstant.spaceHeight5,
                  const TextContext(
                    textAlign: TextAlign.center,
                    data:
                        'If you want to change/correct mistakes, go to the "Contact Us" section. We will reach out to you soon.',
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xff000000),
                    fontFamily: "poppins_reg",
                  ),
                ],
              ),
            ),
            AppConstant.spaceHeight10,
            const TextContext(
              data: "Document ID proof",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff000000),
              fontFamily: "poppins_reg",
            ),
            AppConstant.spaceHeight5,
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                      imageUrls: [
                        profileViewModel?.proofId ?? "",
                      ],
                    ),
                  ),
                );
              },
              // child: Container(
              //   height: height/2.8,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(profileViewModel!.proofId ?? ""),
              //       fit: BoxFit.fitWidth,
              //     ),
              //   ),
              // ),
            ),
            AppConstant.spaceHeight10,
            const TextContext(
              data: "Document Degree proof",
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xff000000),
              fontFamily: "poppins_reg",
            ),
            AppConstant.spaceHeight5,
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                      imageUrls: [
                        profileViewModel?.medicalDegree ?? "",
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                height: height/2.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(profileViewModel?.medicalDegree ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AppConstant.spaceHeight10,
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final List<String> imageUrls;

  const FullScreenImage({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: PageController(),
      ),
    );
  }
}
