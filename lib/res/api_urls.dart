class ApiUrl {
  static const baseUrl = "https://veronova.khiladi11.live/api/";
  static const loginUrl = "${baseUrl}doctor/login";
  static const registerUrl = "${baseUrl}reg/doctor";

  static const sendOtpUrl = "${baseUrl}doctor_otpsend";
  static const verifyOtpUrl = "${baseUrl}doctor_verifyotp";
  static const profileUrl = "${baseUrl}doctor_profile/";
  static const doctorHistoryUrl = "${baseUrl}Doctor_history";
  static const doctorViewReviewUrl = "${baseUrl}doctor_view/";
  static const documentVerifyUrl = "${baseUrl}document_verify";
  static const updateStatusUrl = "${baseUrl}update_doctor_status";
  static const slotUrl = "${baseUrl}slot";
  static const currentAppointmentUrl = "${baseUrl}current_appointment/";
  static const statusUpdateUrl = "${baseUrl}status_update";
  static const updateProfileUrl = "${baseUrl}update/profile";
  static const slotViewUrl = "${baseUrl}slot_view/";
  static const slotDeleteUrl = "${baseUrl}slot_delete";
  static const bankDetailUrl = "${baseUrl}bank_detail";
  static const helpUrl = "${baseUrl}help";
  static const doctorCatUrl = "${baseUrl}all/therapies";
  static const getSlotDates = "${baseUrl}slot_availbility/";
  static const getStateData = "${baseUrl}state";
  static const getDistrictData = "${baseUrl}city/";
}
