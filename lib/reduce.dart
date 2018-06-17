import 'package:flutter/material.dart';

import './main.dart' as mainPage;
import './storage.dart';

class ReducePage extends StatefulWidget{
  final itemName;
  final itemQty;
  final itemCat;
  final itemLowQty;

  final Storage storage;
  final index;

  ReducePage({Key key,this.itemName,this.itemQty,this.itemCat,this.itemLowQty,this.index,this.storage}): super(key: key);
  @override
  State createState() => new ReducePageState();
}

class ReducePageState extends State<ReducePage>{
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  String _fileContent;
  int index;

  TextEditingController _namecontroller;
  TextEditingController _qtycontroller;
  TextEditingController _catcontroller;
  TextEditingController _lowqtycontroller;

  TextEditingController _reducedcontroller = new TextEditingController();


  @override
  void initState(){
    super.initState();
    setState(() {
      widget.storage.readData().then((String content){
        _fileContent = content;
      });
      index = widget.index;
      _namecontroller = new TextEditingController();
      _namecontroller.text = widget.itemName;

      _qtycontroller = new TextEditingController();
      _qtycontroller.text = widget.itemQty;

      _catcontroller = new TextEditingController();
      _catcontroller.text = widget.itemCat;

      _lowqtycontroller = new TextEditingController();
      _lowqtycontroller.text = widget.itemLowQty;
    });

  }

  bool checkReduced(int oldQty,int reducedQty){
    if(oldQty >= reducedQty) return false;
    return true;
  }

  void updateContent(){
    int newQty = ifAddQty(_reducedcontroller.text) 
      ? int.parse(_qtycontroller.text)-int.parse(_reducedcontroller.text)
      : int.parse(_qtycontroller.text);
    List all = _fileContent.split(',');
    int newIndex = (index*4);

    if(checkReduced(int.parse(_qtycontroller.text), int.parse(_reducedcontroller.text))) _snackBar('Reduced quantity cannot exceed total quantity');
    else{
      all[newIndex] = _namecontroller.text;
      all[newIndex+1] = newQty.toString();
      all[newIndex+2] = _catcontroller.text;
      all[newIndex+3] = _lowqtycontroller.text;

      String finalContent = all.join(',');

      widget.storage.replaceData(finalContent);
      Navigator.pop(context,finalContent);
      
    }

    
  }

  bool ifAddQty(String text){
    if(text == '' || text == null) return false;
    return true;
  }

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
      resizeToAvoidBottomPadding: false,
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
                  controller: _namecontroller,
                  
                  style: searchStyle,
                  
                    decoration: new InputDecoration.collapsed(
                      hintText: null,
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
                  controller: _qtycontroller,
                  style: disabled,
                  enabled: false,
                    decoration: new InputDecoration.collapsed(
                    hintText: null,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 8.0),
                padding: new EdgeInsets.fromLTRB(5.0,0.0,8.0,5.0),
                decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide(width: 0.5,color: Colors.grey))
                ),
                child: new TextField(
                  controller: _reducedcontroller,
                  style: searchStyle,
                    decoration: new InputDecoration.collapsed(
                    hintText: "Quantity to reduce",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              new Container(
                margin: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 8.0),
                padding: new EdgeInsets.fromLTRB(5.0,0.0,8.0,5.0),
                decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide(width: 0.5,color: Colors.grey))
                ),
                child: new TextField(
                  
                  controller: _catcontroller,
                  style: searchStyle,
                    decoration: new InputDecoration.collapsed(
                    hintText: null,
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
                  
                  controller: _lowqtycontroller,
                  style: searchStyle,
                    decoration: new InputDecoration.collapsed(
                    hintText: null,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 80.0,
                      height: 30.0,
                      margin: new EdgeInsets.fromLTRB(0.0, 30.0, 20.0, 10.0),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: Theme.of(context).accentColor
                      ),
                      child: new FlatButton(
                        child: new Text('update',style: new TextStyle(fontSize: 14.0,color: Colors.white),),
                        onPressed: () {
                          updateContent();
                        },
                        padding: const EdgeInsets.all(0.0),
                        splashColor: Theme.of(context).splashColor,
                        highlightColor: Theme.of(context).buttonColor,
                        
                        
                      ),
                    ),
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
                        onPressed: () {Navigator.of(context).pop(_fileContent);},
                        padding: const EdgeInsets.all(0.0),
                        splashColor: Theme.of(context).splashColor,
                        highlightColor: Theme.of(context).buttonColor,
                        
                        
                      ),
                    )
                  
                ],
              )
            ],
          ),
        ],
      ),
    );

          
  }

  TextStyle searchStyle = new TextStyle(
    fontSize: 18.0,
    color: Colors.grey[900]
  );

  TextStyle disabled = new TextStyle(
    fontSize: 18.0,
    color: Colors.grey[600]
  );
}