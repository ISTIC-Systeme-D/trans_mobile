import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trans_mobile/back/artist.dart';

class TransModel extends ChangeNotifier {
  List<Artist> _artists = [];
  List<String> _years = [];
  List<String> _countries = [];
  final _db = FirebaseDatabase.instance.reference();

  static const artistsPath = 'artists';
  static const yearField = 'annee';
  static const countryField = 'origine_pays1';

  late StreamSubscription<Event> _artistsStream;

  List<Artist> get artists => _artists;

  List<String> get years => _years;

  List<String> get countries => _countries;

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
      _updateYearsAndCountries();
      notifyListeners();
    });
  }

  void _updateYearsAndCountries() {
    _years = List.empty(growable: true);
    _countries = List.empty(growable: true);
    _artists.forEach((artist) {
      if (!_years.contains(artist.fields[yearField])) {
        _years.add(artist.fields[yearField]);
      }
      if (!_countries.contains(artist.fields[countryField])) {
        _years.add(artist.fields[countryField]);
      }
    });
  }

  List<Artist> getFilteredArtists(List<String> years, List<String> countries) {
    return _getArtistsFromCountries(
        _getArtistsFromYears(_artists, years), countries);
  }

  List<Artist> _getArtistsFromYears(
      List<Artist> artistsToFilter, List<String> years) {
    List<Artist> returnArtists = List.empty(growable: true);
    artistsToFilter.forEach((artist) {
      if (years.contains(artist.fields[yearField])) {
        returnArtists.add(artist);
      }
    });
    return returnArtists;
  }

  List<Artist> _getArtistsFromCountries(
      List<Artist> artistsToFilter, List<String> countries) {
    List<Artist> returnArtists = List.empty(growable: true);
    artistsToFilter.forEach((artist) {
      if (years.contains(artist.fields[countryField])) {
        returnArtists.add(artist);
      }
    });
    return returnArtists;
  }

  @override
  void dispose() {
    _artistsStream.cancel();
    super.dispose();
  }
}
