import 'package:flutter/material.dart';
import 'package:my_app/components/exercise_tile.dart';
import 'package:my_app/data/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  //text controllers
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  //create new exercise methode

  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add a new exercise'),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                //exercise name
                TextField(controller: exerciseNameController),
                //weight
                TextField(controller: weightController),
                //reps
                TextField(controller: repsController),
                //steps
                TextField(controller: setsController),
              ]),
              actions: [
                //save button
                MaterialButton(
                  onPressed: save,
                  child: const Icon(Icons.check),
                ),
                //cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: const Icon(Icons.cancel),
                ),
              ],
            ));
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .addExercise(widget.workoutName, newExerciseName, weight, reps, sets);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(title: Text(widget.workoutName)),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
                widget.workoutName,
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name),
          ),
        ),
      ),
    );
  }
}
