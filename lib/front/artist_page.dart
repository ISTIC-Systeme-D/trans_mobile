import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trans_mobile/back/artist.dart';
import 'package:url_launcher/url_launcher.dart';

/// Page affichant les détails d'un artiste
/// @author Julien Cochet

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key, required this.title, required this.artist})
      : super(key: key);

  final String title;
  final Artist artist;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  static const String _url = 'https://open.spotify.com/';

  _launchURL(String spotify) async {
    List<String> spotifyList = spotify.split(':');
    if (!await launch(_url + spotifyList[1] + '/' + spotifyList[2])) {
      throw 'Could not launch $_url';
    }
  }

  List<Widget> _generateEventCards() {
    List<String> nums = ['1ere', '2eme', '3eme', '4eme'];
    List<Card> cards = [];
    for (var num in nums) {
      if (widget.artist.fields[num + '_date'] != null &&
          widget.artist.fields[num + '_date'] != '') {
        cards.add(_generateEventCard(num));
      } else {
        return cards;
      }
    }
    return cards;
  }

  Card _generateEventCard(String num) {
    return Card(
      child: ListTile(
        title: Text(widget.artist.fields[num + '_date']),
        subtitle: Text(widget.artist.fields[num + '_salle']),
      ),
    );
  }

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
                          children: [
                            Text(widget.artist.fields['artistes']),
                            Text(widget.artist.fields['origine_pays1'])
                          ]),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    )),
                Column(
                  children: _generateEventCards(),
                ),
              ],
            )));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (widget.artist.fields['spotify'] != null &&
              widget.artist.fields['spotify'] != '') {
            _launchURL(widget.artist.fields['spotify']);
          }
        },
        tooltip: 'Écouter',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
