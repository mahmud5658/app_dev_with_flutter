import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todoList = [];
  String item = '';

  inputOnChange(content) {
    setState(() {
      item = content;
    });
  }

  addItem() {
    setState(() {
      todoList.add({'item': item});
    });
  }

  removeItem(index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                        flex: 70,
                        child: TextFormField(
                          decoration: appInputStyle('List Item'),
                          onChanged: (content) {
                            inputOnChange(content);
                          },
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 30,
                        child: ElevatedButton(
                            style: buttonStyle(),
                            onPressed: () {
                              addItem();
                            },
                            child: Text('Add')))
                  ],
                )),
            Expanded(
                flex: 90,
                child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: sizedBox50(Row(
                        children: [
                          Expanded(
                            flex: 70,
                            child: Text(todoList[index]['item']),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 30,
                              child: IconButton(
                                  onPressed: () {
                                    removeItem(index);
                                  },
                                  icon: const Icon(Icons.delete)))
                        ],
                      )));
                    }))
          ],
        ),
      ),
    );
  }
}
