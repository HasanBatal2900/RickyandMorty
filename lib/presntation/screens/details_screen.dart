import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/buisness_logic/cubit/quotes_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/models/quotes.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.character});

  final Character character;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Quotes> quotes = [];

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
        ]));
  }

  Widget buidDivider(double endPoint) {
    return Divider(
      height: 30,
      color: ColorSys.myYellow,
      thickness: 2,
      endIndent: endPoint,
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuotesCubit>(context).getAllQuotes();
  }

  @override
  Widget build(BuildContext context) {
    String date = "  " + widget.character.date.substring(0, 10);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            pinned: false,
            expandedHeight: 600,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    widget.character.actorName,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              background: Hero(
                tag: widget.character.charId,
                child: FadeInImage(
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.character.image),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCharacterInfo(
                          "Status : ", widget.character.statusIFDeadOrLive),
                      buidDivider(290),
                      buildCharacterInfo("Date Of Birth : ", date),
                      buidDivider(240),
                      buildCharacterInfo(
                          "Species : ", widget.character.species),
                      buidDivider(285),
                      buildCharacterInfo("Gender : ", widget.character.gender),
                      buidDivider(290),
                      buildCharacterInfo(
                        "Seasons : ",
                        ["1", "2", "3", "4", "5"].join("/"),
                      ),
                      buidDivider(280),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Best Quotes For ${widget.character.actorName} :",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      BlocBuilder<QuotesCubit, QuotesState>(
                        builder: (context, state) {
                          if (state is QuotesLoaded) {
                            quotes = state.allQuotes;
                            int rn = Random().nextInt(quotes.length);
                            return Center(
                                child: AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  quotes[rn].text,
                                  textStyle: const TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: ColorSys.myWhite,
                                  ),
                                  speed: const Duration(milliseconds: 200),
                                ),
                              ],
                              totalRepeatCount: 6,
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ));
                          } else {
                            return Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  color: ColorSys.myYellow,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 480,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
