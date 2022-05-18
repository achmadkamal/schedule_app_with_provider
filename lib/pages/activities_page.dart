import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app_with_provider/pages/detailactivity_page.dart';
import 'package:schedule_app_with_provider/pages/newactivity_page.dart';
import 'package:schedule_app_with_provider/providers/activities_provider.dart';
import 'package:schedule_app_with_provider/utility/constant.dart';
import '../widgets/activitycard_widget.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: const Text('Activities'),
      ),
      body: FutureBuilder(
        future: context.read<ActivitiesProvider>().getActivities(),
        builder: (context, snapshop) {
          if (snapshop.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: kBlueColor));
          } else if (snapshop.hasData) {
            return Consumer<ActivitiesProvider>(
              builder: (context, activitiesProvider, _) {
                return SingleChildScrollView(
                  child: Column(
                      children: activitiesProvider.activities
                          .map((e) => ActivityCardWidget(
                                when: e.when!,
                                text: e.objective! + ' with ' + e.institution!,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DetailActivityPage(id: e.id!)),
                                  ).then((_) => setState(() {}));
                                },
                              ))
                          .toList()),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlueColor,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewActivityPage()),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
