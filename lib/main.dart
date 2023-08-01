import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dropdown Menu'),
    );
  }
}

class MenuOption {
  final String title;
  final Function() onPressed;

  MenuOption({required this.title, required this.onPressed});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedOption = 'All';
  List<String> options = ['All', 'Rice', 'Beef', 'Chicken'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton<MenuOption>(
            onSelected: (option) {
              option.onPressed();
            },
            itemBuilder: (BuildContext context) {
              return options.map((option) {
                return PopupMenuItem<MenuOption>(
                  value: MenuOption(
                    title: option,
                    onPressed: () {
                      setState(() {
                        selectedOption = option;
                      });
                    },
                  ),
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Option: $selectedOption',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
