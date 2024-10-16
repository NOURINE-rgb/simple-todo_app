import 'package:flutter/material.dart';
import 'package:todo/modols/importance.dart';
import 'package:todo/modols/task.dart';

const importance = {
  EnImportance.notessential:
      Importance(color: Colors.deepPurple, name: 'Not essential'),
  EnImportance.essential: Importance(color: Colors.blue, name: 'essential'),
  EnImportance.anytime: Importance(name: 'Anytime', color: Colors.greenAccent),
};
const listImportance = [
  Importance(color: Colors.deepPurple, name: 'Not essential'),
  Importance(color: Colors.blue, name: 'essential'),
  Importance(name: 'Anytime', color: Colors.greenAccent),
];
