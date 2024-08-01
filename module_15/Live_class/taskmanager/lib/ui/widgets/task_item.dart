import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/network_response.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/network_caller/network_caller.dart';
import 'package:taskmanager/data/utilities/url.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    Key? key,
    required this.taskModel,
    required this.onUpdateTask,
  }) : super(key: key);

  final TaskModel taskModel;

  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  String dropDownValue = '';
  List<String> statusList = ['New', 'Completed', 'Progress', 'Canceled'];

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(
              'Date: ${widget.taskModel.createdDate}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: _deleteInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            _deleteTask();
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                    Visibility(
                      visible: _editInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.edit),
                        onSelected: (String selectedValue) {
                          dropDownValue = selectedValue;
                          _updateTask(dropDownValue);
                        },
                        itemBuilder: (BuildContext context) {
                          return statusList.map((String value) {
                            return PopupMenuItem<String>(
                              value: value,
                              child: ListTile(
                                title: Text(value),
                                trailing: dropDownValue == value
                                    ? const Icon(Icons.done)
                                    : null,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    if (mounted) {
      setState(() {
        _deleteInProgress = true;
      });
    }
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Delete task failed! try again');
      }
    }
    if (mounted) {
      setState(() {
        _deleteInProgress = false;
      });
    }
  }

  Future<void> _updateTask(String status) async {
    _editInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(widget.taskModel.sId!, status));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Update task status failed! Try again',
        );
      }
    }
    _editInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
