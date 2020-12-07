class Game {
  String _teamA;
  String _teamAabr;
  String _teamB;
  String _teamBabr;
  String _date;
  String _time;
  int _goalsA;
  int _goalsB;
  int _id;
  Game({
    id,
    teamA,
    teamAabr,
    teamB,
    teamBabr,
    date,
    time,
    goalsA,
    goalsB,
  })  : _teamA = teamA,
        _teamAabr = teamAabr,
        _teamB = teamB,
        _teamBabr = teamBabr,
        _date = date,
        _time = time,
        _goalsA = goalsA,
        _goalsB = goalsB,
        _id = id;

  get getId => _id;
  get getTeamA => _teamA;
  get getTeamAabr => _teamAabr;
  get getTeamB => _teamB;
  get getTeamBabr => _teamBabr;
  get getDate => _date;
  get getTime => _time;
  get getGoalsA => _goalsA;
  get getGoalsB => _goalsB;

  set setId(id) => _id = id;
  set setTeamA(teamA) => _teamA = teamA;
  set setTeamAabr(teamAabr) => _teamAabr = teamAabr;
  set setTeamB(teamB) => _teamB = teamB;
  set setTeamBabr(teamBabr) => _teamBabr = teamBabr;
  set setDate(date) => _date = date;
  set setTime(time) => _time = time;
  set setGoalsA(goalsA) => _goalsA = goalsA;
  set setGoalsB(goalsB) => _goalsB = goalsB;

  fromJson(game) {
    _id = game["id"];
    _date = game["date"];
    _teamA = game["home_team"]["full_name"];
    _teamAabr = game["home_team"]["abbreviation"];
    _teamB = game["visitor_team"]["full_name"];
    _teamBabr = game["visitor_team"]["abbreviation"];
    _goalsA = game["home_team_score"];
    _time = game["status"];
    _goalsB = game["visitor_team_score"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "date": _date,
      "home_team": {
        "abbreviation": _teamAabr,
        "full_name": _teamA,
      },
      "home_team_score": _goalsA,
      "status": _time,
      "visitor_team": {
        "abbreviation": _teamBabr,
        "full_name": _teamB,
      },
      "visitor_team_score": _goalsB
    };
  }
}
