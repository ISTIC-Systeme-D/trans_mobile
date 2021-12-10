import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trans_mobile/back/model.dart';
import 'package:trans_mobile/front/artist_page.dart';
import 'package:trans_mobile/front/artists_page.dart';

/// Page affichant les artistes pour une journée
/// @author Julien Cochet

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
                    ArtistsPage(title: 'Artistes'),
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

  List<Tab> _generateTabs(TransModel model) {
    List<Tab> tabs = [];
    for (var date in model.datesOfThisYear) {
      tabs.add(Tab(text: date));
    }
    return tabs;
  }

  List<InkWell> _generateArtistsInkWells(TransModel model, String date) {
    print('date: ' + date);
    List<InkWell> inkWells = [];
    model.getFilteredArtistsByDates([date]).forEach((artist) {
      inkWells.add(InkWell(
        child: Container(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(artist.fields['artistes'])),
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArtistPage(title: artist.fields['artistes'], artist: artist),
            ),
          );
        },
      ));
    });
    return inkWells;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransModel>(builder: (context, model, child) {
      List<Tab> tabs = _generateTabs(model);
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
              bottom: TabBar(
                tabs: tabs,
                isScrollable: true,
              ),
            ),
            body: TabBarView(
              children: tabs.map((Tab tab) {
                return Center(
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 6,
                        ),
                        children: _generateArtistsInkWells(
                            model, tab.text.toString())));
              }).toList(),
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
          );
        }),
      );
    });
  }
}
