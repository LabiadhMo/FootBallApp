import 'dart:convert';
import 'package:http/http.dart' as http;

class MockiApiService {
  static final MockiApiService _mockiApiService = MockiApiService._internal();

  static final String serverAdress = "api.mocki.io";
  factory MockiApiService() {
    return _mockiApiService;
  }

  MockiApiService._internal();

  Future<List> getAllTeams() async {
    var uri = Uri.http(serverAdress, "/v1/722624a5/teams");

    var response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) return null;
    var rep = jsonDecode(response.body);
    print('Teams Fetched !');
    return response.body.isEmpty ? null : rep['data'];
  }

  Future<List> getAllGames() async {
    var uri = Uri.http(serverAdress, "/v1/722624a5/games");

    var response = await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode != 200) return null;
    var rep = jsonDecode(response.body);
    print('Games Fetched !');
    return response.body.isEmpty ? null : rep['data'];
  }
}
