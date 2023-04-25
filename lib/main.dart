import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class StopwatchApp extends StatefulWidget {
  @override
  StopwatchAppState createState() => StopwatchAppState();
}

class StopwatchAppState extends State<StopwatchApp> {
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  double earnings = 0.0;
  double rate =
      13.5; // schimba aici cu cat castigi tu pe ora TODO: adauga un input field

  void startStopwatch() {
    setState(() {
      stopwatch.start();
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          earnings = stopwatch.elapsed.inSeconds / 3600 * rate;
        });
      });
    });
  }

  void stopStopwatch() {
    setState(() {
      stopwatch.stop();
      timer?.cancel();
      earnings = stopwatch.elapsed.inSeconds / 3600 * rate;
    });
  }

  void resetStopwatch() {
    setState(() {
      stopwatch.reset();
      earnings = 0.0;
    });
  }

  void updateRate(String value) {
    setState(() {
      rate = double.parse(value);
      earnings = stopwatch.elapsed.inSeconds / 3600 * rate;
    });
  }

  @override
  void dispose() {
    stopwatch.stop();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banipierzat-inatorul"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${stopwatch.elapsed.inHours.toString().padLeft(2, '0')}:${(stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}",
              style: TextStyle(fontSize: 50.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "Cat ai fi castigat daca nu frecai pl: \€${earnings.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 25.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed:
                      stopwatch.isRunning ? stopStopwatch : startStopwatch,
                  style: stopwatch.isRunning
                      ? ElevatedButton.styleFrom(primary: Colors.red)
                      : ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Text(stopwatch.isRunning ? "Stop" : "DA I TATI "),
                ),
                ElevatedButton(
                  onPressed: resetStopwatch,
                  child: Text("Restart"),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ia zi vere cat castigi: "),
                SizedBox(
                  width: 100.0,
                  child: TextFormField(
                    initialValue: rate.toString(),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: updateRate,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Image.asset(
                "assets/images/euroi.jpg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicatie de cacat ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopwatchApp(),
    );
  }
}
