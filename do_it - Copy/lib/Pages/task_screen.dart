import 'package:do_it/Pages/quotes.dart';
import "package:do_it/service/db_service.dart";
import "package:flutter/material.dart";

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<Map<String, dynamic>> tasks = [];
  final dbService = Dbservice();

  void editTask(int id) async {
    await dbService.editTask(id, editController.text.trim());
    getTasks();
  }

  void deleteTask(int id) async {
    await dbService.deleteTask(id);
    getTasks();
  }

  getTasks() async {
    final todo = await dbService.getAllTasks();
    tasks = todo;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  final controller = TextEditingController();
  final editController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            "Task Manager",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tasks",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //Qoutes
                TextButton(
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuoteScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Quotes",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a task";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text("Add Task"),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //add task button
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  dbService.addTask(controller.text.trim());
                  controller.clear();
                  getTasks();
                }
              },
              child: const Text(
                "Add Task",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            tasks.isEmpty
                ? Text(
                    "No tasks",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: ListTile(
                              title: Text(
                                tasks[index]["task"],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      deleteTask(tasks[index]["id"]);
                                      getTasks();
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      editController.text =
                                          tasks[index]["task"];
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Edit Task"),
                                            content: TextFormField(
                                              controller: editController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  editTask(tasks[index]["id"]);
                                                  getTasks();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Edit"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
