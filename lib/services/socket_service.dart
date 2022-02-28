import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {
  // ignore: constant_identifier_names
  Online,
  // ignore: constant_identifier_names
  Offline,
  // ignore: constant_identifier_names
  Connecting
}

class SocketService with ChangeNotifier {


  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket = IO.io('http://:3000');

  ServerStatus? get serverStatus => _serverStatus;
  
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    final token = await AuthService.getToken();
    // Dart client
    _socket = IO.io(Environment.socketUrl, 
    IO.OptionBuilder()
    .setTransports(['websocket'])
    .enableAutoConnect()
    .enableForceNew()
    .setExtraHeaders({
      'x-token':token
      })
    .build()
    );
    _socket.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    //socket.on('event', (data) => print(data));
    _socket.onDisconnect((_) {
     _serverStatus = ServerStatus.Offline;
     print(serverStatus);
     notifyListeners();
     });
  }

  void disconnect() {
    _socket.disconnect();
  }
}