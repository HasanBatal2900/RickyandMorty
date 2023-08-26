import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class Search extends StatelessWidget {
  const Search({super.key});




  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Expanded(
      child: TextField(
        controller: controller,
        cursorColor: ColorSys.myGrey,
        decoration: const InputDecoration(
          hintText: "Find A Character",
          hintStyle: TextStyle(color: ColorSys.myGrey, fontSize: 18),
          border: InputBorder.none,
        ),
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        onChanged: (value) {


        },
      ),
    );
  }
}
