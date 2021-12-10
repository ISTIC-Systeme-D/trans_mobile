import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trans_mobile/back/artist.dart';

class TransModel extends ChangeNotifier {
  List<Artist> _artists = [];
  List<String> _countries = [];
  List<String> _years = [];
  final _db = FirebaseDatabase.instance.reference();

  static const artistsPath = 'artists';
  static const countryField = 'origine_pays1';
  static const yearField = 'annee';

  late StreamSubscription<Event> _artistsStream;

  List<Artist> get artists => _artists;

  List<String> get countries => _countries;

  List<String> get years => _years;

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
      _updateCountriesAndYears();
      notifyListeners();
    });
  }

  void _updateCountriesAndYears() {
    _countries = List.empty(growable: true);
    _years = List.empty(growable: true);
    for (var artist in _artists) {
      if (!_countries.contains(artist.fields[countryField])) {
        _countries.add(artist.fields[countryField]);
      }
      if (!_years.contains(artist.fields[yearField])) {
        _years.add(artist.fields[yearField]);
      }
    }
  }

  List<Artist> _getArtistsFromCountries(
      List<Artist> artistsToFilter, List<String> countries) {
    List<Artist> returnArtists = List.empty(growable: true);
    for (var artist in artistsToFilter) {
      if (countries.contains(artist.fields[countryField])) {
        returnArtists.add(artist);
      }
    }
    return returnArtists;
  }

  List<Artist> _getArtistsFromYears(
      List<Artist> artistsToFilter, List<String> years) {
    List<Artist> returnArtists = List.empty(growable: true);
    for (var artist in artistsToFilter) {
      if (years.contains(artist.fields[yearField])) {
        returnArtists.add(artist);
      }
    }
    return returnArtists;
  }

  List<Artist> getFilteredArtists(List<String> countries, List<String> years) {
    return _getArtistsFromYears(
        _getArtistsFromCountries(_artists, countries), years);
  }

  @override
  void dispose() {
    _artistsStream.cancel();
    super.dispose();
  }
}
