
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class PlayButton {
  Container getPlayButton(int playerIndex) {
    Controller controller = Get.put(Controller());
    var size = Get.mediaQuery.size;
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              primary: playerIndex == 1
                  ? controller.player1Color
                  : controller.player2Color,
              minimumSize: playerIndex == 1
                  ? Size(size.width,
                      size.height * .40 + controller.sizeCounter1.value)
                  : Size(size.width,
                      size.height * .40 + controller.sizeCounter2.value),
            ),
            child: Center(
              child: Text(playerIndex == 1
                  ? controller.player1Name
                  : controller.player2Name),
            ),
            onPressed: () {
              HapticFeedback.vibrate();
              if (playerIndex == 1) {
                controller.playGameButtonSound(playerIndex);
                controller.tapCounter1();
              } else {
                controller.playGameButtonSound(playerIndex);
                controller.tapCounter2();
              }
            },
          ),
          SizedBox(
            height: 5,
          ),
          playerIndex == 1
              ? Text(
                  "Score : ${controller.scoreCounter1.value}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                )
              : Text(
                  "Score : ${controller.scoreCounter2.value}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
        ],
      ),
    );
  }
}
