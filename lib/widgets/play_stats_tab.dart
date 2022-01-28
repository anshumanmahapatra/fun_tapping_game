import 'package:flutter/material.dart';

class PlayStatsTab {
  Container getPlayStatsTab1(String title, int description, Color tabColor, Color textColor) {
    return Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: tabColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                
              ),
            ),
            SizedBox(height: 5,),
            Text(
              description.toString(),
              style: TextStyle(
                color: textColor,
              ),
            )
          ],
        ));
  }

  Container getPlayStatsTab2(String title, int description, int secDescription, Color tabColor, Color textColor) {
    return Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: tabColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              description.toString() + " / " + secDescription.toString(),
              style: TextStyle(
                color: textColor,
              ),
            )
          ],
        ));
  }
}
