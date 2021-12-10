import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trans_mobile/back/model.dart';
import 'package:trans_mobile/front/artist_page.dart';
import 'package:trans_mobile/front/artists_filter_page.dart';
import 'package:trans_mobile/front/festival_page.dart';

/// Page affichant les artistes
/// @author Julien Cochet

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key, required this.title}) : super(key: key);

  final String title;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<TransModel>(
        builder: (context, model, child) {
          return Center(
              child: ListView(
            children: [
              ...model
                  .getFilteredArtists(model.years, model.countries)
                  .map((artist) => Card(
                        child: ListTile(
                          leading: Text(artist.fields['artistes'][0]),
                          title: Text(artist.fields['artistes']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ArtistPage(title: 'Artiste'),
                              ),
                            );
                          },
                        ),
                      ))
            ],
          ));
        },
      ),
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
                builder: (context) =>
                    const ArtistsFilterPage(title: 'Filtrer')),
          );
        },
        tooltip: 'Filtrer',
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
