import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trans_mobile/artist.dart';
import 'package:trans_mobile/artists.dart';

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
      child: Builder(builder: (BuildContext context) {
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
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Center(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text('Artiste')),
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
                        );
                      }));
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
  }
}
