import 'dart:io';
import 'dart:convert';

const String SERVER_ADDRES = "";
const String SERVER_PATH = "/game";
const int SERVER_PORT = 123;

class Socket {
    WebSocket socket;

    Socket._(this.socket);

    static Future<Socket> connect(String address) async {
        var socket = await WebSocket.connect("ws://$SERVER_ADDRES:$SERVER_PORT$SERVER_PATH");
        return Socket._(socket);
    }

    void sendJson(Object obj) {
        socket.addUtf8Text(utf8.encode(json.encode(obj)));
    }
}

class ServerController {
    static void create_game(String username) async {
        
        
    }

    static void join_game(String address, int port) {

    }
}