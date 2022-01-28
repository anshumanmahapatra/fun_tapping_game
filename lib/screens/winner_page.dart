import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/color_constant.dart';

import '../controller/controller.dart';


class WinnerPage extends StatelessWidget {
  final String? winner, loser;
  WinnerPage({required this.winner, required this.loser});
  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    ColorConstant colorConstant = Get.put(ColorConstant());
    controller.playWinningAudio();
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: colorConstant.kPrimary,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset("asset/lottie/finalwinner.json"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "Congratulations",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Text(
                    "$winner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You Brutally Crushed $loser",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 125,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: colorConstant.kSecondary,
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Play Again",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        controller.playImpButtonSound();
                        controller.onHomeScreen(true);
                        controller.getStats();
                        controller.playGameSound(
                            false, controller.isOnHomeScreen.value);
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
