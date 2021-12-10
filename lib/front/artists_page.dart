import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trans_mobile/back/artists_filter.dart';
import 'package:trans_mobile/back/model.dart';
import 'package:trans_mobile/front/artist_page.dart';
import 'package:trans_mobile/front/artists_filter_page.dart';
import 'package:trans_mobile/front/festival_page.dart';

/// Page affichant les artistes
/// @author Julien Cochet

class ArtistsPage extends StatefulWidget {
  ArtistsPage({Key? key, required this.title, this.artistsFilter})
      : super(key: key);

  final String title;
  ArtistsFilter? artistsFilter;

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  final int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const FestivalPage(title: 'Festival'),
                transitionDuration: Duration.zero,
              ),
            );
          }
          break;
        case 1:
          {}
          break;
        default:
          {}
          break;
      }
    });
  }

  List<Widget> _generateArtistsCards(TransModel model) {
    List<Widget> cards = [];
    List<String> _countries = [];
    widget.artistsFilter!.countriesFilter.forEach((key, value) {
      if (value) _countries.add(key);
    });
    List<String> _years = [];
    widget.artistsFilter!.yearsFilter.forEach((key, value) {
      if (value) _years.add(key);
    });
    model.getFilteredArtists(_countries, _years).forEach((artist) {
      cards.add(Card(
        child: ListTile(
          leading: Text(artist.fields['artistes'][0]),
          title: Text(artist.fields['artistes']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistPage(
                    title: artist.fields['artistes'], artist: artist),
              ),
            );
          },
        ),
      ));
    });
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransModel>(builder: (context, model, child) {
      widget.artistsFilter ??= ArtistsFilter(model);
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: ListView(
          children: _generateArtistsCards(model),
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Dates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Artistes',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArtistsFilterPage(
                      title: 'Filtrer', artistsFilter: widget.artistsFilter!)),
            );
          },
          tooltip: 'Filtrer',
          child: const Icon(Icons.filter_list),
        ),
      );
    });
  }
}
