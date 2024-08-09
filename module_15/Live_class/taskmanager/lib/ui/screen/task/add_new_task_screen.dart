import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controller/add_new_task_controller.dart';
import 'package:taskmanager/ui/widgets/background_widgets.dart';
import 'package:taskmanager/ui/widgets/profile_app_bar.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddNewTaskController addNewTaskController =
      Get.find<AddNewTaskController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar(context),
        body: BackgroundWidget(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title Required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description Required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Description'),
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AddNewTaskController>(
                      builder: (addNewTaskController) {
                    return Visibility(
                      visible: addNewTaskController.addInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _onTapNextButton();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    );
                  }),
                ],
              ),
            ),
          ),
        )));
  }

  void _onTapNextButton() async {
    final result = await addNewTaskController.addNewTask(
        _titleController.text, _descriptionController.text);
    if (result) {
      clearTextField();
    } else {
      if (mounted) {
        showSnackBarMessage(context, addNewTaskController.errorMessage);
      }
    }
  }

  void clearTextField() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }
}
