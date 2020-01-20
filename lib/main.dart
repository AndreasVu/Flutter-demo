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
        primarySwatch: Colors.blue,
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
                child: FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.8,
                  heightFactor: 0.3,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                    ),
                    child: Center(
                      child: Text("Cards Against Programmers", style: TextStyle(color: Colors.white, fontSize: 28)),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join a game'),
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
                onPressed: () {},
                child: Text('Join'),
              )
            ],
          ),
        )
      ),
    );
  }
}

class CreateGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hva hender her?'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back'),
        ),
      ),
    );
  }
}
