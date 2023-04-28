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
      17.5; //Danut Copae asked why it used to be 13.5 so I switched it to 17.5

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
        title: Text("Banipierdut-inatorul"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/euroisuparat.gif",
            ),
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
      title: 'Banipierdut-inatorul',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(0, 255, 255, 255),
      ),
      home: StopwatchApp(),
    );
  }
}
