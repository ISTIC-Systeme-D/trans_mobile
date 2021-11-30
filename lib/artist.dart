import 'dart:math';

import 'package:flutter/material.dart';

/// Page affichant les détails d'un artiste
/// @author Julien Cochet

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
                child: Column(
              children: [
                AspectRatio(
                    aspectRatio: (orientation == Orientation.portrait)
                        ? (3 / 2)
                        : (6 / 1),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Text('Artiste'), Text('France')]),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    )),
                const Card(
                  child: ListTile(
                    title: Text('Jour 1 - 14h00'),
                    subtitle: Text('Salle A'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    title: Text('Jour 2 - 20h00'),
                    subtitle: Text('Salle B'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    title: Text('Jour 3 - 22h00'),
                    subtitle: Text('Salle C'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    title: Text('Jour 4 - 22h00'),
                    subtitle: Text('Salle B'),
                  ),
                ),
              ],
            )));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //https://open.spotify.com/track/4cOdK2wGLETKBW3PvgPWqT?si=84f10eb924b04704
        },
        tooltip: 'Écouter',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
