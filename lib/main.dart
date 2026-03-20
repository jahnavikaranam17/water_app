import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(WaterApp());
}

class WaterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int waterLevel = 45;

  String getStatus() {
    if (waterLevel > 70) return "High";
    if (waterLevel > 30) return "Medium";
    return "Low";
  }

  Color getColor() {
    if (waterLevel > 70) return Colors.green;
    if (waterLevel > 30) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Monitor")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.water_drop, size: 80, color: getColor()),

            SizedBox(height: 20),

            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 12.0,
              percent: waterLevel / 100,
              animation: true, // 🔥 ADD THIS
              animationDuration: 800, // 🔥 ADD THIS
              center: Text(
                "$waterLevel%",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              progressColor: getColor(),
              backgroundColor: Colors.grey.shade800,
              circularStrokeCap: CircularStrokeCap.round,
            ),

            SizedBox(height: 10),

            Text(
              "Status: ${getStatus()}",
              style: TextStyle(fontSize: 22, color: getColor()),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  waterLevel += 10;

                  if (waterLevel > 100) {
                    waterLevel = 0;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: getColor(),
              ),
              child: Text("Refresh Data"),
            ),
          ],
        ),
      ),
    );
  }
}
