import 'package:flutter/material.dart';

/// Page affichant les options de filtrage pour l'afffichage des artistes
/// @author Julien Cochet

class ArtistsFilterPage extends StatefulWidget {
  const ArtistsFilterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ArtistsFilterPage> createState() => _ArtistsFilterPageState();
}

class _ArtistsFilterPageState extends State<ArtistsFilterPage> {
  static final Map<String, bool> _countries = {
    'France': true,
    'Turquie': true,
    'Congo': true
  };
  static final Map<String, bool> _years = {
    '2021': true,
    '2020': true,
    '2019': true,
    '2018': true,
    '2017': true,
    '2016': true,
    '2015': true,
    '2014': true,
    '2013': true,
    '2012': true
  };
  final Map<String, Map<String, bool>> _options = {
    'Pays': _countries,
    'Éditions': _years
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Column(children: _generateExpansionTiles(_options))),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        children: [
          const Spacer(),
          OutlinedButton(
              onPressed: () {
                setState(() {
                  _options.forEach((key, value) {
                    value.updateAll((key, value) => true);
                  });
                });
              },
              child: const Text('Réinitialiser')),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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
