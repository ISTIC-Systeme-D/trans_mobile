import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:trans_mobile/back/artist.dart';

class TransModel extends ChangeNotifier {
  List<Artist> _artists = [];
  List<String> _countries = [];
  List<String> _datesOfThisYear = [];
  List<String> _years = [];
  final DatabaseReference _db = FirebaseDatabase.instance.reference();

  static const String artistsPath = 'artists';
  static const String countryField = 'origine_pays1';
  static const List<String> datesFields = [
    '1ere_date',
    '2eme_date',
    '3eme_date',
    '4eme_date'
  ];
  static const String yearField = 'annee';

  late StreamSubscription<Event> _artistsStream;

  List<Artist> get artists => _artists;

  List<String> get countries => _countries;

  List<String> get years => _years;

  List<String> get datesOfThisYear => _datesOfThisYear;

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
      _getDatesFromThisYear();
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
    _countries.sort();
    _years.sort();
  }

  List<Artist> _getArtistsFromCountries(
      List<Artist> artistsToFilter, List<String> countries) {
    List<Artist> returnArtists = List.empty(growable: true);
    for (var artist in artistsToFilter) {
      if (_countries.contains(artist.fields[countryField])) {
        returnArtists.add(artist);
      }
    }
    return returnArtists;
  }

  List<Artist> _getArtistsFromYears(
      List<Artist> artistsToFilter, List<String> years) {
    List<Artist> returnArtists = List.empty(growable: true);
    for (var artist in artistsToFilter) {
      if (_years.contains(artist.fields[yearField])) {
        returnArtists.add(artist);
      }
    }
    return returnArtists;
  }

  List<Artist> getFilteredArtistsByCountriesAndYears(
      List<String> countries, List<String> years) {
    return _getArtistsFromYears(
        _getArtistsFromCountries(_artists, countries), years);
  }

  List<Artist> getFilteredArtistsByDates(List<String> dates) {
    List<Artist> returnArtists = List.empty(growable: true);
    for (var artist in _artists) {
      for (var dateField in datesFields) {
        if (artist.fields[dateField] != null &&
            artist.fields[dateField] != '') {
          if (_datesOfThisYear.contains(artist.fields[dateField])) {
            returnArtists.add(artist);
          }
        }
      }
    }
    return returnArtists;
  }

  void _getDatesFromThisYear() {
    List<Artist> artistsOfThisYear =
        _getArtistsFromYears(_artists, [_years.last]);
    for (var artist in artistsOfThisYear) {
      for (var dateField in datesFields) {
        if (artist.fields[dateField] != null &&
            artist.fields[dateField] != '') {
          if (!_datesOfThisYear.contains(artist.fields[dateField])) {
            _datesOfThisYear.add(artist.fields[dateField]);
          }
        }
      }
    }
    _datesOfThisYear.sort();
  }

  @override
  void dispose() {
    _artistsStream.cancel();
    super.dispose();
  }
}
