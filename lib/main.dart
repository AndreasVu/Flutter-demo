import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/join': (context) => JoinGame(),
        '/create' : (context) => CreateGame(),
      },
      theme: ThemeData(
        backgroundColor: Colors.white
      )
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  heightFactor: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: Text("Cards Against Programmers", style: TextStyle(color: Colors.white, fontSize: 28), textAlign: TextAlign.center,),
                    )
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/join');
                },
                child: Container(
                  width: 150,
                  height: 90,
                  child: Center(
                    child: Text('Join game'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              ),
              RaisedButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/create');
                },
                child: Container(
                  width: 150,
                  height: 90,
                  child: Center(
                    child: Text('Create game'),
                  ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
}

class JoinGame extends StatelessWidget {
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Join a game', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Container(
          width: 250,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              ),
              TextFormField(
                controller: codeController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Room code',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              TextFormField(
                controller: nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Name',
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
              RaisedButton(
                color: Colors.black,
                onPressed: () {
                  joinGame(this.codeController.text, this.nameController.text);
                  },
                child: Text('Join', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        )
      ),
    );
  }

  void joinGame(String code, String name) async {
    var ws = await WebSocket.connect('ws://10.97.60.164:8080/game');

    ws.addUtf8Text(utf8.encode(json.encode({'message': 'join_game', 'code': '$code', 'username': '$name'})));
    ws.listen((msg) {
      print(msg);
    });
  }
}

class CreateGame extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create game'),
      ),
      body: Center(
        child: Container(
          width: 250,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: myController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Your name',
                ),
              ),
              SliderState(),
              RaisedButton(
                onPressed: () {
                  createLobby(myController.text);
                },
                child: Text('Create game lobby'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  },
                child: Text('Go back'),
              ),
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                  child: Text(
                      'The Enchanted Nightingale __ blah blah',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, height: 2)
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createLobby(String name) async  {
    var ws = await WebSocket.connect('ws://10.97.60.164:8080/game');

    ws.addUtf8Text(utf8.encode(json.encode({'message': 'create_game', 'username': '$name'})));
  }
}

class SliderState extends StatefulWidget{
  @override
  createState()  => _SliderState();

}

class _SliderState extends State<SliderState>{
  double _value = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
        value: this._value,
         min: 0.0, max: 10.0,
         onChanged: (double value) {setState(() => _value = value);},
        ),
        Text('${_value.toInt()}')
      ],
    );
  }
}
