import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetMessage extends StatefulWidget {
  const NoInternetMessage({super.key});

  @override
  State<NoInternetMessage> createState() => _NoInternetMessageState();
}

class _NoInternetMessageState extends State<NoInternetMessage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      lowerBound: 0.5,
    )..repeat();
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceIn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Image.asset(
              "images/no_net.png",
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text("Please Check Your Internet Conncetion !",
            style: GoogleFonts.ubuntuCondensed(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
