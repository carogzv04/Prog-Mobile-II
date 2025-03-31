import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/stopwatch_screen.dart';
import 'viewmodel/stopwatch_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StopwatchViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cronômetro de Voltas',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color.fromARGB(255, 96, 255, 68),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 96, 255, 68),
            foregroundColor: Colors.black,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromARGB(255, 96, 255, 68),
          ),
        ),
        home: const StopwatchScreen(),
      ),
    );
  }
}
