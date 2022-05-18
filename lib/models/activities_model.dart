import 'dart:convert';

List<Activity> activitiesFromJson(String str) => List<Activity>.from(json.decode(str).map((x) => Activity.fromJson(x)));
String activitiesToJson(List<Activity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activity {
  String? activityType;
  String? institution;
  DateTime? when;
  String? objective;
  String? remarks;
  String? id;

  Activity({
    this.activityType,
    this.institution,
    this.when,
    this.objective,
    this.remarks,
    this.id,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
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
