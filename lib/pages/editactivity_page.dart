import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app_with_provider/models/activities_model.dart';
import 'package:schedule_app_with_provider/providers/activities_provider.dart';
import '../utility/constant.dart';
import '../widgets/textform_widget.dart';

class EditActivityPage extends StatelessWidget {
  final Activity activityDetail;
  const EditActivityPage({Key? key, required this.activityDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: const Text('Edit Activity'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('What do you want to do ?'),
              ),
              TextFormWidget(
                initialValue: activityDetail.activityType,
                onchanged: (value) {
                  context.read<ActivitiesProvider>().editActivityType(value, activityDetail);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text('What do you want to meet/call ?'),
              ),
              TextFormWidget(
                initialValue: activityDetail.institution,
                onchanged: (value) {
                  context.read<ActivitiesProvider>().editInstitutiom(value, activityDetail);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text('When do you want to to meet/call ?'),
              ),
              Consumer<ActivitiesProvider>(
                builder: (context, activities, _) => Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black)),
                  child: ListTile(
                    title: Text('${activities.activity.when!.day}/${activities.activity.when!.month}/${activities.activity.when!.year}'),
                    trailing: GestureDetector(
                      child: const Icon(Icons.calendar_month),
                      onTap: () {
                        activities.editPickedDate(context, activities.activity);
                      },
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text('Why do you want to meet/call ?'),
              ),
              TextFormWidget(
                initialValue: activityDetail.objective,
                onchanged: (value) {
                  context.read<ActivitiesProvider>().editObjective(value, activityDetail);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text('Can you describe it more detail ?'),
              ),
              TextFormWidget(
                maxLines: 4,
                minLines: 4,
                initialValue: activityDetail.remarks,
                onchanged: (value) {
                  context.read<ActivitiesProvider>().editRemarks(value, activityDetail);
                },
              ),
              const SizedBox(height: 40),
              Consumer<ActivitiesProvider>(
                builder: (context, __, _) => ElevatedButton(
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: kBlueColor,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: activityDetail.activityType == '' || activityDetail.institution == '' || activityDetail.objective == '' || activityDetail.remarks == ''
                      ? null
                      : () async {
                          EasyLoading.show();
                          await context
                              .read<ActivitiesProvider>()
                              .editActivity(
                                id: activityDetail.id!,
                                activityType: activityDetail.activityType!,
                                institution: activityDetail.institution!,
                                when: activityDetail.when!,
                                objective: activityDetail.objective!,
                                remarks: activityDetail.remarks!,
                              )
                              .whenComplete(() {
                            EasyLoading.dismiss();
                            Navigator.pop(context);
                          });
                        },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
