// class FaqModel {
//   String? headings;
//   String? msg;
//   String? status;
//   List<TitleContent>? data;  // List to hold title and content pairs.
//
//   FaqModel({this.headings, this.msg, this.status, this.data});
//
//   FaqModel.fromJson(Map<String, dynamic> json) {
//     headings = json['headings'];
//     msg = json['msg'];
//     status = json['status'];
//     if (json['data'] != null) {
//       // Parse the data field into a list of TitleContent objects
//       data = parseData(json['data']);
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['headings'] = headings;
//     data['msg'] = msg;
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((e) => e.toJson()).toList();
//     }
//     return data;
//   }
//
//   // Helper function to parse the data string into structured title-content pairs
//   List<TitleContent> parseData(String htmlData) {
//     List<TitleContent> parsedData = [];
//     // Use a regular expression to extract titles and contents
//     RegExp regExp = RegExp(r'title: "&quot;(.*?)&quot;.*?content: "&quot;(.*?)&quot;"');
//     Iterable<RegExpMatch> matches = regExp.allMatches(htmlData);
//
//     for (var match in matches) {
//       String title = match.group(1) ?? 'kkk';
//       String content = match.group(2) ?? 'kk';
//       parsedData.add(TitleContent(title: title, content: content));
//     }
//
//     return parsedData;
//   }
// }
//
// class TitleContent {
//   String title;
//   String content;
//
//   TitleContent({required this.title, required this.content});
//
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'content': content,
//     };
//   }
// }
import 'package:html/parser.dart' as html_parser;
import 'dart:convert';

class FaqModel {
  String? title;
  String? content;

  FaqModel({this.title, this.content});

  // Static method to parse HTML data and extract multiple FAQs
  static List<FaqModel> parseFaqData(String rawData) {
    List<FaqModel> faqList = [];

    // Decode HTML entities (like &quot;) to get proper text
    var decodedData = html_parser.parseFragment(rawData).text;

    // Regex to find the FAQ data: title and content pairs
    final regExp = RegExp(r'title: "(.*?)",\s*content: "(.*?)"');
    final matches = regExp.allMatches(decodedData!);

    // Extract each FAQ's title and content using regex
    for (var match in matches) {
      String title = match.group(1) ?? '';
      String content = match.group(2) ?? '';

      faqList.add(FaqModel(title: title, content: content));
    }

    return faqList;
  }
}



