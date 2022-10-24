import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _TaskController = TextEditingController();
  List<Map> _taskList = [
    {
      "title": "complete js project within one week",
      "doneTaskFlag": false,
    },
    {
      "title": "start learning node js as soon as possible",
      "doneTaskFlag": false,
    },
  ];
  bool _doneTask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_task_outlined),
        onPressed: (){
          _TaskController.clear();
          _buildShowDialog();
        },
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
          child: ListTile(
            leading: Icon(_taskList[index]["doneTaskFlag"]
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank),
            title: Text(
              "${_taskList[index]["title"]}",
              style: _taskList[index]["doneTaskFlag"]
                  ? TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough)
                  : TextStyle(color: Colors.black),
            ),
            onTap: () {
              setState(() {
                _taskList[index]["doneTaskFlag"] =
                    !_taskList[index]["doneTaskFlag"];
              });
            },
          ),
        );
      },
    );
  }

  Future _buildShowDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              TextField(
                controller: _TaskController,
                // textAlign: TextAlign.center,
                autofocus: true,
                maxLength: 25,
                onSubmitted: (value){
                  _saveNewTask();
                },
              ),
              SizedBox(height: 15),
              TextButton(onPressed: _saveNewTask, child: Text("Save"))
            ],
          ),
        );
      },
    );
  }

  _saveNewTask() {
    (_TaskController.text != "")
        ? setState(() {
            _taskList
                .add({"title": _TaskController.text, "doneTaskFlag": false});
            _TaskController.clear();
            Navigator.pop(context);
          })
        : Navigator.pop(context);
  }
}
