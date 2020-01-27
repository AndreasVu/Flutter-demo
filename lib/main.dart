import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'ServerController.dart';

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
        '/game' : (context) => GameScreen(),
        '/lobby': (context) => LobbyScreen(),
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
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Center(
                      child: Text("Cards Against Programmers \n I want to ______ a game.",
                       style: TextStyle(color: Colors.white, fontSize: 28), textAlign: TextAlign.center,
                       ),
                    )
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: (() {
                  Navigator.pushReplacementNamed(context, '/join');
                }),
                child: Container(
                  child: Ink(
                    width: 160,
                    height: 90,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text(
                        'Join',
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                )
              )
              ,
              Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onTap: (() {
                  Navigator.pushNamed(context, '/create');
                }),
                child: Container(
                  child: Ink(
                    width: 160,
                    height: 90,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(
                      child: Text(
                        'Create',
                        textAlign: TextAlign.center,
                      ),
                    )
                  )
                )
              )
            ],
          ),
        )
      )
    );
  }
}

class UppercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
  
}

class JoinGame extends StatelessWidget {
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                  maxLength: 4,
                  maxLengthEnforced: true,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    WhitelistingTextInputFormatter(
                        RegExp(r"[A-Za-z]*")
                    ),
                    UppercaseTextFormatter(),
                  ],
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
                  onPressed: () async {
                      var connection = Connection.joinGame(nameController.text, codeController.text);
                      Navigator.pushReplacementNamed(context, '/lobby', arguments: connection);
                    },
                  child: Text('Join', style: TextStyle(color: Colors.white),),
                ),
                RaisedButton(
                  onPressed: () {Navigator.pushReplacementNamed(context, '/');},
                  child: Center(
                    child: Text(
                      'Back to main menu'
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
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
                onPressed: () async {
                  var connection = Connection.createGame(myController.text);
                  Navigator.pushReplacementNamed(context, '/lobby', arguments: connection);
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
    Connection connection = await Connection.createGame(name);
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
        onChanged: (double value) {setState(() {
          _value = value;
        });}
        ),
        Text('${_value.toInt()}')
      ],
    );
  }
}

class GameScreen extends StatelessWidget {
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
              Text('Gamescreen'),
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Return to main menu'),
              )
            ],
          )
        ),
      ),
    );
  }
}

class LobbyScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20),),
            Lobby(ModalRoute.of(context).settings.arguments as Future<Connection>),
          ],
        ),
      ),
    );
  }
}

class Lobby extends StatefulWidget{
  final Future<Connection> connection;

  Lobby(this.connection);

  @override
  _LobbyState createState()  => _LobbyState(connection);
}

class _LobbyState extends State<Lobby> {
  var _playerList = List<Player>();
  String code;
  Connection connection;
  bool joined = false;

  _LobbyState(Future<Connection> connection) {
    _playerList.add(Player('skjer', 0));
    connection.then((c) {
      this.connection = c;
      c.onJoin = (name) {
        _playerList.add(Player(name, 0));
        setState(() {});
      };
      c.onJoinedGame = (users) {
        for (String user in users) {
          _playerList.add(Player(user, 0));
        }
        this.code = c.code;
        print(joined);
        setState(() {this.joined = true;});
      };
      c.onLeft = (name) {
        Player removedPlayer;
        for(Player player in _playerList) {
          if (player.name == name) {
            removedPlayer = player;
            break;
          }
        }
        _playerList.remove(removedPlayer);
        setState(() {});
      };
      c.onGameCreated = () {
        this.code = c.code;
        joined = true;
        setState(() {});
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: joined
        ? Expanded(
          child: playerList(),
        )
        : Center(
          child: CircularProgressIndicator(value: null),
        )
    );
  }

  Widget playerList() {
    return Column(
      children: <Widget>[
        Text('Room code: ${connection.code}', style: TextStyle(fontSize: 20),),
        Text(
          'Players',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
        shrinkWrap: true,
        itemCount: _playerList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 150,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(width: 0.5, color: Colors.black)
            ),
            child: Text('${_playerList[index].name}', textAlign: TextAlign.center,),
            );
          },
        )
      ],
    );
  }
}
