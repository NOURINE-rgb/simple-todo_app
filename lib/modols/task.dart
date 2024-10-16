import 'package:intl/intl.dart';
import 'package:todo/modols/importance.dart';

DateFormat formatter = DateFormat.yMd();

enum EnImportance { essential, notessential, urgency, anytime }

class Task {
  const Task(
      {required this.id,
      required this.name,
      required this.time,
      required this.important});
  final String id;
  final String name;
  final String time;
  final Importance? important;
}
