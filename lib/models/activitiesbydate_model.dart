import 'dart:convert';

Map<String, List<ActivitiesByDate>> activitiesByDateFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, List<ActivitiesByDate>>(k, List<ActivitiesByDate>.from(v.map((x) => ActivitiesByDate.fromJson(x)))));

String activitiesByDateToJson(Map<String, List<ActivitiesByDate>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class ActivitiesByDate {
  String? activityType;
  String? institution;
  DateTime? when;
  String? objective;
  String? remarks;
  String? id;

  ActivitiesByDate({
    this.activityType,
    this.institution,
    this.when,
    this.objective,
    this.remarks,
    this.id,
  });

  factory ActivitiesByDate.fromJson(Map<String, dynamic> json) => ActivitiesByDate(
        activityType: json["activityType"],
        institution: json["institution"],
        when: DateTime.parse(json["when"]),
        objective: json["objective"],
        remarks: json["remarks"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "activityType": activityType,
        "institution": institution,
        "when": when?.toIso8601String(),
        "objective": objective,
        "remarks": remarks,
        "id": id,
      };
}
