import 'package:breaking_bad/app_router.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:flutter/material.dart';

import 'constants/strings.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(scaffoldBackgroundColor: ColorSys.myGrey),
      initialRoute: characterRoute,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

//? Another Way Add To every Screen static var int or string 
//? and add in routes inside the material app a map that contain like this
//?routes: {

// ?"/details":(context) =>const DetailScreen(),
//? "/character":(context) => const CharacterScreen(),
//? },
