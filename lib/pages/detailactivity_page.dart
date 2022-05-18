import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app_with_provider/pages/editactivity_page.dart';
import 'package:schedule_app_with_provider/providers/activities_provider.dart';
import 'package:schedule_app_with_provider/utility/constant.dart';

class DetailActivityPage extends StatelessWidget {
  final String id;
  const DetailActivityPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: kBlueColor,
        title: const Text('Activity Info'),
      ),
      body: FutureBuilder(
        future: context.read<ActivitiesProvider>().getActivity(id: id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: kBlueColor));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Consumer<ActivitiesProvider>(
                builder: (context, activitiesProvider, _) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detail',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            activitiesProvider.activity.activityType! +
                                ' with ' +
                                activitiesProvider.activity.institution! +
                                ' at ' +
                                DateFormat('EEEE, d MMMM yyyy').format(activitiesProvider.activity.when!) +
                                ' to discuss about ' +
                                activitiesProvider.activity.objective!,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            child: const Text('Edit Activity'),
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: kBlueColor,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditActivityPage(activityDetail: activitiesProvider.activity),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
