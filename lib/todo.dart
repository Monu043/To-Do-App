import 'package:flutter/material.dart';
import 'package:todo/todomodel.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onDeleteItem,
      required this.onToDoChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: Colors.white,
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.green,
          ),
          title: Text(
            todo.todoText!,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: todo.isDone ? TextDecoration.lineThrough : null),
          ),
          trailing: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: Icon(Icons.delete),
            iconSize: 25,
            color: Colors.red,
          )),
    );
  }
}
