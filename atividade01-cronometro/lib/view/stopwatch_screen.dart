import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/stopwatch_viewmodel.dart';
import 'stopwatch_painter.dart';

class StopwatchScreen extends StatelessWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StopwatchViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('STOPWATCH'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 32),
          Expanded(
            child: Center(
              child: CustomPaint(
                painter: StopwatchPainter(
                  progress: vm.progress,
                  color: const Color.fromARGB(255, 96, 255, 68),
                ),
                child: Container(
                  width: 250,
                  height: 250,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vm.elapsedTime.split(':')[1],
                        style: TextStyle(
                          fontSize: 64,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        vm.elapsedTime.split('.')[1],
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vm.laps.length,
              reverse: true,
              itemBuilder: (context, index) {
                final lap = vm.laps[index];
                final lapNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nº $lapNumber', style: TextStyle(color: const Color.fromARGB(255, 96, 255, 68))),
                      Text(lap['lap']!, style: TextStyle(color: const Color.fromARGB(255, 96, 255, 68))),
                      Text(lap['total']!, style: TextStyle(color: const Color.fromARGB(255, 96, 255, 68))),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Semantics(
                  label: 'Reiniciar cronômetro',
                  button: true,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 253, 21, 164),
                    radius: 30,
                    child: IconButton(
                      icon: Icon(Icons.refresh, color: Colors.white),
                      onPressed: vm.reset,
                    ),
                  ),
                ),
                Semantics(
                  label: vm.isRunning ? 'Pausar cronômetro' : 'Iniciar cronômetro',
                  button: true,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 96, 255, 68),
                    radius: 40,
                    child: IconButton(
                      icon: Icon(
                        vm.isRunning ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: vm.isRunning ? vm.pause : vm.start,
                    ),
                  ),
                ),
                Semantics(
                  label: 'Registrar volta',
                  button: true,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(Icons.flag, color: Colors.white),
                      onPressed: vm.isRunning ? vm.addLap : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
