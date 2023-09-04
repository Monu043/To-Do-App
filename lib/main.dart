import 'package:flutter/material.dart';
import 'package:todo/todo.dart';
import 'package:todo/todomodel.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
  ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final todoslist = ToDo.todolist();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundToDo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'ToDo',
            style: TextStyle(fontStyle: FontStyle.normal,
                 fontSize: 30, color: Colors.black),
          ),
          actions: [CircleAvatar(radius: 20,
          backgroundImage: AssetImage('lib/Monu.jpeg'),
          )
          
          ],
          elevation: 0,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      height: 80,
                      width: double.infinity,
                      child: TextFormField(
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 10),
                      child: Row(
                        children: [
                          Title(
                              color: Colors.black,
                              child: Text(
                                'All ToDos',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    for (ToDo todo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                            hintText: 'Add a new ToDo item',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          _addToDoItem(_todoController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange),
                        child: Text(
                          '+',
                          style: TextStyle(fontSize: 40),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoslist.removeWhere((Element) => Element.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoslist.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoslist;
    } else {
      results = todoslist
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }
}
