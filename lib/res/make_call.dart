import 'package:url_launcher/url_launcher.dart';

class MakeCall {
  static const String dialPadScheme = 'tel';
  static const String errorMessage = 'Could not launch dial pad';

  static Future<void> openDialPad(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: dialPadScheme,
      path: phoneNumber,
    );

    if (await canLaunch(phoneLaunchUri.toString())) {
      await launch(phoneLaunchUri.toString());
    } else {
      throw errorMessage;
    }
  }
}