import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/profile_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar(),
        body: BackgroundWidget(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.arrow_circle_right_outlined))
              ],
            ),
          ),
        )));
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
