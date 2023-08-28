import 'dart:developer';

import 'package:breaking_bad/buisness_logic/cubit/charaters_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/presntation/widgets/NoInternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../widgets/characterItem.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

late TextEditingController controller;

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  List<Character> filteredCharacters = [];

  void stopSearching() {
    setState(() {
      controller.clear();
      showSearchBar = false;
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedItmes(context, allCharacters);
        } else {
          return const Align(
            alignment: Alignment.bottomCenter,
            child: LinearProgressIndicator(
              color: ColorSys.myYellow,
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    BlocProvider.of<CharactersCubit>(context).getAllYourcharacters();
  }

  bool showSearchBar = false;

  getFilteredCharacters(String searchedCharacter) {
    setState(() {
      filteredCharacters = allCharacters.where((character) {
        return character.actorName.toLowerCase().startsWith(searchedCharacter);
      }).toList();
    });
  }

  Widget buildLoadedItmes(BuildContext context, List<Character> allCharacter) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
      physics: const ClampingScrollPhysics(),
      itemCount: filteredCharacters.isEmpty
          ? allCharacter.length
          : filteredCharacters.length,
      itemBuilder: (context, index) {
        log(allCharacter.length.toString());
        return CharacterItme(
          character: filteredCharacters.isEmpty
              ? allCharacter[index]
              : filteredCharacters[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: !showSearchBar
            ? [
                Center(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          showSearchBar = true;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: ColorSys.myGrey,
                      )),
                )
              ]
            : null,
        backgroundColor: ColorSys.myYellow,
        title: !showSearchBar
            ? const Text(
                "Characters",
                style: TextStyle(
                  color: ColorSys.myGrey,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: stopSearching,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorSys.myGrey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      cursorColor: ColorSys.myGrey,
                      decoration: const InputDecoration(
                        hintText: "Find A Character",
                        hintStyle:
                            TextStyle(color: ColorSys.myGrey, fontSize: 18),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: ColorSys.myWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        getFilteredCharacters(value);
                        log(filteredCharacters.length.toString());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: ColorSys.myGrey,
                    ),
                    onPressed: stopSearching,
                  ),
                ],
              ),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return const NoInternetMessage();
          }
        },
        child: const CircularProgressIndicator(
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
