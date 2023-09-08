import 'package:flutter/material.dart'; 

class MyProducts extends StatelessWidget {
  const MyProducts({super.key}); 
      
   @override 
    Widget build(BuildContext context) {
      return ListView(
            shrinkWrap: true, padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0), 
            children: <Widget> [
               ProductBox(
                  name: "iPhone", 
                  description: "iPhone is the stylist phone ever", 
                  price: 1000, 
                  image: "iphone.jpeg"
               ), 
               ProductBox(
                  name: "Pixel", 
                  description: "Pixel is the most featureful phone ever", 
                  price: 800, 
                  image: "pixel.jpeg"
               ), 
               ProductBox( 
                  name: "Laptop", 
                  description: "Laptop is most productive development tool", 
                  price: 2000, 
                  image: "laptop.jpeg"
               ), 
               ProductBox( 
                  name: "Tablet", 
                  description: "Tablet is the most useful device ever for meeting", 
                  price: 1500, 
                  image: "tablet.jpeg"
               ), 
               ProductBox(
                  name: "Pendrive", 
                  description: "Pendrive is useful storage medium", 
                  price: 100, 
                  image: "pendrive.jpeg"
               ), 
               ProductBox(
                  name: "Floppy Drive", 
                  description: "Floppy drive is useful rescue storage medium", 
                  price: 20, 
                  image: "floppydisk.jpeg"
               ), 
            ],
        );
    }
}

class ProductBox extends StatelessWidget {
   const ProductBox({super.key, required this.name, required this.description, required this.price, required this.image});
   final String name; 
   final String description; 
   final int price; 
   final String image; 

    void _showDialog(BuildContext context) {
        showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
            title: Text("Product Details"),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Name: $name"),
                Text("Description: $description"),
                Text("Price: $price"),
                ],
            ),
            actions: [
                TextButton(
                onPressed: () {
                    Navigator.of(context).pop();
                },
                child: Text("Close"),
                ),
            ],
            );
        },
        );
    }

   Widget build(BuildContext context) {
      return Container(
         padding: EdgeInsets.all(2), height: 120,  
         child: Card( 
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
               children: <Widget>[                  
                  Image.asset("assets/images/$image"),
                  Expanded(
                     child: Container(
                        padding: EdgeInsets.all(5), 
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                            children: <Widget>[ 
                              
                              Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)), 
                              Text(this.description), 
                              Text("Price: " + this.price.toString()),
                              GestureDetector( 
                                onTap: () { 
                                  _showDialog(context); 
                                }, 
                                child: Text('Hello World',) 
                            )  
                          ], 
                        )
                     )
                  )
               ]
            )
         )
      );
   }
}
