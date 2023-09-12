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
                            child: Text("Lake Victoria", style: TextStyle(
                                fontWeight: FontWeight.bold,
                            )),
                        ),
                        Text("Kampala, Uganda", style: TextStyle(
                            color: Colors.grey[500],
                        )),
                    ],
                ),
            ),
            FavoriteWidget(),
        ],
    ),
);

class FavoriteWidget extends StatefulWidget {
    FavoriteWidget({super.key});

    @override
    State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
    int _favoriteCount = 41;
    bool _isFavorite = true;

    void _tapFavorite() {
        setState(() {
            if (_isFavorite) {
                _favoriteCount--;
                _isFavorite = false;
            } else {
                _favoriteCount++;
                _isFavorite = true;
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: _tapFavorite,
            child: Row(
                children: <Widget>[
                    Container(
                        child: _isFavorite ?
                        Icon(Icons.star, color: Colors.red) : Icon(Icons.star_border),
                    ),
                    SizedBox(
                        width: 18,
                        child: Text("$_favoriteCount"),
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
    MyLayout({super.key});

    Column _buildButtonColumn(IconData icon, Color color, String label) {
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

        return ListView(
            children: [
                Image.asset("assets/images/lake.jpeg", fit: BoxFit.cover),
                title,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        _buildButtonColumn(Icons.call, color, "CALL"),
                        _buildButtonColumn(Icons.near_me, color, "ROUTE"),
                        _buildButtonColumn(Icons.share, color, "SHARE"),
                    ],
                ),
                titleText,
            ],
        );
    }
}
