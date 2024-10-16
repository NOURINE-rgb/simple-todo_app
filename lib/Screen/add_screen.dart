import 'package:flutter/material.dart';
import 'package:todo/data/dummy_data.dart';
import 'package:todo/modols/importance.dart';
import 'package:todo/modols/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewItems extends StatefulWidget {
  const NewItems({super.key});

  @override
  State<NewItems> createState() => _NewItemsState();
}

var _importance = const Importance(name: "essential", color: Colors.blue);
String? _date;
String _name = '';
final formKey = GlobalKey<FormState>();
bool isSending = false;

class _NewItemsState extends State<NewItems> {
  void setDAte(BuildContext ctx) async {
    var frst = DateTime.now();
    var lastDate = DateTime(frst.year + 1, frst.month, frst.day);
    final datePicker = await showDatePicker(
        context: ctx, firstDate: frst, lastDate: lastDate, initialDate: frst);
    setState(() {
      _date = formatter.format(datePicker!);
    });
  }

  void saveFun() async {
    if (_date == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Inpute"),
          content: const Text('Please make sure that enter a valid date'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okey'),
            ),
          ],
        ),
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isSending = true;
      });
      final url = Uri.https(
          'fluttertodo-f8173-default-rtdb.firebaseio.com', 'todo.json');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {'name': _name, 'time': _date!, 'important': _importance.name},
        ),
      );
      if (!context.mounted) {
        return;
      }
      final Map<String, dynamic> resData = json.decode(response.body);
      isSending = false;
      Navigator.of(context).pop(
        Task(
            id: resData["name"],
            name: _name,
            time: _date!,
            important: _importance),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text(
                    'the task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "must be between 1 and 50 caracteres";
                  }
                  return null;
                },
                onSaved: (value) => setState(() {
                  _name = value!;
                }),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //   showDatePicker(context: context, firstDate: firstDate, lastDate: lastDate)
                  Expanded(
                    child: DropdownButtonFormField(
                      dropdownColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.95),
                      value: _importance,
                      items: [
                        for (final cat in importance.entries)
                          DropdownMenuItem(
                            value: cat.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: cat.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  cat.value.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _importance = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  // rani lahi m3a error ta3 datepicker ta3 khra
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _date == null ? "No date" : _date!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        IconButton(
                          onPressed: () {
                            setDAte(context);
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isSending
                        ? null
                        : () {
                            formKey.currentState!.reset();
                            setState(() {
                              _date = null;
                            });
                          },
                    child: const Text("Reset"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: isSending ? null : saveFun,
                    //ba9ili on saved nvirifi and pop and nsiit douk natfakar
                    child: isSending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
