// import 'dart:io';
import 'dart:async';
import 'package:queries/collections.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import './editItem.dart' as editScreen;
import './search.dart' as searchScreen;
import './storage.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  return runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Inventory Tracker',
      routes: <String, WidgetBuilder>{
        "/HomeScreen": (BuildContext context) =>new InvTracker(storage: new Storage()),
        "/StatsScreen": (BuildContext context) => new StatsPage(storage: new Storage()),
        "/AboutScreen": (BuildContext context) => new AboutPage(),
        "/SettingsScreen": (BuildContext context) => new SettingsPage(),
        "/ShareScreen": (BuildContext context) => new SharePage(),
        "/AddItemScreen": (BuildContext context) => new AddItem(storage: new Storage()),


      },
      theme: new ThemeData(
        primarySwatch: const MaterialColor(0xFFD37B62,
        const {
          50 : const Color(0xFFefcec6),
          100 : const Color(0xFFe9beb2),
          200 : const Color(0xFFe4ad9e),
          300 : const Color(0xFFde9c8a),
          400 : const Color(0xFFd98c76),
          500 : const Color(0xFFD37B62),
          600 : const Color(0xFFcd6a4e),
          700 : const Color(0xFFc85a3a),
          800 : const Color(0xFFb65033),
          900 : const Color(0xFFa3482d)}
          )
      ),
      home: new InvTracker(storage:new Storage()),
    );
  }
  // final Color maincolor = const Color(0xFFD37B62);
}

class InvTracker extends StatefulWidget {

  final Storage storage;
  final returnText;
  // var index;
 
  InvTracker({Key key,this.returnText,@required this.storage}):super(key: key);

  @override
  State createState() => new InvTrackerState();
}

class InvTrackerState extends State<InvTracker> {
  void _searchSubmit(String content)async{
    if(content!=null && content != ''){
      String newContent = await Navigator.push(context,
        new MaterialPageRoute(
        builder: (context) => new searchScreen.SearchPage(data: content,storage: new Storage())
      ));

      if(newContent is String){
        setState(() {
          _fileContent = newContent;
        });
      }
    }
  }

  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  String _fileContent = '';
  Timer timer;

  @override
  void initState(){
    super.initState();
    widget.storage.readData().then((String content){
      if(content == null) _fileContent = '';
      else{
        setState(() {
          _fileContent = content;
        });
      }
    });

  }


  void _snackBar(String value){
    if(value == '') return;
    _scaffold.currentState.showSnackBar(new SnackBar(
      content: new Text(value, style: new TextStyle(color: Colors.grey[200]),textAlign: TextAlign.center,),
      backgroundColor: Colors.grey[700],
      ));
    Navigator.of(context).pushNamed('/HomeScreen');
  }
 

