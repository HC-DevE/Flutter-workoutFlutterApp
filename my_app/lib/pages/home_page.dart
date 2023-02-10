import 'package:flutter/material.dart';
import 'package:my_app/pages/workout_page.dart';
import 'package:provider/provider.dart';

import '../data/workout_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//text controller

  final newWorkoutNameController = TextEditingController();

//create new workout methode

  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create new workout"),
        content: TextField(
          controller: newWorkoutNameController,
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Icon(Icons.check),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  void goToWorkoutPage(String workoutNameF) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(
                  workoutName: workoutNameF,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text('Workout Tracker'),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: createNewWorkout, child: const Icon(Icons.add)),
            body: ListView.builder(
                itemCount: value.getWorkoutList().length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(value.getWorkoutList()[index].name),
                      onTap: () =>
                          goToWorkoutPage(value.getWorkoutList()[index].name),
                    ))));
  }
}
