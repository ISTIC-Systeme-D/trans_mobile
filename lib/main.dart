import 'package:flutter/material.dart';
import 'package:trans_mobile/artists.dart';

/**
 * Main
 * @author Julien Cochet
 */

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les Trans',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ArtistsPage(title: 'Artistes'),
    );
  }
}

