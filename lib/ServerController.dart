import 'dart:io';
import 'dart:convert';

const String SERVER_ADDRESS = "10.97.60.164";
const String SERVER_PATH = "/game";
const int SERVER_PORT = 8080;

enum ConnectionState {
  waitingForHello,
  creatingGame,
  inLobby,
  joiningGame,
}

class Connection {
  final WebSocket socket;
  ConnectionState state = ConnectionState.waitingForHello;
  List<Player> players = List<Player>();
  String username;
  String code;
  bool isHost;

  Function(String) onJoin;
  Function(String) onLeft;
  Function() onGameCreated;

  Connection(this.socket, this.isHost, this.username, {this.code}) {
    assert(code == null && isHost);
    socket.listen(onData);
  }

  void sendJson(Object obj) {
    socket.addUtf8Text(utf8.encode(json.encode(obj)));
  }

  void onData(dynamic obj) {
    if (!(obj is String)) {
      socket.close();
    }

    String msg = obj as String;

    Map<String, Object> json;
    try {
      json = jsonDecode(msg);
    } catch(e) {
      sendJson({'message': 'invalid_json'});
      socket.close();
    }

    if (json['message'] == 'bye') {
      socket.close();
    }

    switch (state) {
      case ConnectionState.waitingForHello:
        if (json['message'] != 'hello') {
          return;
        }

        if (isHost) {
          sendJson({'message': 'create_game', 'username': '$username'});
          state = ConnectionState.creatingGame;
        } else {
          sendJson({'message': 'join_game', 'code': '$code', 'username': '$username'});
          state = ConnectionState.joiningGame;
        }
        break;
      case ConnectionState.creatingGame:
        if (json['message'] != 'created_game') {
          return;
        }

        code = json['code'];
        // TODO: Verify code.
        print(code);
        onGameCreated();

        state = ConnectionState.inLobby;
        break;
      case ConnectionState.inLobby:
        // Game starting

        // Joined
        if (json['message'] == 'joined' && onJoin != null) {
          onJoin(json['user']);
        }

        // Left
        if (json['message'] == 'left' && onLeft != null) {
          onLeft(json['user']);
        }

        // 
        // TODO: Handle this case.
        break;
      case ConnectionState.joiningGame:
        // TODO: Handle this case.
        break;
    }
  }

  static Future<Connection> createGame(String username) async {
        var socket = await WebSocket.connect("ws://$SERVER_ADDRESS:$SERVER_PORT$SERVER_PATH");


        return Connection(socket, true, username);
  }

  static void joinGame(String address, int port) {
    
  }


}

class Player {
  String name;
  int score;
  
  Player(this.name, this.score);
}