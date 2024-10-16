import 'package:flutter/material.dart';
import 'package:todo/modols/task.dart';

class DisplayTask extends StatefulWidget {
  const DisplayTask(this.task, {super.key});
  final Task task;

  @override
  State<DisplayTask> createState() => _DisplayTaskState();
}

class _DisplayTaskState extends State<DisplayTask> {
  var doo = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: doo,
          onChanged: (value) {
            setState(() {
              doo = value!;
            });
          }),
      title: Text(
        widget.task.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(widget.task.time,
       style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      trailing: Icon(
        Icons.discount,
        color: widget.task.important!.color,
      ),
    );
  }
}
