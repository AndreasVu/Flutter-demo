import 'dart:io';
import 'dart:convert';

const String SERVER_ADDRES = "";
const String SERVER_PATH = "/game";
const int SERVER_PORT = 123;

class Socket {
    Future<WebSocket> socket;

    Socket(String address) {
        socket = WebSocket.connect("ws://$SERVER_ADDRES:$SERVER_PORT$SERVER_PATH");
    }

    void sendJson(Object obj) {
        //socket.addUtf8Text(utf8.encode(json.encode(obj)));
    }
}

class ServerController {
    static void create_game(String username) async {
        
        
    }

    static void join_game(String address, int port) {

    }
}