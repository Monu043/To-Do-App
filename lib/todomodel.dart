

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todolist() {
    return [
      ToDo(id: '01', todoText: 'Gym', isDone: true),
      ToDo(id: '02', todoText: 'Gaming', isDone: true),
      ToDo(id: '03', todoText: 'Shopping'),
      ToDo(id: '04', todoText: 'Study'),
      ToDo(id: '05', todoText: 'Extra Classes'),
      ToDo(id: '06', todoText: 'Drink Water'),
    ];
  }
}
