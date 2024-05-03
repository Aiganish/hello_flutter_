import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> tasks = [];

  void _planTask(String taskDescription) {
    setState(() {
      tasks.add(taskDescription);
    });
  }

  void _Task(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(
          child: Text('Hello Flutter'),
        ),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index]),
            onDismissed: (direction) {
              _Task(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 60.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ListTile(
                title: Text(tasks[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    String taskDescription = 'heloooo';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('plan'),
          content: TextField(
            onChanged: (value) {
              taskDescription = value;
            },
            decoration: InputDecoration(hintText: 'Enter task plan'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () {
                _planTask(taskDescription);
                Navigator.of(context).pop();
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }
}
