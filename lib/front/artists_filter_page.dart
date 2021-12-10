import 'package:flutter/material.dart';
import 'package:trans_mobile/back/artists_filter.dart';
import 'package:trans_mobile/front/artists_page.dart';

/// Page affichant les options de filtrage pour l'afffichage des artistes
/// @author Julien Cochet

class ArtistsFilterPage extends StatefulWidget {
  const ArtistsFilterPage(
      {Key? key, required this.title, required this.artistsFilter})
      : super(key: key);

  final String title;
  final ArtistsFilter artistsFilter;

  @override
  State<ArtistsFilterPage> createState() => _ArtistsFilterPageState();
}

class _ArtistsFilterPageState extends State<ArtistsFilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Column(
                children:
                    _generateExpansionTiles(widget.artistsFilter.filters))),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: [
          const Spacer(),
          OutlinedButton(
              onPressed: () {
                setState(() {
                  widget.artistsFilter.filters.forEach((key, value) {
                    value.updateAll((key, value) => true);
                  });
                });
              },
              child: const Text('Réinitialiser')),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArtistsPage(
                          title: 'Artistes',
                          artistsFilter: widget.artistsFilter)));
            },
            child: const Text('Filtrer'),
          ),
          const Spacer(),
        ],
      )),
    );
  }

  List<ExpansionTile> _generateExpansionTiles(
      Map<String, Map<String, bool>> options) {
    List<ExpansionTile> expansionTiles = List.empty(growable: true);
    options.forEach((key, value) {
      expansionTiles.add(ExpansionTile(
        title: Text(
          key,
        ),
        children: _generateCheckboxListTiles(value),
      ));
    });
    return expansionTiles;
  }

  List<CheckboxListTile> _generateCheckboxListTiles(Map<String, bool> options) {
    List<CheckboxListTile> checkboxListTiles = List.empty(growable: true);
    options.forEach((key, value) {
      checkboxListTiles.add(CheckboxListTile(
        title: Text(key),
        value: value,
        onChanged: (bool? change) {
          setState(() {
            options.update(key, (value) => change!);
          });
        },
      ));
    });
    return checkboxListTiles;
  }
}
