import 'package:flutter/material.dart';
import 'package:flutter_tutorials/Counter.dart';
import 'package:flutter_tutorials/ShoppingList.dart';
import 'package:flutter_tutorials/Layout.dart';
import 'package:flutter_tutorials/Product.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MyHomePage(),
    );
  }
}

class  MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePage();
} 

class _MyHomePage extends State<MyHomePage>{
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (selectedIndex) {
      case 0:
        page = Counter(title: "Incrementing");
        break;
      case 1:
        page = ShoppingList(
            products: [
              Product(name: "Chips"),
              Product(name: "Flour"),
              Product(name: "Rice"),
            ],
          );
        break;
      case 2:
        page = MyLayout();
        break;
      case 3:
        page = MyProducts();
        break;
      default:
        throw  UnimplementedError("No widget selected for $selectedIndex");
    }

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("Home"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.shopping_cart),
                  label: Text("Shopping List"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text("Layout"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.production_quantity_limits),
                  label: Text("Product List"),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}
