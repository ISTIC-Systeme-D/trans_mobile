import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trans_mobile/back/model.dart';

class ArtistsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Provider example'),
            Consumer<TransModel>(
              builder: (context, model, child) {
                return Expanded(
                    child: ListView(
                  children: [
                    ...model.artists.map((artist) => Card(
                          child: ListTile(
                            title: Text(artist.fields['artistes']),
                          ),
                        ))
                  ],
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
