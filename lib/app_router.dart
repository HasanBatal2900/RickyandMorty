import 'package:breaking_bad/buisness_logic/cubit/quotes_cubit.dart';
import 'package:breaking_bad/data/repos/Characters_Repo_Web_Services.dart';
import 'package:breaking_bad/data/repos/Quotes_Repo_Web_Services.dart';
import 'package:breaking_bad/data/web_services/Quotes_Web_Services.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:breaking_bad/presntation/screens/character_screen.dart';
import 'package:breaking_bad/presntation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'buisness_logic/cubit/charaters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';

class AppRouter {
  late CharactersRepo charactersRepo;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepo = CharactersRepo(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepo: charactersRepo);
  }

  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case characterRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const CharacterScreen(),
          ),
        );

      case detailsRoute:
        QuotesWebServices quotesWebServices = QuotesWebServices();
        QuotesRepo quotesRepo =
            QuotesRepo(quotesWebServices: quotesWebServices);
        final character = routeSettings.arguments as Character;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return BlocProvider(
              create: (context) => QuotesCubit(quotesRepo: quotesRepo),
              child: DetailScreen(character: character),
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            animation =
                CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animation);
            return ScaleTransition(
              scale: animation,
              alignment: Alignment.center,
              child: child,
            );
          },
        );
    }
  }
}
