import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app_with_provider/pages/activities_page.dart';
import 'package:schedule_app_with_provider/providers/activities_provider.dart';
import 'utility/config_loading.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ActivitiesProvider>(create: (_) => ActivitiesProvider()),
    ],
    child: MaterialApp(
      home: const ActivitiesPage(),
      builder: EasyLoading.init(),
    ),
  ));
  ConfigLoading.configLoading();
}