  Widget build(BuildContext context){
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffold,
      appBar: new AppBar(
        title: new Text("Dashboard")
      ),
      drawer: new Drawer(
        child: new ListView(          
          children: <Widget>[
            new DrawerHeader(
              decoration: new BoxDecoration(
                color: Theme.of(context).accentColor
              ),
              child: new Text("")
            ),
            
            new ListTile(
              onTap: (){ 
                Navigator.pop(context);
              },
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                      child: new Icon(Icons.dashboard, size: 20.0, color: Theme.of(context).accentColor),
                    ),
                    new Text("Dashboard", style: menulist)
                    
                  ],
                )
              ),
            ),
            new ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/StatsScreen");
              },
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                      child: new Icon(Icons.list, size: 20.0, color: Theme.of(context).accentColor),
                    ),
                    new Text("Statistics", style: menulist)
                  ],
                )
              ),
            ),
            new ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/SettingsScreen');
              },
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                      child: new Icon(Icons.settings, size: 20.0, color: Theme.of(context).accentColor),
                    ),
                    new Text("Settings", style: menulist)
                  ],
                )
              ),
            ),
            // new Container(
            //   margin: const EdgeInsets.all(10.0),
            //   child: new Divider(
            //     height: 1.0,
            //     color: Theme.of(context).accentColor
            //   )
            // ),
            new ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/ShareScreen');
                },
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                      child: new Icon(Icons.share, size: 20.0, color: Theme.of(context).accentColor),
                    ),
                    new Text("Share App", style: menulist)
                  ],
                )
              ),
            ),
            new ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/AboutScreen');
                },
              title: new Container(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                      child: new Icon(Icons.info, size: 20.0, color: Theme.of(context).accentColor),
                    ),
                    new Text("About", style: menulist)
                  ],
                )
              ),
            ),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
                child: _search(),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
                child: new Divider(height: 1.0,),
              ),
            ],
          ),
          new Expanded(
            child: _fileContent == '' ? _noItems() : _hasItems()
            // child: _hasItems()
          ),
          new Column(
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 30.0),
                child: _addItemButton(),
              )
            ]
          )
        ],
      ),
    );
  }

  TextStyle tableheader = new TextStyle(
    fontSize: 14.0,
    color: Colors.white
  );

  TextStyle tablebody = new TextStyle(
    fontSize: 16.0,
    color: Colors.grey[800]
  );

  Widget _noItems(){
  
    var _imageContent = new AssetImage('assets/images/treasure.png');
    var _image = new Image(
      image: _imageContent,
      width: 72.0,
      height: 72.0,
    );

    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          child: _image,
        ),
        new Container(
          padding: new EdgeInsets.all(5.0),
          child: new Text("Inventory is empty!",style: new TextStyle(fontSize: 20.0))
        ),
        new Container(
          padding: new EdgeInsets.fromLTRB(5.0,5.0,5.0,100.0),
          // margin: const EdgeInsets.only(bottom: 100.0),
          child: new Text("click on button below to add items",style: new TextStyle(fontSize: 14.0)),
        ),
      ],
    );
  }

  Widget _hasItems(){
    List names(){
      if(_fileContent != '' && _fileContent != null){
        List list = _fileContent.split(',');
        var length = list.length~/4;
        List name = new List(length);
        var j = 0;
        int i = 1;
        for(i;i<list.length;i+=4){
          name[j] = list[i-1];
          j++;
        }
        return name;
      }
      return null;
    }
    List qty(){
      if(_fileContent != '' && _fileContent != null){
        // int index = int.parse(indexStr);
        List list = _fileContent.split(',');
        var length = list.length~/4;
        List qty = new List(length);
        int j = 0;
        int i = 1;
        for(i;i<list.length;i+=4){
          qty[j] = list[i];
          j++;
        }
        return qty;
      }
      return null;
    }
    List category(){
      if(_fileContent != '' && _fileContent != null){
        // int index = int.parse(indexStr);
        List list = _fileContent.split(',');
        var length = list.length~/4;
        List category = new List(length);
        var j = 0;
        int i = 2;
        for(i;i<list.length;i+=4){
          category[j] = list[i];
          j++;
        }
        return category;
      }
      return null;
    }

    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            margin: new EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
            padding: const EdgeInsets.all(10.0),
            child: _tableheader()
          ),

          new Expanded(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: names().length,
              itemExtent: 35.0,
              itemBuilder: (_,int index){
                return new Container(
                  decoration: new BoxDecoration(
                    border: new Border(bottom: new BorderSide(width: 1.0,color: Theme.of(context).accentColor))
                  ),
                  margin: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Flexible(
                        fit: FlexFit.tight,
                        flex: 5,
                        child: new Container(
                          child: new Text(names()[index],style: tablebody,textAlign: TextAlign.left)                          
                        )
                        
                      ),
                      new Flexible(
                        flex: 3,
                        fit:FlexFit.tight,
                        child: new Container(
                          child: new Text(qty()[index], style: tablebody,textAlign: TextAlign.left),)
                        
                      ),
                      new Flexible(
                        flex: 3,
                        fit:FlexFit.tight,
                        child: new Container(
                          child: new Text(category()[index],style: tablebody,textAlign: TextAlign.left),)
                        
                      ),
                      new Flexible(
                        flex: 4,
                        child: new Container(
                          width: 100.0,
                          child: _actionBtns(index),
                        )
                        
                      ),
                    ],
                  ),
                );
                
              }
            ),
          )
        ],
    );

  }
  void updateContent(int index,bool add){
    List all = _fileContent.split(',');
    int newIndex = (index*4)+1;

    if(add) all[newIndex] = (int.parse(all[newIndex])+1).toString();
    else{
      all[newIndex] = (int.parse(all[newIndex])-1).toString();
    }

    String finalContent = all.join(',');
    widget.storage.replaceData(finalContent);
    setState(() {
      _fileContent = finalContent;
    });
  }

  Widget _actionBtns(int index){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(100.0))
              ),
              child: new IconButton(
                padding: const EdgeInsets.all(1.0),
                icon: new Icon(Icons.add),
                color: Theme.of(context).accentColor,
                iconSize: 20.0,
                onPressed: (){
                    updateContent(index,true);
                },
              ),
            )
          ),
          new Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(100.0))
              ),
              child: new IconButton(
                padding: const EdgeInsets.all(1.0),
                icon: new Icon(Icons.remove),
                color: Theme.of(context).accentColor,
                iconSize: 20.0,
                onPressed: (){
                    updateContent(index, false);
                },
              ),
            )
          ),
          new Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: new Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(100.0))
              ),
              child: new IconButton(
                padding: const EdgeInsets.all(1.0),
                icon: new Icon(Icons.edit),
                color: Theme.of(context).accentColor,
                iconSize: 20.0,
                onPressed: ()async{
                    var newContent = await Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new editScreen.EditItem(data: index,storage: new Storage())
                      )
                    );
                    if(newContent is String){
                      setState(() {
                        _fileContent = newContent;
                      });
                    }
                },
              ),
            )
          ),
        ],
      // ),
    );
  }

  Widget _tableheader(){
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
            new Flexible(
              fit: FlexFit.tight,
              
              // color: Colors.blue,
              flex: 1,
              child: new Container(child: new Text('Item Name',style: tableheader,textAlign: TextAlign.center),)
          
        ),
        new Flexible(
              
              // color: Colors.blue,
              flex: 1,
              fit:FlexFit.tight,
              child: new Container(child: new Text('Quantity',style: tableheader,textAlign: TextAlign.center),)
          
        ),new Flexible(
              
              // color: Colors.blue,
              flex: 1,
              fit:FlexFit.tight,
              child: new Container(child: new Text('Category',style: tableheader,textAlign: TextAlign.center),)
          
        ),new Flexible(
              
              // color: Colors.blue,
              flex: 1,
              fit:FlexFit.tight,
              child: new Container(child: new Text('Actions',style: tableheader,textAlign: TextAlign.center,),)
          
        ),
      ],
    );
  }

  Widget _search(){
    TextStyle searchStyle = new TextStyle(
      fontSize: 18.0,
      color: Colors.grey[900]
    );

    TextEditingController _controller = new TextEditingController();

    return new Container(
      margin: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
      decoration: new BoxDecoration(
        color: Colors.grey[200],
        borderRadius: new BorderRadius.circular(50.0),
      ),
      // margin: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new Container(
              padding: new EdgeInsets.fromLTRB(20.0,0.0,15.0,0.0),
               child: new TextField(
                 controller: _controller,
                //  enabled: _fileContent == '' || _fileContent == null ? false : true,
                 style: searchStyle,
                  decoration:
                  new InputDecoration.collapsed(hintText: "search"),
                  onSubmitted: (content){
                    _searchSubmit(content);
                  }
              ),
            )
           
          ),
          new Container(
            child: new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => _searchSubmit(_controller.text),
            ),
          )
        ],
        ),
      );
  }

  Widget _addItemButton(){
    return new FloatingActionButton(
      
      child: new Icon(
        Icons.add,
        color: Colors.white,
        size: 30.0,
      ),
      onPressed: ()async{
        String newContent = await Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new AddItem(storage: new Storage())
        ));
        setState(() {
          if(newContent == 'refresh'){
            widget.storage.readData().then((String content){
                setState(() {
                  _fileContent = content;
                });
            });
          }
        });
      }
    );
  }

}



