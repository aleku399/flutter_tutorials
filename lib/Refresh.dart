import 'package:flutter/material.dart';

class Item {
    Item({
        required this.title,
        required this.isChecked,
        required this.id,
    });

    String title;
    bool isChecked;
    int id;

    Item addTodo(bool isChecked) {
        return Item(
            title: this.title,
            isChecked: isChecked ?? this.isChecked,
            id: this.id,
        );
    }
}

class CustomButton extends StatelessWidget {
    CustomButton({super.key, required this.title, required this.onTap});

    String title;
    VoidCallback onTap;

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: onTap,
            child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.grey[500],
                child: Text(
                    title,
                ),
            ),
        );
    }
}

class CheckMark extends StatelessWidget {
    CheckMark({super.key, required this.isChecked, required this.isDone});

    bool isChecked;
    VoidCallback isDone;

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: isDone,
            child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: isChecked ? Colors.blue : Colors.white30,
                    borderRadius: BorderRadius.circular(50),
                ),
                child: SizedBox(
                    width: 10,
                    height: 10,
                    child: isChecked ? Center(child: Icon(Icons.check),) : null,
                ),
            ),
        );
    }
}

class TodoItem extends StatelessWidget {
    TodoItem({super.key, required this.item, required this.onChecked, required this.onRemove });

    dynamic item;
    Function(dynamic item) onChecked;
    Function(dynamic item) onRemove;

    @override
    Widget build(BuildContext context) {
        return ListTile(
            leading: CheckMark(
                isChecked: item.isChecked,
                isDone: () => onChecked(item),
            ),
            title: Text(
                item.title
            ),
            trailing: FloatingActionButton(
                onPressed: () => onRemove(item),
                backgroundColor: Colors.white30,
                child: Icon(Icons.close),
            ),
            
        );
        // return Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //         CheckMark(
        //             isChecked: item.isChecked,
        //             isDone: () => onChecked(item),
        //         ),
        //         SizedBox(
        //             width: 20,
        //         ),
        //         Text(
        //             item.title,
        //         ),
        //         SizedBox(
        //             width: 20,
        //         ),
        //         Expanded(
        //             child: Center(
        //                 child:  Padding(
        //                     padding: EdgeInsets.symmetric(horizontal: 2),
        //                     child: FloatingActionButton(
        //                         onPressed: () => onRemove(item),
        //                         backgroundColor: Colors.white30,
        //                         child: Icon(Icons.close),
        //                     ),
        //                 ),
        //             ),
        //         ),
        //     ],
        // );        
    }
}

class TodoApp extends StatefulWidget {
    TodoApp({super.key});

    State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
    final myController = TextEditingController();
    int _nextId = 0;

    var _items = [
        Item(
            title: "Learn Flutter",
            isChecked: false,
            id: 0
        )
    ];

    @override
    void dispose() {
        myController.dispose();
        super.dispose();
    }

    _addTodo() {
        setState(() {
            _nextId++;
            _items = [
                ..._items,
                Item(
                    title: myController.text,
                    isChecked: false,
                    id: _nextId,
                ),
            ];
        });
        myController.clear();
        FocusManager.instance.primaryFocus?.unfocus();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a Todo",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              CustomButton(
                title: "Add Todo",
                onTap: _addTodo,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
                padding: EdgeInsets.symmetric(vertical: 32),
                children: _items.map((item) {
                    return TodoItem(
                        item: item,
                        onChecked: (item) {
                            setState(() {
                                _items = _items.map((existingItem) {
                                    if (item.id == existingItem.id) {
                                        return existingItem.addTodo(!existingItem.isChecked);
                                    } else {
                                        return existingItem;
                                    }
                                }).toList();
                            });
                        },
                        onRemove: (item) {
                            setState(() {
                                _items = _items.where((existingItem) {
                                    return existingItem.id != item.id;
                                }).toList();
                            });
                        }
                    );
                }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
