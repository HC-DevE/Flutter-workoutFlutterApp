import 'package:flutter/material.dart';
import 'package:my_app/pages/exercise.dart';
import 'package:my_app/pages/workout.dart';

class WorkoutData extends ChangeNotifier {
/*
WORKOUT DATA STRUCTURE
  */

  List<Workout> workoutList = [
    //default workout
    Workout(name: "Workout1", exercises: [
      Exercise(
          name: "exercice1", weight: "weight1", reps: "reps1", sets: "sets1")
    ]),
    Workout(name: "Workout2", exercises: [
      Exercise(
          name: "exercice2", weight: "weight2", reps: "reps2", sets: "sets2")
    ]),
  ];

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
  }

  //add an exercise to a workout

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
      Exercise(
        name: exerciseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );
    notifyListeners();
  }

  //check off the exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    //find the relevant workout and relevant exercise in that workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    //check off boolean to show user completed the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
  }

  //get length of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  //get the relevantWorkout
  getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  //return relevant exercise object, given a workout name + exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    //find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    //then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }
}
