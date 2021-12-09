import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trans_mobile/back/artist.dart';

class TransModel extends ChangeNotifier {
  List<Artist> _artists = [];
  final _db = FirebaseDatabase.instance.reference();

  static const artistsPath = 'artists';

  late StreamSubscription<Event> _artistsStream;

  List<Artist> get artists => _artists;

  TransModel() {
    _listenToArtists();
  }

  void _listenToArtists() {
    _artistsStream = _db.child(artistsPath).onValue.listen((event) {
      final allArtists = Map<String, dynamic>.from(event.snapshot.value);
      _artists = allArtists.values
          .map((orderAsJSON) =>
              Artist.fromRTDB(Map<String, dynamic>.from(orderAsJSON)))
          .toList();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _artistsStream.cancel();
    super.dispose();
  }
}
