import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../providers/activities_provider.dart';
import '../utility/constant.dart';
import '../widgets/textform_widget.dart';

class NewActivityPage extends StatefulWidget {
  const NewActivityPage({Key? key}) : super(key: key);

  @override
  State<NewActivityPage> createState() => _NewActivityPageState();
}

class _NewActivityPageState extends State<NewActivityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<ActivitiesProvider>().setNewActivityType = '';
      context.read<ActivitiesProvider>().setNewInstitution = '';
      context.read<ActivitiesProvider>().setNewObjective = '';
      context.read<ActivitiesProvider>().setNewRemarks = '';
      context.read<ActivitiesProvider>().setNewDateTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColor,
        title: const Text('New Activities'),
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
                hintText: 'Please input your Activity',
                onchanged: (value) {
                  context.read<ActivitiesProvider>().setNewActivityType = value;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text('What do you want to meet/call ?'),
              ),
              TextFormWidget(
                hintText: 'Please input Institution Name',
                onchanged: (value) {
                  context.read<ActivitiesProvider>().setNewInstitution = value;
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
                    title: Text('${activities.newDateTime.day}/${activities.newDateTime.month}/${activities.newDateTime.year}'),
                    trailing: GestureDetector(
                      child: const Icon(Icons.calendar_month),
                      onTap: () {
                        activities.newPickedDate(context);
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
                hintText: 'Please input your Objective',
                onchanged: (value) {
                  context.read<ActivitiesProvider>().setNewObjective = value;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 10),
                child: Text('Can you describe it more detail ?'),
              ),
              TextFormWidget(
                maxLines: 4,
                minLines: 4,
                hintText: 'Plese input remarks',
                onchanged: (value) {
                  context.read<ActivitiesProvider>().setNewRemarks = value;
                },
              ),
              const SizedBox(height: 40),
              Consumer<ActivitiesProvider>(
                builder: (context, activities, _) => ElevatedButton(
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: kBlueColor,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: activities.newActivityType == '' || activities.newInstitution == '' || activities.newObjective == '' || activities.newRemarks == ''
                      ? null
                      : () async {
                          EasyLoading.show();
                          await context
                              .read<ActivitiesProvider>()
                              .addNewActivity(
                                activityType: activities.newActivityType,
                                institution: activities.newInstitution,
                                when: activities.newDateTime,
                                objective: activities.newObjective,
                                remarks: activities.newRemarks,
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