// Stats Page

class StatsPage extends StatefulWidget{
  final Storage storage;

  StatsPage({Key key,@required this.storage}): super(key:key);

  @override
  State createState() => new StatsPageState();

}

class StatsPageState extends State<StatsPage>{
  String _fileContent;

  @override
  void initState(){
    super.initState();
    widget.storage.readData().then((String content){
      if(content == '' || content == null) _fileContent = '';
      setState(() {
        _fileContent = content;
      });
    });
  }

  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );

  TextStyle statitemsbottom = new TextStyle(
    fontSize: 14.0,
    color: Colors.grey
  );

  @override
  Widget build(BuildContext context){
    List list;

    if(_fileContent!= null && _fileContent != '') list = _fileContent.split(',');

    int getAllItems(){
      if (_fileContent == '' || _fileContent == null) return 1-1;
      return (list.length)~/4;
    }

    List category(){
      if(_fileContent != '' && _fileContent != null){
        var length = list.length~/4;
        List category = new List(length);
        var j = 0;
        int i = 2;
        for(i;i<list.length;i+=4){
          category[j] = list[i];
          j++;
        }
        return category;
      }
      return null;
    }

    int getCategory(){
      if (_fileContent == '' || _fileContent == null) return 1-1;
      else if(list.length <= 4) return 1;
      else{
        List cat = category();
        var result = new Collection(cat).distinct();
        print(result.toList());
        return result.toList().length;
      }
    }
    // bool contains(String element) {
    //   for (E e in this) {
    //     if (e == element) return true;
    //   }
    //   return false;
    // }

    List qty(){
      if(_fileContent != '' && _fileContent != null){
        var length = list.length~/4;
        List qty = new List(length);
        int j = 0;
        int i = 1;
        for(i;i<list.length;i+=4){
          qty[j] = list[i];
          j++;
        }
        return qty;
      }
      return null;
    }

    int outOfStock(){
      if (_fileContent == '' || _fileContent == null) return 1-1;
      int counter = 1;
      qty().forEach((element){
        if(int.parse(element) == 0) counter++;
      });
      return counter-1;
    }

    List lowqty(){
      if(_fileContent != '' && _fileContent != null){
        var length = list.length~/4;
        List lowqty = new List(length);
        int j = 0;
        int i = 3;
        for(i;i<list.length;i+=4){
          lowqty[j] = list[i];
          j++;
        }
        return lowqty;
      }
      return null;
    }

    int getlowqty(){
      if(_fileContent == '' || _fileContent == null) return 1-1;
      var counter = 0;
      for(int i=0;i<lowqty().length;i++){
        if(int.parse(qty()[i]) <= int.parse(lowqty()[i])) counter++;
      }
      return counter;
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Statistics"),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            child: new Divider(
              height: 1.0,
              color: Theme.of(context).accentColor,
            ),
          ),
          new InkWell(
            child: _itemText(),
            onTap: (){Navigator.pop(context);},
          ),
          new Container(
            decoration: new BoxDecoration(
              boxShadow: [new BoxShadow(
                color: Colors.grey[400],
                spreadRadius: 1.0,
                blurRadius: 5.0,
                offset: new Offset(0.0, 3.0)
              )]
            ),
            margin: const EdgeInsets.fromLTRB(30.0,10.0,30.0,10.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 140.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new Container(
                          padding: new EdgeInsets.only(top: 45.0),
                          child: new Column(
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Text(getAllItems().toString(), style: new TextStyle(color: Colors.greenAccent,fontSize: 26.0)),
                                ],
                              ),
                              
                              new Column(
                                children: <Widget>[
                                  new Text("items", style: statitemsbottom)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        width: 1.0,
                        //height: 140.0
                        decoration: new BoxDecoration(
                          color: Theme.of(context).accentColor,
                          border: new Border(
                            right: new BorderSide(
                              width: 1.0,
                              color: Theme.of(context).accentColor
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                        flex:1,
                        child: new Container(
                          padding: new EdgeInsets.only(top: 45.0),
                          child: new Column(
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Text(outOfStock().toString(),style: new TextStyle(color: Theme.of(context).accentColor,fontSize: 26.0)),
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  new Text("out of stock",style: statitemsbottom,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                new Container(
                  child: new Divider(
                    height: 2.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                
                new Container(
                  height: 140.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        flex: 1,
                        child: new Container(
                          padding: new EdgeInsets.only(top: 45.0),
                          child: new Column(
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Text(getlowqty().toString(), style: new TextStyle(color: Colors.yellowAccent[700],fontSize: 26.0)),
                                ],
                              ),
                              
                              new Column(
                                children: <Widget>[
                                  new Text("low qty limit", style: statitemsbottom)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      new Container(
                        width: 1.0,
                        decoration: new BoxDecoration(
                          color: Theme.of(context).accentColor,
                          border: new Border(
                            right: new BorderSide(
                              width: 1.0,
                              color: Theme.of(context).accentColor
                            ),
                          ),
                        ),
                      ),
                      new Expanded(
                        flex:1,
                        child: new Container(
                          padding: new EdgeInsets.only(top: 45.0),
                          child: new Column(
                            children: <Widget>[
                              new Column(
                                children: <Widget>[
                                  new Text(getCategory().toString(),style: new TextStyle(color: Colors.purpleAccent,fontSize: 26.0)),
                                ],
                              ),
                              new Column(
                                children: <Widget>[
                                  new Text("categories",style: statitemsbottom,)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
          ),
          new Expanded(
            child: _bottomBar()
          ),
          
        ],
      ),
    );
  }

  Widget _bottomBar(){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor
          ),
          height: 25.0,
        ),
      ],
    );
  }

  Widget _itemText(){
    TextStyle itemText = new TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      fontFamily: 'Calibri'
    );
    return new Container(
      margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
      child: new Text("All items",style: itemText),
      decoration: new BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: new BorderRadius.all(new Radius.circular(15.0))
      ),
      padding: const EdgeInsets.fromLTRB(13.0,6.0,13.0,6.0),
    );
  }

  // Widget 
  
}


// Share Page

class SharePage extends StatefulWidget{
  @override
  State createState() => new SharePageState();

}

class SharePageState extends State<SharePage>{

  _launchURL() async {
    const url = 'whatsapp.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Share App"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: _shareIcon(),
                  margin: new EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                ),
                new Container(
                  child: _arrowIcon(),
                  margin: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                ),
                new Container(child: _peopleIcon(),
                  margin: new EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                )
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: new Divider(height: 1.0,color: Theme.of(context).accentColor)
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new InkWell(
                  child: new Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                    child: new Text("Share with WhatsApp",style: topshare,textAlign: TextAlign.left),
                  ),
                  // onTap: (){
                  //   _launchURL();
                  // },
                )
              ],
            )
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
            child: new Divider(height: 1.0,color: Theme.of(context).accentColor)
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new InkWell(
                  child: new Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                    child: new Text("Share with Email",style: topshare,textAlign: TextAlign.left),
                  ),
                  // onTap: (){
                  //   _launchURL();
                  // },
                )
              ],
            )
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: new Divider(height: 1.0,color: Theme.of(context).accentColor)
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                  decoration: new BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                  child: new Text("Special Offer*",style: new TextStyle(color: Colors.white,fontSize: 16.0)),
                ),
                new Container(
                  child: new Divider(height: 1.0,color: Theme.of(context).accentColor)
                )
              ],
            ),
            
          ),
          new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(25.0, 5.0, 1.0, 5.0),
                child: new Text("Check other apps from us")
              ),
              new Container(
                child: new InkWell(
                  child: new Text('here',style: new TextStyle(color: Colors.blue),),
                  onTap: () => null
                ),
              )
            ],
           
          ),
          new Expanded(
            child: _bottomBar(),
          )
        ],
      ),
    );
  }

  TextStyle topshare = new TextStyle(
    fontSize: 20.0,
  );

  TextStyle bottomshare = new TextStyle(
    fontSize: 15.0
  );

  Widget _bottomBar(){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor
          ),
          height: 25.0,
        ),
      ],
    );
  }

  Widget _shareIcon(){
    return new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 40.0),
      padding: const EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: new BorderRadius.all(new Radius.circular(100.0))
      ),
      child: new IconButton(
        icon: new Icon(Icons.share),
        color: Colors.white,
        iconSize: 40.0,
        onPressed: () => null,
      ),
    );
  }
  Widget _arrowIcon(){
    return new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 40.0),
      padding: const EdgeInsets.all(0.0),
      child: new IconButton(
        icon: new Icon(Icons.arrow_forward),
        color: Theme.of(context).accentColor,
        iconSize: 40.0,
        onPressed: () =>null,
      ),
    );
  }

  Widget _peopleIcon(){
    return new Container(
      margin: new EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 40.0),
      padding: const EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: new BorderRadius.all(new Radius.circular(100.0))
      ),
      child: new IconButton(
        icon: new Icon(Icons.people),
        color: Colors.white,
        iconSize: 30.0,
        onPressed: () => null,
      ),
    );
  }

  
  
}


