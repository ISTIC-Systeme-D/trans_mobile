import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

/// Page pour tester realtime database
/// @author Julien Cochet

class DatabasePage extends StatefulWidget {
  const DatabasePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  String _displayText = 'Results go here';
  final _database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _database.child('artists').onValue.listen((event) {
      final String artists = event.snapshot.value.toString();
      setState(() {
        _displayText = 'Artists: $artists';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [Text(_displayText)],
            )),
      ),
    );
  }
}
