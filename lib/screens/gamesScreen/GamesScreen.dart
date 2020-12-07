import 'package:flutter/material.dart';
import 'package:foot_app/models/game.dart';
import 'package:foot_app/services/mockiAPiService.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class GamesScreen extends StatefulWidget {
  GamesScreen({Key key}) : super(key: key);

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null);
  }

  MockiApiService _mockiApiService = MockiApiService();
  GetStorage box = GetStorage();
  List list = [];
  bool data = false;
  fetchStorageData() {
    Iterable keys = box.getKeys();
    for (var key in keys) {
      if (key.toString().contains("game")) list.add(box.read(key));
    }
    setState(() {
      list.length > 0 ? data = true : data = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    fetchStorageData();
    return FutureBuilder(
      future: _mockiApiService.getAllGames(),
      initialData: data ? list : [],
      builder: (ctx, snap) {
        if (snap.hasData) {
          if (snap.data.length > 0) {
            return ListView.separated(
              separatorBuilder: (ctx, i) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: snap.data.length,
              itemBuilder: (ctx, index) {
                Game game = Game();
                game.fromJson(snap.data[index]);
                if (!data) {
                  box.writeIfNull("game-${game.getId}", game.toJson());
                }
                String dt =
                    DateFormat.yMd().format(DateTime.parse(game.getDate));
                return Container(
                  margin: EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: index == 0 ? 10 : 0,
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width / 3,
                            child: Text(
                              game.getTeamA,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(game.getTeamAabr),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(dt),
                          Container(
                            height: 20,
                            width: 30,
                            child: Center(
                                child: Text(game.getGoalsA.toString() +
                                    '-' +
                                    game.getGoalsB.toString())),
                            color: Colors.lightBlue,
                          ),
                          Text(game.getTime),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width / 3,
                            child: Center(
                              child: Text(
                                game.getTeamB,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Text(game.getTeamBabr),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
