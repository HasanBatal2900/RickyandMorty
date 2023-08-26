class Character {
  late int charId; //
  late String date; //
  late String gender; // try to use enum
  late String image; //
  late String species; //try to use enum
  late String statusIFDeadOrLive; //
  late List<dynamic> episodeOfSeasons; //

  late String actorName;
  late String type;

  Character(
      {required this.actorName,
      required this.charId,
      required this.date,
      required this.gender,
      required this.episodeOfSeasons,
      required this.image,
      required this.species,
      required this.statusIFDeadOrLive,
      required this.type});

  Character.fromJson(Map<String, dynamic> json) {
    actorName = json["name"];
    statusIFDeadOrLive = json["status"];
    image = json["image"];
    gender = json["gender"];
    species = json["species"];
    type = json["type"];
    date = json["created"];
    charId = json["id"];
    episodeOfSeasons = json["episode"];
  }
}
