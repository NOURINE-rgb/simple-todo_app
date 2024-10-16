import 'package:flutter/material.dart';
import 'package:todo/Screen/add_screen.dart';
import 'package:todo/Screen/date_now.dart';
import 'package:todo/Screen/display_task.dart';
import 'package:todo/data/dummy_data.dart';
import 'package:todo/modols/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool error = false;
  late Future<List<Task>> loadedItems;
  List<Task> tasks = [];
  @override
  void initState() {
    super.initState();
    loadedItems = _loadItems();
  }

  Future<List<Task>> _loadItems() async {
    final url =
        Uri.https('fluttertodo-f8173-default-rtdb.firebaseio.com', 'todo.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      throw Exception();
    }
    if (response.body == "null") {
      return [];
    }
    Map<String, dynamic> loadedItems = json.decode(response.body);
    final List<Task> tempTasks = [];
    for (final item in loadedItems.entries) {
      tempTasks.add(
        Task(
          id: item.key,
          name: item.value["name"],
          time: item.value["time"],
          important: listImportance.firstWhere(
            (element) => element.name == item.value["important"],
          ),
        ),
      );
    }
    tasks = tempTasks;
    return tempTasks;
  }

  void removeTask(Task task) async {
    final index = tasks.indexOf(task);
    setState(() {
      tasks.remove(task); // nzid ta3 undo
    });
    final url = Uri.https('fluttertodo-f8173-default-rtdb.firebaseio.com',
        'todo/${task.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        tasks.insert(index, task);
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
            content: const Text(
                "Failed to connect to a back-end. Please try again later."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okey"),
              ),
            ],
          ),
        );
        // error = "Failed to connect to database";
      });
    }
  }

  void addTask() async {
    final task = await Navigator.of(context).push<Task>(
      MaterialPageRoute(
        builder: (context) => const NewItems(),
      ),
    );
    if (task == null) {
      return;
    }
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDayDo"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const DateNow(),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
                  // constraints:const BoxConstraints(minWidth: double.infinity),
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: FutureBuilder(
                    future: loadedItems,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Task added yet',
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Dismissible(
                          onDismissed: (direction) => removeTask(snapshot.data![index]),
                          key: ValueKey(snapshot.data![index].id),
                          background: Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: DisplayTask(snapshot.data![index]),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 22,
                  child: FloatingActionButton(
                    onPressed: addTask,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    child: const Icon(
                      Icons.add,
                      size: 34,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// rani m3a les errors habloni hada mkan