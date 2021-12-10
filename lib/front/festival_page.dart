import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trans_mobile/back/model.dart';
import 'package:trans_mobile/front/artist_page.dart';
import 'package:trans_mobile/front/artists_page.dart';
import 'package:trans_mobile/front/realtime_test.dart';

/// Page affichant les artistes pour une journée
/// @author Julien Cochet

const List<Tab> tabs = <Tab>[
  Tab(text: 'Jour 1'),
  Tab(text: 'Jour 2'),
  Tab(text: 'Jour 3'),
  Tab(text: 'Jour 4'),
  Tab(text: 'Jour 5'),
];

class FestivalPage extends StatefulWidget {
  const FestivalPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FestivalPage> createState() => _FestivalPageState();
}

class _FestivalPageState extends State<FestivalPage> {
  final int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {}
          break;
        case 1:
          {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const ArtistsPage(title: 'Artistes'),
                transitionDuration: Duration.zero,
              ),
            );
          }
          break;
        default:
          {}
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: OrientationBuilder(builder: (BuildContext context, orientation) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: const TabBar(
              tabs: tabs,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Realtime Database'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<TransModel>(
                                create: (_) => TransModel(),
                                child: ArtistsView()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Consumer<TransModel>(builder: (context, model, child) {
            return TabBarView(
              children: tabs.map((Tab tab) {
                return Center(
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 6,
                        ),
                        children: [
                      ...model.artists.map((artist) => InkWell(
                            child: Container(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(artist.fields['artistes'])),
                              color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ArtistPage(title: 'Artiste'),
                                ),
                              );
                            },
                          ))
                    ]));
              }).toList(),
            );
          }),
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
        );
      }),
    );
  }
}
