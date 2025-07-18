import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doctor_apk/test.dart';
import 'package:doctor_apk/utils/routes/routes.dart';
import 'package:doctor_apk/utils/routes/routes_name.dart';
import 'package:doctor_apk/view/no_internet.dart';
import 'package:doctor_apk/view/video_call/video_call_screen.dart';
import 'package:doctor_apk/view_model/add_prescription_view_model.dart';
import 'package:doctor_apk/view_model/auth_view_model.dart';
import 'package:doctor_apk/view_model/bank_view_model.dart';
import 'package:doctor_apk/view_model/doctor_view_model.dart';
import 'package:doctor_apk/view_model/help_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:doctor_apk/view_model/show_prescription_view_model.dart';
import 'package:doctor_apk/view_model/slot_view_model.dart';
import 'package:doctor_apk/view_model/state_city_view_model.dart';
import 'package:doctor_apk/view_model/update_profile_view_model.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'view_model/all_policies_view_model.dart';
import 'view_model/appointment_view_model.dart';
import 'view_model/document_verify_view_model.dart';
import 'view_model/meeting_view_model.dart';
import 'view_model/token_view_model.dart';
import 'view_model/view_bank_details_view_model.dart';
import 'view_model/view_slot_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

double width = 0.0;
double height = 0.0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (mounted) {
        _updateConnectionStatus(result);
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Could not check connectivity status: $e');
      }
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return _connectionStatus == ConnectivityResult.none
        ? const Directionality(
            textDirection: TextDirection.ltr, child: NoInternet())
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AuthViewModel()),
              ChangeNotifierProvider(create: (context) => UserViewModel()),
              ChangeNotifierProvider(create: (context) => ProfileViewModel()),
              ChangeNotifierProvider(create: (context) => DoctorViewModel()),
              ChangeNotifierProvider(
                  create: (context) => DocumentVerifyViewModel()),
              ChangeNotifierProvider(create: (context) => SlotViewModel()),
              ChangeNotifierProvider(
                  create: (context) => AppointmentViewModel()),
              ChangeNotifierProvider(
                  create: (context) => UpdateProfileViewModel()),
              ChangeNotifierProvider(create: (context) => BankViewModel()),
              ChangeNotifierProvider(create: (context) => HelpViewModel()),
              ChangeNotifierProvider(create: (context) => StateCityViewModel()),
              ChangeNotifierProvider(create: (context) => AllPoliciesViewModel()),
              ChangeNotifierProvider(create: (context) => ViewSlotViewModel()),
              ChangeNotifierProvider(create: (context) => MeetingViewModel()),
              ChangeNotifierProvider(create: (context) => ViewBankDetailViewModel()),
              ChangeNotifierProvider(create: (context) => AddPrescriptionViewModel()),
              ChangeNotifierProvider(create: (context) => ShowPrescriptionViewModel()),
              ChangeNotifierProvider(create: (context) => TokenViewModel()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: RoutesName.splashScreen,
              theme: ThemeData(splashColor: Colors.transparent,highlightColor: Colors.transparent,scaffoldBackgroundColor: Colors.white , appBarTheme: const AppBarTheme(scrolledUnderElevation: 0)),
              onGenerateRoute: (settings) {
                if (settings.name != null) {
                  return MaterialPageRoute(
                    builder: Routers.generateRoute(settings.name!),
                    settings: settings,
                  );
                }
                return null;
              },
              // home: VideoStream(),
            ),
          );
  }
}
