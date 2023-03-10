import 'package:flutter/material.dart';
import 'package:my_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'data/workout_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => WorkoutData(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
