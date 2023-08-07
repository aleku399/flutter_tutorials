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
      home: MyHomePage(title: "Title"),
    );
  }
}

class Product {
  Product({required this.name});

  final String name;
}

typedef CartChangedCallBack = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.onCartChanged,
    required this.inCart,
  }): super(key: ObjectKey(product));

  final Product product;
  final CartChangedCallBack onCartChanged;
  final bool inCart;

  Color _getBackgroundColor(BuildContext context) {

    return inCart ? Colors.black54: Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) {
      return null;
    }

    return  const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () { 
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getBackgroundColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({required this.products, super.key});

  final List<Product> products;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final _items = <Product>{};

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _items.remove(product);
      } else {
        _items.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: widget.products.map((product) {
        return ShoppingListItem(
          product: product,
          onCartChanged: _handleCartChanged,
          inCart: _items.contains(product),
        );
      }).toList(),
    );
  }
}

class  MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePage();
} 

class _MyHomePage extends State<MyHomePage>{
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
            SizedBox(height: 10),
            Expanded(
              child: ShoppingList(
                products: [
                  Product(name: "Chips"),
                  Product(name: "Flour"),
                  Product(name: "Rice"),
                ],
              ),
            ),
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
