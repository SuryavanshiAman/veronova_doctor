class ApiUrl {
  // static const baseUrl = "https://veronova.khiladi11.live/api/";
  static const baseUrl = "https://root.veronova.co.in/api/";
  static const loginUrl = "${baseUrl}doctor/login";
  static const agoraUrl = "https://root.veronova.co.in/agora/";
  static const registerUrl = "${baseUrl}reg/doctor";

  static const sendOtpUrl = "${baseUrl}doctor_otpsend";
  static const verifyOtpUrl = "${baseUrl}doctor_verifyotp";
  static const profileUrl = "${baseUrl}get/profile";
  static const doctorHistoryUrl = "${baseUrl}filterbystatus/appointment";
  static const doctorViewReviewUrl = "${baseUrl}doctor_view/";
  static const documentVerifyUrl = "${baseUrl}document_verify";
  static const updateStatusUrl = "${baseUrl}update_doctor_status";
  static const createSlotUrl = "${baseUrl}create/slot";
  static const currentAppointmentUrl = "${baseUrl}get/appointment";
  static const appointmentStatusUpdateUrl = "${baseUrl}appointment-status";
  static const updateProfileUrl = "${baseUrl}update/profile";
  static const slotViewUrl = "${baseUrl}get/slots";
  static const slotDeleteUrl = "${baseUrl}slot_delete";
  static const bankDetailUrl = "${baseUrl}update/bank/details";
  static const helpUrl = "${baseUrl}add/support";
  static const doctorCatUrl = "${baseUrl}all/therapies";
  static const getSlotDates = "${baseUrl}slot_availbility/";
  static const getStateData = "${baseUrl}state";
  static const getDistrictData = "${baseUrl}city/";
  static const policies = "${baseUrl}get/settings";
  static const meeting = "${baseUrl}add/consultation";
  static const viewBankDetails = "${baseUrl}bank/view";
  static const sendTime = "${baseUrl}appointment-date";
  static const addPrescription = "${baseUrl}add/prescription";
  static const showPrescription = "${baseUrl}prescription/list";
  static const tokenApi = "${agoraUrl}generate/agora-token";
}
