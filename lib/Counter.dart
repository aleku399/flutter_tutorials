import 'package:flutter/material.dart';

class  Counter extends StatefulWidget {
  final String title;

  Counter({super.key, required this.title});

  @override
  State<Counter> createState() => _CounterState();
} 

class _CounterState extends State<Counter>{
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButton(
          icon: Icon(Icons.menu),
          tooltip: "Navigation Menu",
          onPressed: null,
        ),
        title: Text(widget.title),
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "Search",
            onPressed: null,
          ),
        ],
      ), 
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
              print("Hello World");
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightGreen[500],
              ),
                child: Center(
                  child: Text("Hello World"),
                ),
              ),
            ),
            Text("You have incremented ${_count}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
    );
  }
}
