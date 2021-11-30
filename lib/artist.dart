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
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: const Align(
                  alignment: Alignment.bottomCenter, child: Text('Artiste')),
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
          ],
        ),
      ),
    );
  }
}
