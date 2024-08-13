import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassCountController =
      TextEditingController(text: '1');
  List<WaterConsume> waterConsumeList = [];

  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _addWaterConsume,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.amber, width: 8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Icon(Icons.water_drop_outlined),
                            Text('Tap here'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _glassCountController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        labelText: 'No of glass',
                        labelStyle: TextStyle(color: Colors.black),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('History'),
                Text(
                  'Total: ${_getTotalWaterCount()}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  // reverse: true,
                  itemCount: waterConsumeList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(DateFormat.yMEd()
                          .add_jms()
                          .format(waterConsumeList[index].time)),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        child: Text('${index + 1}'),
                      ),
                      trailing: Text(
                        waterConsumeList[index].glassCount.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _addWaterConsume() {
    int glassCount = int.tryParse(_glassCountController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glassCount: glassCount);
    waterConsumeList.add(waterConsume);
    setState(() {});
  }

  int _getTotalWaterCount() {
    int totalCout = 0;
    for (WaterConsume waterConsume in waterConsumeList) {
      totalCout += waterConsume.glassCount;
    }
    return totalCout;
  }
}

class WaterConsume {
  final DateTime time;
  final int glassCount;
  WaterConsume({required this.time, required this.glassCount});
}
