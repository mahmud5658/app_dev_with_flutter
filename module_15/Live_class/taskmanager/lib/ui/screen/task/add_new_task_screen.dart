import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
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

  bool _inProgress = false;
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
                  Visibility(
                    visible: _inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _addNewTask();
                          }
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                  )
                ],
              ),
            ),
          ),
        )));
  }

  Future<void> _addNewTask() async {
    if (mounted) {
      setState(() {
        _inProgress = true;
      });
    }
    Map<String, dynamic> requestData = {
      "title": _titleController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createTask, body: requestData);

    if (mounted) {
      setState(() {
        _inProgress = false;
      });
    }

    if (response.isSuccess) {
      clearTextField();
      if(mounted){
        showSnackBarMessage(context, 'New Task added successfuly');
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, 'New Task added failed! try again',true);
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
