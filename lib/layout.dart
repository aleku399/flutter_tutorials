import 'package:flutter/material.dart';

final title = Container(
  padding: EdgeInsets.all(32),
    child: Row(
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Lake Victoria',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kampala, Uganda',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      FavoriteWidget(),
    ],
  ),
);

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  
  bool _isFavorite = true;
  int _favoriteCount = 41;

  void _favoriteTap() {
    setState(() {
      if(_isFavorite) {
        _isFavorite = false;
        _favoriteCount -= 1;
      } else {
        _isFavorite = true;
        _favoriteCount += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: _favoriteTap,
      child: Row(
        children: [
          Icon(
            _isFavorite ? Icons.star : Icons.star_border,
            color: Colors.red[500]
          ),
          SizedBox(
            width: 18,
            child: SizedBox(
              child: Text('$_favoriteCount'),
            ),
          ),
        ],
      ),
    );
  }
}

final titleText = Container(
  padding: EdgeInsets.all(32),
  child: Text('''
  Lake Victoria is one of the African Great Lakes. 
  With a surface area of approximately 59,947 km2 (23,146 sq mi),[6][7]
  Lake Victoria is Africa's largest lake by area, the world's largest tropical lake,[8] 
  and the world's second-largest fresh water lake by surface area after Lake Superior in North America.
  ''',
  softWrap: true,
  ),
);


class MyLayout extends StatelessWidget {
  const  MyLayout({super.key});

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        Container(
          padding: EdgeInsets.only(top: 9),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

  Color color = Theme.of(context).primaryColor;

  Widget buttonSection = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      _buildButtonColumn(color, Icons.call, 'Call'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  );

  return ListView(
        children: <Widget>[
            Image.asset('assets/images/lake.jpeg', width: 600, fit: BoxFit.cover),
            title,
            buttonSection,
            titleText,
        ]
    );
  }
}
