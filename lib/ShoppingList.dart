import 'package:flutter/material.dart';

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

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
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
      padding: const EdgeInsets.symmetric(vertical: 32),
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
