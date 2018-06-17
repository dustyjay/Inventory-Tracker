import 'package:flutter/material.dart';

import './storage.dart';
import './editItem.dart' as editScreen;

class SearchPage extends StatefulWidget{
  final data;
  final Storage storage;

  SearchPage({Key key,this.data,this.storage}): super(key: key);

  @override
  State createState() => new SearchPageState();

}

class SearchPageState extends State<SearchPage>{

  String _fileContent;
  String search;
  int no;
  String status = '';
  List name;
  List quantity;
  List cat;
  List lowQty;

  List qty(){
    if(_fileContent.isNotEmpty && _fileContent != null){
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
  List itemName(){
    if(_fileContent.isNotEmpty && _fileContent != null){
      // int index = int.parse(indexStr);
      List list = _fileContent.split(',');
      var length = list.length~/4;
      List qty = new List(length);
      int j = 0;
      int i = 1-1;
      for(i;i<list.length;i+=4){
        qty[j] = list[i];
        j++;
      }
      return qty;
    }
    return null;
  }
  List lowqty(){
    if(_fileContent != '' && _fileContent != null){
      List list = _fileContent.split(',');
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
  List category(){
    if(_fileContent.isNotEmpty && _fileContent != null){
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
  


  @override
  void initState(){
    super.initState();
    widget.storage.readData().then((String content){
      if(content == null) _fileContent = '';
      else{
        setState(() {
          _fileContent = content;
          no = 1-1;
          search = widget.data;
          List list = _fileContent.split(',');
          var length = list.length~/4;
          List nameOfItem = new List(length);
          var j = 0;
          int i = 1;
          for(i;i<list.length;i+=4){
            nameOfItem[j] = list[i-1];
            j++;
          }
          
          nameOfItem.forEach((element){
            if(element == search || element.startsWith(search)){
              no++;
            }
          });

          if(no > 0){
            name = new List(no);
            quantity = new List(no);
            cat = new List(no);

            int counter = 1-1;

            for(int a=0;a<=nameOfItem.length;a++){
              if(nameOfItem[a] == search || nameOfItem[a].startsWith(search)){
                name[counter] = nameOfItem[a];
                quantity[counter] = qty()[a];
                cat[counter] = category()[a];
                counter++;
              }
            }
          }
          else{
            status = "No Item Match";
          }

        });
      }
    });
  }

  
  TextStyle menulist = new TextStyle(
    fontSize: 15.0,
    color: Colors.brown,
  );

  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Search result for \'"+widget.data+"\'"),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop(_fileContent);
          },
        )
      ),
      body: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    width: 80.0,
                    height: 30.0,
                    margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(100.0),
                      color: Theme.of(context).accentColor
                    ),
                    child: new FlatButton(
                      highlightColor: Colors.blue,
                      // splashColor: Colors.red,
                      child: new Text('All items',style: new TextStyle(fontSize: 14.0,color: Colors.white),),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.all(0.0),
                      
                      
                    ),
                  )
                  
                ],
              )
            ],
          ),
          new Expanded(
            child: status == "No Item Match"
            ? _noItems()

            :_hasItems()
          ),
        ],
      )
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

    return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 120.0),
            child: new Icon(
              Icons.search,
              size: 50.0,
              color: Colors.grey[350],
            ),
          ),
          new Container(
            padding: new EdgeInsets.all(5.0),
            child: new Text("No result match for \'"+widget.data+"\'",style: new TextStyle(fontSize: 20.0))
          ),
        ],
    );
  }

  Widget _hasItems(){
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              // border: new Border.all(width: 1.0,color: Colors.brown),
              color: Theme.of(context).accentColor,
            ),
            margin: new EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
            padding: const EdgeInsets.all(10.0),
            child: _tableheader()
          ),

            new Expanded(
             
              
              child: new ListView.builder(
                shrinkWrap: true,
                itemCount: no,
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
                          
                          // color: Colors.blue,
                          flex: 5,
                          child: new Container(
                            child: new Text(name[index],style: tablebody,textAlign: TextAlign.left)                          
                          )
                          
                        ),
                        new Flexible(
                              
                              // color: Colors.blue,
                              flex: 3,
                              fit:FlexFit.tight,
                              child: new Container(
                                child: new Text(quantity[index], style: tablebody,textAlign: TextAlign.left),)
                          
                        ),
                        new Flexible(
                              
                              // color: Colors.blue,
                              flex: 3,
                              fit:FlexFit.tight,
                              child: new Container(
                                child: new Text(cat[index],style: tablebody,textAlign: TextAlign.left),)
                          
                        ),
                        new Flexible(
                              
                              // color: Colors.blue,
                              flex: 4,
                              child: new Container(
                                width: 100.0,
                                child: _actionBtns(index,context),
                              )
                          
                        ),
                      ],
                    ),
                  );
                
                }
              ),
            )
          // ),
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
      quantity = qty();
    });
  }

  Widget _actionBtns(int index, BuildContext context){
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
                    updateContent(index,false);
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
                        quantity = qty();
                        name = itemName();
                        lowQty = lowqty();
                        cat = category();
                      });
                    }
                },
              ),
            )
          ),
        ],
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

}