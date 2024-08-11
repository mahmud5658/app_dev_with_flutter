import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.replay_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Age'),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Ht(ft)'),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Ht(in)'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.male)),
                Text(
                  '|',
                  style: TextStyle(fontSize: 24),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.female)),
                SizedBox(
                  width: 90,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Weight(kg)'),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.chevron_right)),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(minimum: 15, maximum: 40, ranges: <GaugeRange>[
                GaugeRange(startValue: 15, endValue: 18, color: Colors.red),
                GaugeRange(startValue: 18, endValue: 25, color: Colors.green),
                GaugeRange(startValue: 25, endValue: 40, color: Colors.yellow)
              ], pointers: <GaugePointer>[
                NeedlePointer(value: 90)
              ], annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Text('90.0',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                    angle: 90,
                    positionFactor: 0.5)
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
