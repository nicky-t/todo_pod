import 'package:todo_pod_client/todo_pod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo pod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Serverpod Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String _errorMessage = '';
  List<Todo> todos = [];
  int? selectedTodoId;

  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllTodo();
  }

  Future<void> getAllTodo() async {
    try {
      final res = await client.todo.getAllTodos();
      setState(() {
        todos = [...res];
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> addTask() async {
    try {
      await client.todo.addTodo(
        todo: Todo(
          name: _textEditingController.text,
          isDone: false,
        ),
      );

      await getAllTodo();
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await client.todo.updateTodo(
        todo: Todo(
          id: todo.id,
          name: todo.name,
          isDone: !todo.isDone,
        ),
      );
      await getAllTodo();
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await client.todo.deleteTodo(id: id);
      setState(() {
        selectedTodoId = null;
      });
      await getAllTodo();
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: addTask,
                child: const Text('新しいタスクを作成'),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, i) {
                  final todo = todos[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          selectedTodoId = todo.id;
                        });
                      },
                      title: Text(todo.name),
                      tileColor: Colors.white70,
                      selected: todo.id == selectedTodoId,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Colors.black12),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          updateTodo(todo);
                        },
                        icon: Icon(
                          Icons.check_box,
                          color: todo.isDone ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (selectedTodoId != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    deleteTodo(selectedTodoId!);
                  },
                  child: const Text('タスクの削除'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
