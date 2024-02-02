import 'package:flutter/cupertino.dart';

import '../resourses/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final  VoidCallback onTap;
  final String text;
  const SecondaryActionButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border:
            Border.all(color: FightClubColors.darkGreyText, width: 2)),
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style:
          TextStyle(fontSize: 13, color: FightClubColors.darkGreyText, fontWeight: FontWeight.w400),
        ),
      ),

    );
  }
}


