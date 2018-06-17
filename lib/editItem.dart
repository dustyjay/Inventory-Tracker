
import 'package:flutter/material.dart';

import './add.dart' as addScreen;
import './reduce.dart' as reduceScreen;
import './storage.dart';

class EditItem extends StatefulWidget{
  final Storage storage;
  final data;

  EditItem({Key key,this.data,this.storage}):super(key:key);

  @override
  State createState() => new EditItemState();
}

class EditItemState extends State<EditItem> with SingleTickerProviderStateMixin{
  TabController controller;
  String _fileContent;
  int index;
  
  

  @override
  void initState(){
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    widget.storage.readData().then((String content){
      setState(() {
        _fileContent = content;
        index = widget.data;
      });
    });
  }

  // @override
  // void dispose(){
  //   controller.dispose();
  //   super.dispose();
  // }
  
    // void replaceqty(int index,bool add){
    //   if(index == 0) index = 1;
    //   else index = (index*4)+1;
    //   if(add == true) widget.storage.replaceData(index,true);
    //   else widget.storage.replaceData(index,true);
    //   // Navigator.popAndPushNamed(context, '/HomeScreen');
      
    // }


  Widget build(BuildContext context){

    List names(){
      if(_fileContent.isNotEmpty && _fileContent != null){
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
    List lowQty(){
      if(_fileContent.isNotEmpty && _fileContent != null){
        // int index = int.parse(indexStr);
        List list = _fileContent.split(',');
        var length = list.length~/4;
        List lowlimit = new List(length);
        var j = 0;
        int i = 3;
        for(i;i<list.length;i+=4){
          lowlimit[j] = list[i];
          j++;
        }
        return lowlimit;
      }
      return null;
    }
    
    String itemName = names()[widget.data];
    String itemQty = qty()[widget.data];
    String itemCat = category()[widget.data];
    String itemlowQty = lowQty()[widget.data];

    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text('Edit Item'),
          actions: <Widget>[
            new Container(
              margin: new EdgeInsets.only(right: 10.0),
              child: new IconButton(
                // padding: new EdgeInsets.only(right: 10.0),
                icon: new Icon(Icons.delete,color: Colors.white),
                iconSize: 25.0,
                onPressed: (){
                  Navigator.pop(context,_fileContent);
                },
              ),
            ),
            // new Container(
            //   margin: new EdgeInsets.only(right: 15.0),
            //   child: new IconButton(
            //     icon: new Icon(Icons.check,color: Colors.white),
            //     iconSize: 30.0,
            //     onPressed: (){
            //       Navigator.pop(context);
            //     }
            //   )
            // )
          ],
          bottom: new TabBar(
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.white,
              // controller: controller,
              tabs: [
                new Tab(
                  child: new Container(
                    padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                    child: new Text('ADD',style: new TextStyle(fontSize: 15.0),)
                  ),
                ),
                // new Tab(text: 'ADD'),
                // new Tab(text: 'REDUCE')
                
                new Tab(
                  child: new Container(
                    padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 15.0),
                    child: new Text('REDUCE',style: new TextStyle(fontSize: 15.0))
                  ),
                )
              ],
            ),
        ),
        body: new TabBarView(
          // controller: controller,
          children: <Widget>[
            new addScreen.AddPage(itemName: itemName,itemQty: itemQty,itemCat: itemCat,itemLowQty: itemlowQty,index: index,storage: new Storage()),
            new reduceScreen.ReducePage(itemName: itemName,itemQty: itemQty,itemCat: itemCat,itemLowQty: itemlowQty,index: index,storage: new Storage())
          ],
          
        )
               
      ),
    );
  }

  TextStyle searchStyle = new TextStyle(
    fontSize: 18.0,
    color: Colors.grey[900]
  );
}

