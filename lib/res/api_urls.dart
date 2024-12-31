class ApiUrl {
  static const baseUrl = "https://veronova.khiladi11.live/api/";
  static const loginUrl = "${baseUrl}doctor/login";
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
  static const helpUrl = "${baseUrl}help";
  static const doctorCatUrl = "${baseUrl}all/therapies";
  static const getSlotDates = "${baseUrl}slot_availbility/";
  static const getStateData = "${baseUrl}state";
  static const getDistrictData = "${baseUrl}city/";
  static const policies = "${baseUrl}get/settings";
  static const meeting = "${baseUrl}add/consultation";
  static const viewBankDetails = "${baseUrl}bank/view";
}
