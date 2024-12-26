class SlotDateAndAvailabilityModel {
  int? status;
  String? message;
  List<Availability>? availability;

  SlotDateAndAvailabilityModel({this.status, this.message, this.availability});

  SlotDateAndAvailabilityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(Availability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (availability != null) {
      data['availability'] = availability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Availability {
  String? date;
  String? weekday;
  int? availableSlots;

  Availability({this.date, this.weekday, this.availableSlots});

  Availability.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    weekday = json['weekday'];
    availableSlots = json['available_slots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['weekday'] = weekday;
    data['available_slots'] = availableSlots;
    return data;
  }
}
