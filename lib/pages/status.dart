import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/services/socket_service.dart';
import 'package:socket_io_client/socket_io_client.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // gives access to the socketService
    final socketService = Provider.of<SocketService>(context);
    // access to the socket to emit or listen to events
    final socket = socketService.socket;

    // methods
    /*void emitMessage() {
      const user = {"nombre": "Franco", "mensaje": "hola desde flutter"};
      socket?.emit("emitir-message", user);
    }*/

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //access the serverStatus property trought a getter
          children: [Text("Server Status: ${socketService.serverStatus}")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const user = {"nombre": "Franco", "mensaje": "hola desde flutter"};
          socketService.socket?.emit("emitir-mensaje", user);
        },
        //TAREA
        //emitir un mapa : emitir-mensaje
        // {nombre: flutter, mensaje:"hola desde flutter"}
        child: Icon(Icons.message),
      ),
    );
  }
}
