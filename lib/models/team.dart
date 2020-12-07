class Team {
  String _teamTitle;
  String _city;
  String _name;
  String _division;
  String _conference;
  String _teamAbr;
  int _id;

  Team({
    id,
    teamAbr,
    teamTitle,
    city,
    name,
    division,
    conference,
  })  : _teamTitle = teamTitle,
        _city = city,
        _name = name,
        _division = division,
        _conference = conference,
        _id = id,
        _teamAbr = teamAbr;

  get getTeamTitle => _teamTitle;
  get getCity => _city;
  get getName => _name;
  get getDivision => _division;
  get getConference => _conference;
  get getId => _id;
  get getTeamAbr => _teamAbr;

  set setId(id) => _id = id;
  set setTeamAbr(teamAbr) => _teamAbr = teamAbr;
  set setCity(city) => _city = city;
  set setName(name) => _name = name;
  set setDivision(division) => _division = division;
  set setConference(conference) => _conference = conference;

  Map<String, dynamic> toJson() {
    return {
      "id": _id,
      "abbreviation": _teamAbr,
      "city": _city,
      "conference": _conference,
      "division": _division,
      "full_name": _teamTitle,
      "name": _name
    };
  }

  fromJson(Map<String, dynamic> team) {
    _id = team["id"];
    _teamAbr = team["abbreviation"];
    _city = team["city"];
    _conference = team["conference"];
    _division = team["division"];
    _teamTitle = team["full_name"];
    _name = team["name"];
  }
}
