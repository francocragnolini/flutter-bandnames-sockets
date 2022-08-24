import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: "1", name: "Metallica", votes: 5),
    Band(id: "2", name: "Queen", votes: 1),
    Band(id: "3", name: "Madonna", votes: 5),
    Band(id: "4", name: "Linking Park", votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Band Names",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, i) => _bandTile(bands[i]),
        itemCount: bands.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  // methods
  // returns a widget-item with the data of the bands list property.
  Widget _bandTile(Band band) {
    return Dismissible(
        onDismissed: (DismissDirection direction) {
          print("$direction");
          print("id:${band.id}");
          // llamar el borrado en el server
        },
        direction: DismissDirection.startToEnd,
        key: Key(band.id),
        background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Delete Band",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name.substring(0, 2)),
          ),
          title: Text(band.name),
          trailing: Text(
            "${band.votes}",
            style: const TextStyle(fontSize: 20),
          ),
          onTap: () => print(band.name),
        ));
  }

  // returns a dialog to add a band with and input to be fulfilled by the user.
  addNewBand() {
    //  the user input data from textField Widget.
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      // Android
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("New Band Name"),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                // to access the value from input.
                onPressed: () => addBandToList(textController.text),
                child: const Text("Add"),
              )
            ],
          );
        },
      );
    }

    // IOS platform
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text("New Band Name"),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => addBandToList(textController.text),
              child: const Text("Add"),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text("Dismiss"),
            )
          ],
        );
      },
    );
  }

  // gets the band name from input (textField widget)
  void addBandToList(String name) {
    if (name.length > 1) {
      // if input not empty add the new object to list
      // creates a new band (object) and is added to the list <Band>
      bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