// Settings Page

class SettingsPage extends StatefulWidget{
  @override
  State createState() => new SettingsPageState();

}

class SettingsPageState extends State<SettingsPage>{
  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  void _snackBar(String value){
    _scaffold.currentState.showSnackBar(new SnackBar(
      content: new Text(value, style: new TextStyle(color: Colors.grey[200]),textAlign: TextAlign.center,),
      backgroundColor: Colors.grey[700],
      ));
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      key: _scaffold,
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 0.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: 100.0,
                  padding: new EdgeInsets.fromLTRB(15.0, 8.0, 5.0, 8.0),
                  decoration: new BoxDecoration(
                    color: Theme.of(context).accentColor
                  ),
                  child: new Text("Backup",style: new TextStyle(color:Colors.white,fontSize: 16.0)),
                ),
                new Container(
                  child: new Divider(height: 1.0,color: Theme.of(context).accentColor),
                )
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 20.0),
            child: new InkWell(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new Text("Save data",style: topshare,textAlign: TextAlign.left),
                  ),
                  new Text("Save your data in your SD card", style: bottomshare,textAlign: TextAlign.left)
                ],
              ),
              onTap: (){
                _snackBar('Data has been saved successfully!');
              },
            )
          ),
          // new Container(
          //   margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
          //   child: new Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       new Container(
          //         width: 100.0,
          //         padding: new EdgeInsets.fromLTRB(10.0, 8.0, 5.0, 8.0),
          //         decoration: new BoxDecoration(
          //           color: Theme.of(context).accentColor
          //         ),
          //         child: new Text("Notification",style: new TextStyle(color:Colors.white,fontSize: 16.0)),
          //       ),
          //       new Container(
          //         child: new Divider(height: 1.0,color: Theme.of(context).accentColor),
          //       )
          //     ],
          //   ),
          // ),
          // new Container(
          //   margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
          //   child: new Row(
          //     children: <Widget>[
          //       new Checkbox(
          //         onChanged: null,
          //         value: true,
          //       ),
          //       new Text("Enable Low Qty Reminder",style: new TextStyle(fontSize: 20.0)),
          //     ],
          //   ), 
          // ),
          // new Container(
          //   margin: new EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
          //   child: new Row(
          //     children: <Widget>[
          //       new Checkbox(
          //         onChanged: null,
          //         value: false,
          //       ),
          //       new Text("Enable Out of Stock Reminder",style: new TextStyle(fontSize: 20.0)),
          //     ],
          //   ), 
          // ),
          new Expanded(
            child: _bottomBar()
          ),
        ],
      )
    );
  }
  
  TextStyle topshare = new TextStyle(
    fontSize: 20.0,
  );

  TextStyle bottomshare = new TextStyle(
    fontSize: 15.0
  );

  Widget _bottomBar(){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor
          ),
          height: 25.0,
        ),
      ],
    );
  }
  
}


