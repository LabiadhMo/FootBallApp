import 'package:flutter/material.dart';
import 'package:foot_app/screens/gamesScreen/GamesScreen.dart';
import 'package:foot_app/screens/teamsScreen/TeamsScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('FootBall App'),
          bottom: TabBar(tabs: [
            Tab(
              child: Text('GAMES'),
            ),
            Tab(
              child: Text('TEAMS'),
            ),
          ]),
        ),
        body: TabBarView(children: [GamesScreen(), TeamsScreen()]),
      ),
    );
  }
}
