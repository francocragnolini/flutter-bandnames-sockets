import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  //private properties
  ServerStatus _serverStatus = ServerStatus.connecting;

  IO.Socket? _socket;

  // constructor base
  SocketService() {
    _initConfig();
  }

  // getters and setters
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket? get socket => this._socket;
  get emit => this._socket?.emit;

  // metodo the initializacion the socket
  void _initConfig() {
    this._socket = IO.io('http://10.0.2.2:3000', {
      "transports": ['websocket'],
      "autoconect": true,
    });

    this._socket?.onConnect((_) {
      print('connect');
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    this._socket?.onDisconnect((_) {
      print('disconnect');
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }
}
