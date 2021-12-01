import 'package:flutter/material.dart';
import 'package:trans_mobile/front/artist_page.dart';
import 'package:trans_mobile/front/artists_filter_page.dart';
import 'package:trans_mobile/back/data_service.dart';
import 'package:trans_mobile/front/festival_page.dart';
import 'package:trans_mobile/front/status_page.dart';

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
      /*
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Statut du serveur'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusPage(
                        title: 'Statut du serveur',
                        serverInfo: fetchServerInfo()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
       */
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: const CircleAvatar(child: Text('A')),
                title: const Text('Artiste'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ArtistPage(title: 'Artiste'),
                    ),
                  );
                },
              ),
            );
          },
        ),
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
