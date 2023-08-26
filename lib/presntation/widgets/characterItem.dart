import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/constants/strings.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharacterItme extends StatelessWidget {
  const CharacterItme({super.key, required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, detailsRoute,arguments: character);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ColorSys.myWhite,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GridTile(
          child: Container(
            child: Hero(
              tag: character.charId,
              child: FadeInImage.assetNetwork(
                image: character.image,
                placeholder: "images/loading.gif",
                height: 500,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
            ),
          ),
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Opacity(
              opacity: 0.6,
              child: Container(
                height: 30,
                padding: const EdgeInsets.only(top: 6),
                width: double.infinity,
                color: Colors.black,
                child: Text(
                  character.actorName,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
