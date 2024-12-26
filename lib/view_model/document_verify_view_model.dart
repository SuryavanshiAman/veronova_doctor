import 'dart:convert';
import 'dart:io';
import 'package:doctor_apk/repo/document_verify_repo.dart';
import 'package:doctor_apk/utils/utils.dart';
import 'package:doctor_apk/view_model/appointment_view_model.dart';
import 'package:doctor_apk/view_model/profile_view_model.dart';
import 'package:doctor_apk/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DocumentVerifyViewModel with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  String? idProfileImage;
  String? idProfileName;
  String? idProofImage;
  String? idProofName;
  String? degreeImage;
  String? degreeName;

  Future<void> pickImage(
      ImageSource source, BuildContext context, String docType) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      File imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      String encodedImage = base64Encode(imageBytes);

      if (docType == "idProof") {
        idProofImage = encodedImage;
        idProofName = image.name;
      } else if (docType == "degree") {
        degreeImage = encodedImage;
        degreeName = image.name;
      } else if (docType == "profile") {
        idProfileImage = encodedImage;
        idProfileName = image.name;
      }
      notifyListeners();
    }
  }

  void clearImage(String docType) {
    if (docType == "idProof") {
      idProofImage = null;
      idProofName = null;
    } else if (docType == "degree") {
      degreeImage = null;
      degreeName = null;
    } else if (docType == "profile") {
      idProfileImage = null;
      idProfileName = null;
    }
    notifyListeners();
  }

// DocumentVerify Api

  final _documentVerifyRepo = DocumentVerifyRepo();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> documentVerifyApi(context) async {
    setLoading(true);
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data = {
      "doctor_id": userId,
      "proof_id": idProofImage,
      "medical_degree": degreeImage,
    };
    _documentVerifyRepo.documentVerifyApi(data).then((value) {
      if (value['status'] == 200) {
        setLoading(false);

        final profileViewModel =
            Provider.of<ProfileViewModel>(context, listen: false);
        profileViewModel.profileApi(context);
        Navigator.pop(context);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  // updateStatusApi Api

  bool _loadingUpdate = false;
  bool _indexValue = false;

  bool get loadingUpdate => _loadingUpdate;
  bool get indexValue => _indexValue;

  setIndexValue(bool value) {
    _indexValue = value;
    notifyListeners();
  }

  setLoadingUpdate(bool value, {int index=-1} ) {
    _loadingUpdate = value;
    _selectedIndexAppointmentId = value? index :-1;
    notifyListeners();
  }

  Future<void> updateStatusApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false).modelData?.data;
    Map data = {
      "id": userId,
      "status": profileViewModel!.status.toString() == "0" ? '1' : '0',
    };
    print(data);
    _documentVerifyRepo.updateStatusApi(data).then((value) {
      if (value['status'] == 200) {

        final profileViewModel =
            Provider.of<ProfileViewModel>(context, listen: false);

        data["status"] == "0"
            ? Utils.show("You Are Now Offline", context)
            : Utils.show("You Are Now Online", context);
        profileViewModel.profileApi(context);
      }
    }).onError((error, stackTrace) {
      setLoadingUpdate(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  // Status Update Home Page

  bool _loadingUpdateHome = false;
  bool _indexVal = false;

  bool get loadingUpdateHome => _loadingUpdateHome;
  bool get indexVal => _indexVal;

  setIndexVal(bool val) {
    _indexVal = val;
    notifyListeners();
  }

  setLoadingUpdateHome(bool value) {
    _loadingUpdateHome = value;
    notifyListeners();
  }

  int _selectedIndexAppointmentId=-1;
  int get selectedIndexAppointmentId => _selectedIndexAppointmentId;

  Future<void> statusUpdateApi(
      String appointmentId, String status, context,) async {
    setLoadingUpdate(true,index:int.parse(appointmentId));
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();

    Map data = {
      "id": appointmentId,
      "doctor_id": userId,
      "status": status,
    };
    print(data);
    _documentVerifyRepo.statusUpdateApi(data).then((value) {
      if (value['status'] == 200) {
        setLoadingUpdate(false);
        final appointmentViewModel =
            Provider.of<AppointmentViewModel>(context, listen: false);
        appointmentViewModel.currentAppointmentApi(context);
      }
      setLoadingUpdate(true);
    }).onError((error, stackTrace) {
      setLoadingUpdate(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
