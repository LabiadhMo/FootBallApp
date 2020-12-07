import 'package:flutter/material.dart';
import 'package:foot_app/models/team.dart';
import 'package:foot_app/services/mockiAPiService.dart';
import 'package:get_storage/get_storage.dart';

class TeamsScreen extends StatefulWidget {
  TeamsScreen({Key key}) : super(key: key);

  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  MockiApiService _mockiApiService = MockiApiService();
  GetStorage box = GetStorage();
  List list = [];
  bool data = false;
  fetchStorageData() {
    Iterable keys = box.getKeys();
    for (var key in keys) {
      if (key.toString().contains("team")) list.add(box.read(key));
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
      future: _mockiApiService.getAllTeams(),
      initialData: data ? list : [],
      builder: (ctx, snap) {
        if (snap.hasData) {
          if (snap.data.length > 0) {
            return ListView.separated(
                itemCount: snap.data.length,
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemBuilder: (ctx, index) {
                  Team team = Team();
                  team.fromJson(snap.data[index]);
                  if (!data) {
                    box.writeIfNull("team-${team.getId}", team.toJson());
                  }
                  return Container(
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: index == 0 ? 10 : 0,
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${team.getTeamTitle} (${team.getTeamAbr})",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('city : ${team.getCity}'),
                            Text('name : ${team.getName}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('division : ${team.getDivision}'),
                            Text('conference : ${team.getConference}'),
                          ],
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