// About Page

class AboutPage extends StatefulWidget{
  @override
  State createState() => new AboutPageState();

}

class AboutPageState extends State<AboutPage>{
  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );

  @override
  Widget build(BuildContext context){
    var imageContent = new AssetImage('assets/images/treasure.png');
    var image = new Image(
      image: imageContent,
      width: 72.0,
      height: 72.0,
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("About"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 50.0),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 5.0),
                        child: new Text("Inventory Tracker",style: inventtext,),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(bottom: 5.0),
                        child: new Text("Version 1.0",style: othertext),
                      ),
                      new Container(
                        margin: new EdgeInsets.only(bottom: 7.0),
                        child: image,
                      ),
                      new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Icon(
                              Icons.copyright,
                              color: Colors.grey,
                              size: 16.0,
                            ),
                            new Text(" 2018",style: othertext)
                          ],
                        )
                      ),
                      new Container(
                        child: new Text('All rights reserved',style: othertext),
                      )
                    ],
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.all(3.0),
                        child: new Text('For help and feedback, send us a mail',style: feedbacktext),
                      ),
                      // new Container(
                      //   padding: new EdgeInsets.all(3.0),
                      //   child: new Text(''),
                      // ),
                      new Container(
                        margin: new EdgeInsets.all(0.0),
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: new FlatButton(
                          padding: const EdgeInsets.all(0.0),
                          // color: null,
                          child: new Text('info@inventorytracker.com',style: new TextStyle(color: Colors.blue,fontSize: 15.0)),
                          onPressed: null,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child: _bottomBar(),
          )
        ],
      ),
 
    );
  }

  TextStyle inventtext = new TextStyle(
    color: Colors.brown,
    fontSize: 27.0
  );

  TextStyle othertext = new TextStyle(
    color: Colors.grey,
    fontSize: 16.0
  );

  TextStyle feedbacktext = new TextStyle(
    color: Colors.grey[600],
    fontSize: 13.0
  );

  Widget _bottomBar(){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor
          ),
          height: 25.0,
        ),
      ],
    );
  }
  
}

