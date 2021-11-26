import 'package:flutter/material.dart';
import 'package:trans_mobile/artists_filter.dart';

/**
 * Page affichant les artistes
 * @author Julien Cochet
 */

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return const Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('A')),
                title: Text('Artiste'),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ArtistsFilterPage(title: 'Filtrer')),
          );
        },
        tooltip: 'Filtrer',
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}
