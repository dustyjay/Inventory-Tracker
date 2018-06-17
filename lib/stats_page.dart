import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget{
  @override
  State createState() => new StatsPageState();

}

class StatsPageState extends State<StatsPage>{
  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Statistics"),
      ),
      // drawer: new Drawer(
      //   child: new ListView(          
      //     children: <Widget>[
      //       new DrawerHeader(
      //         decoration: new BoxDecoration(
      //           color: Colors.brown[400]
      //         ),
      //         child: new Text("")
      //       ),
            
      //       new ListTile(
      //         onTap: (){ Navigator.pop(context);
      //           Navigator.of(context).pushNamed('/HomeScreen');
      //         },
      //         title: new Container(
      //           child: new Row(
      //             children: <Widget>[
      //               new IconButton(
      //                 icon: new Icon(Icons.dashboard),
      //                 iconSize: 20.0,
      //                 color: Colors.brown,
      //                 onPressed: (){},
      //               ),
      //               new Text("Dashboard", style: menulist)
                    
      //             ],
      //           )
      //         ),
      //       ),
      //       new ListTile(
      //         onTap: (){ Navigator.pop(context);
      //           Navigator.of(context).pushNamed("/StatsScreen");
      //         },
      //         title: new Container(
      //           child: new Row(
      //             children: <Widget>[
      //               new IconButton(
      //                 icon: new Icon(Icons.gradient),
      //                 iconSize: 20.0,
      //                 color: Colors.brown,
      //                 onPressed: (){},
      //               ),
      //               new Text("Statistics", style: menulist)
      //             ],
      //           )
      //         ),
      //       ),
      //       new ListTile(
      //         onTap: (){ Navigator.pop(context);
      //           Navigator.of(context).pushNamed('/SettingsScreen');
      //         },
      //         title: new Container(
      //           child: new Row(
      //             children: <Widget>[
      //               new IconButton(
      //                 icon: new Icon(Icons.settings),
      //                 iconSize: 20.0,
      //                 color: Colors.brown,
      //                 onPressed: (){},
      //               ),
      //               new Text("Settings", style: menulist)
      //             ],
      //           )
      //         ),
      //       ),
      //       new Container(
      //         margin: const EdgeInsets.all(10.0),
      //         child: new Divider(
      //           height: 1.0,
      //           color: Colors.brown
      //         )
      //       ),
      //       new ListTile(
      //         onTap: (){ Navigator.pop(context);
      //           Navigator.of(context).pushNamed('/ShareScreen');
      //           },
      //         title: new Container(
      //           child: new Row(
      //             children: <Widget>[
      //               new IconButton(
      //                 icon: new Icon(Icons.share),
      //                 iconSize: 20.0,
      //                 color: Colors.brown,
      //                 onPressed: (){},
      //               ),
      //               new Text("Share App", style: menulist)
      //             ],
      //           )
      //         ),
      //       ),
      //       new ListTile(
      //         onTap: (){ Navigator.pop(context);
      //           Navigator.of(context).pushNamed('/AboutScreen');
      //           },
      //         title: new Container(
      //           child: new Row(
      //             children: <Widget>[
      //               new IconButton(
      //                 icon: new Icon(Icons.info),
      //                 iconSize: 20.0,
      //                 color: Colors.brown,
      //                 onPressed: (){},
      //               ),
      //               new Text("About", style: menulist)
      //             ],
      //           )
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
  
}