class AddItem extends StatefulWidget{
  final Storage storage;

  AddItem({Key key,@required this.storage}):super(key: key);

  @override
  State createState() => new AddItemState();
}

class AddItemState extends State<AddItem>{
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  String _fileContent;

  void _snackBar(String value){
    _scaffold.currentState.showSnackBar(new SnackBar(
      content: new Text(value, style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
      backgroundColor: Colors.red[900],
    ));
  }


  @override
  void initState(){
    super.initState();
    widget.storage.readData().then((String content){
      setState(() {
        _fileContent = content;
      });
    });
  }

  void _showAlert(){
    AlertDialog dialog = new AlertDialog(
      content: new Text('Item added successfully!',
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 20.0),),
      actions: <Widget>[
        new FlatButton(
          child: new Text('CONTINUE'),
          onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context,'refresh');
          },
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }

  void _showError(){
    AlertDialog dialog = new AlertDialog(
      content: new Text('Please fill out all fields',
      textAlign: TextAlign.center,
      style: new TextStyle(fontSize: 18.0),),
      actions: <Widget>[
        new FlatButton(
          child: new Text('OK'),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }

  bool itemExist(String string){
      if(_fileContent != '' && _fileContent != null){
        // int index = int.parse(indexStr);
        List list = _fileContent.split(',');
        var length = list.length~/4;
        List name = new List(length);
        var j = 0;
        int i = 1;
        bool exist = false;
        for(i;i<list.length;i+=4){
          name[j] = list[i-1];
          j++;
        }
        name.forEach((element){
          if(element == string) exist = true;
        });
        return exist;
      }
      return false;
    }

  TextEditingController _itemcon = new TextEditingController();
  TextEditingController _qtycon = new TextEditingController();
  TextEditingController _catcon = new TextEditingController();
  TextEditingController _lowqtycon = new TextEditingController();

  @override
  void dispose(){
    _itemcon.dispose();
    _qtycon.dispose();
    _catcon.dispose();
    _lowqtycon.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    return new Scaffold(
      key: _scaffold,
      appBar: new AppBar(
        title: new Text('Add Item'),
        actions: <Widget>[
          new IconButton(
            padding: new EdgeInsets.only(right: 25.0),
            icon: new Icon(Icons.check,color: Colors.white,),
            iconSize: 35.0,
            onPressed: (){
              if(_itemcon.text == '' || _qtycon.text == '' || _catcon.text == '' || _lowqtycon.text == '') _showError();
              else if(int.parse(_qtycon.text) < int.parse(_lowqtycon.text)) _snackBar('Quantity cannot be less than Low Quantity Limit');
              else if(itemExist(_itemcon.text)) _snackBar('Item already exists!');
              else{
                var content = _itemcon.text+','+_qtycon.text+','+_catcon.text+','+_lowqtycon.text+',';
                widget.storage.writeData(content);
                _showAlert();
              }
                

            }
          )
        ],
      ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 8.0),
            padding: new EdgeInsets.fromLTRB(5.0,0.0,8.0,5.0),
            decoration: new BoxDecoration(
              border: new Border(bottom: new BorderSide(width: 0.5,color: Colors.grey))
            ),
            child: new TextField(
              controller: _itemcon,
              autofocus: true,
              style: searchStyle,
                decoration: new InputDecoration.collapsed(
                  hintText: "Item Name",
                hintStyle: new TextStyle(fontSize: 16.0)
                ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 8.0),
            padding: new EdgeInsets.fromLTRB(5.0,0.0,8.0,5.0),
            decoration: new BoxDecoration(
              border: new Border(bottom: new BorderSide(width: 0.5,color: Colors.grey))
            ),
            child: new TextField(
              keyboardType: TextInputType.number,
              controller: _qtycon,
              style: searchStyle,
                decoration: new InputDecoration.collapsed(
                hintText: "Quantity",
                hintStyle: new TextStyle(fontSize: 16.0)
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 8.0),
            padding: new EdgeInsets.fromLTRB(5.0,0.0,8.0,5.0),
            decoration: new BoxDecoration(
              border: new Border(bottom: new BorderSide(width: 0.5,color: Colors.grey))
            ),
            child: new TextField(
              controller: _catcon,
              style: searchStyle,
                decoration: new InputDecoration.collapsed(
                hintText: "Category",
                hintStyle: new TextStyle(fontSize: 16.0)
              ),
            ),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 8.0),
            padding: new EdgeInsets.fromLTRB(5.0,0.0,8.0,5.0),
            decoration: new BoxDecoration(
              border: new Border(bottom: new BorderSide(width: 0.5,color: Colors.grey))
            ),
            child: new TextField(
              controller: _lowqtycon,
              keyboardType: TextInputType.number,
              style: searchStyle,
                decoration: new InputDecoration.collapsed(
                hintText: "Low Qty limit",
                hintStyle: new TextStyle(fontSize: 16.0)
              ),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                width: 80.0,
                height: 30.0,
                margin: new EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(100.0),
                  color: Theme.of(context).accentColor
                ),
                child: new FlatButton(
                  child: new Text('cancel',style: new TextStyle(fontSize: 14.0,color: Colors.white),),
                  onPressed: () {Navigator.pop(context);},
                  // color: Theme.of(context).accentColor,
                  padding: const EdgeInsets.all(0.0),
                  
                  
                ),
              )
              
            ],
          )
        ],
      ),
    ],
  )
  );
  }

  TextStyle searchStyle = new TextStyle(
      fontSize: 18.0,
      color: Colors.grey[900]
    );

  Widget _bottomBar(){
    return new Column(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.all(5.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).accentColor
          ),
          height: 25.0,
        ),
      ],
    );
  }
}


