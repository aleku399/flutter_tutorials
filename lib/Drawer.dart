import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  DrawerContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black54,
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        '''
        Neque porro quisquam est qui dolorem
        ipsum quia dolor sit amet, consectetur,
        adipisci velit...
        ''',
      ),
    );
  }
}

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late double _opacityValue;

  @override
  void initState() {
    super.initState();
    _opacityValue = 0.0;
  }

  void showContent() {
    setState(() {
      _opacityValue = _opacityValue == 0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Stack(
              children: <Widget>[
                  AnimatedPositioned(
                  duration: Duration(milliseconds: 500),
                  left:  _opacityValue == 0 ? -400 : 0,
                  top: 0,
                  child:  AnimatedOpacity(
                        opacity: _opacityValue,
                        duration: Duration(seconds: 2),
                        child: DrawerContent(),
                    ),
                ),
                AnimatedPositioned(
                  left: _opacityValue == 0 ? 0 : 300,
                  top: 0,
                  duration: Duration(milliseconds: _opacityValue == 0 ? 500 : 400),
                  child: GestureDetector(
                    onTap: showContent,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.drag_indicator),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
