import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app_with_provider/utility/constant.dart';
import '../models/activities_model.dart';
import 'package:http/http.dart' as http;

class ActivitiesProvider with ChangeNotifier {
  List<Activity> _activities = [];
  List<Activity> get activities => _activities;

  Activity _activity = Activity();
  Activity get activity => _activity;

  Future<dynamic> getActivities() async {
    try {
      final url = Uri.parse(kBaseUrl);
      final response = await http.get(url);
      final data = activitiesFromJson(response.body);

      if (response.statusCode == 200) {
        _activities = data;
        return _activities;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<dynamic> getActivity({required String id}) async {
    try {
      final url = Uri.parse('$kBaseUrl/' + id);
      final response = await http.get(url);
      final data = Activity.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _activity = data;
        return _activity;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  Future<dynamic> editActivity({
    required String id,
    required String activityType,
    required String institution,
    required DateTime when,
    required String objective,
    required String remarks,
  }) async {
    try {
      final url = Uri.parse('$kBaseUrl/' + id);
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "activityType": activityType,
            "institution": institution,
            "when": when.toIso8601String(),
            "objective": objective,
            "remarks": remarks,
          },
        ),
      );
      final data = Activity.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _activity = data;
        return _activity;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

   Future<dynamic> addNewActivity({
    required String activityType,
    required String institution,
    required DateTime when,
    required String objective,
    required String remarks,
  }) async {
    try {
      final url = Uri.parse(kBaseUrl);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "activityType": activityType,
            "institution": institution,
            "when": when.toIso8601String(),
            "objective": objective,
            "remarks": remarks,
          },
        ),
      );
      final data = Activity.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        _activity = data;
        return _activity;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }
  }

  void editPickedDate(BuildContext context, Activity activity) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().month + 1),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: activity.when!,
    );

    if (date != null) {
      activity.when = date;
    }
    notifyListeners();
  }

  void editActivityType(String value, Activity activity) {
    activity.activityType = value;
    notifyListeners();
  }

  void editObjective(String value, Activity activity) {
    activity.objective = value;
    notifyListeners();
  }

  void editInstitutiom(String value, Activity activity) {
    activity.institution = value;
    notifyListeners();
  }

  void editRemarks(String value, Activity activity) {
    activity.remarks = value;
    notifyListeners();
  }

  DateTime _newDateTime = DateTime.now();
  DateTime get newDateTime => _newDateTime;
  set setNewDateTime (DateTime dateTime) {
    _newDateTime = dateTime;
    notifyListeners();
  }

  void newPickedDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: _newDateTime,
    );

    if (date != null) {
      _newDateTime = date;
    }
    notifyListeners();
  }

  String _newActivityType = '';
  String get newActivityType => _newActivityType;
  set setNewActivityType(String value) {
    _newActivityType = value;
    notifyListeners();
  }

  String _newInstitution = '';
  String get newInstitution => _newInstitution;
  set setNewInstitution(String value) {
    _newInstitution = value;
    notifyListeners();
  }

  String _newObjective = '';
  String get newObjective => _newObjective;
  set setNewObjective(String value) {
    _newObjective = value;
    notifyListeners();
  }

  String _newRemarks = '';
  String get newRemarks => _newRemarks;
  set setNewRemarks(String value) {
    _newRemarks = value;
    notifyListeners();
  }
}
