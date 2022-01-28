import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/play_controller.dart';
import '../controller/controller.dart';

import '../widgets/play_button.dart';



class PlayGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller controller = Get.put(Controller());
    PlayController playController = Get.put(PlayController());
    PlayButton playButton = Get.put(PlayButton());
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: controller.onBackPressed,
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: playButton.getPlayButton(2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      playButton.getPlayButton(1),
                    ],
                  ),
                ),
                Offstage(
                  offstage: playController.shouldShow.value,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black26,
                          Colors.white,
                        ],
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            RotateAnimatedText("3",
                                duration: Duration(seconds: 1),
                                textStyle: TextStyle(
                                    fontSize: 150, color: Colors.red)),
                            RotateAnimatedText("2",
                                duration: Duration(seconds: 1),
                                textStyle: TextStyle(
                                    fontSize: 150, color: Colors.yellow)),
                            RotateAnimatedText("1",
                                duration: Duration(seconds: 1),
                                textStyle: TextStyle(
                                    fontSize: 150, color: Colors.yellow)),
                            RotateAnimatedText("GO",
                                duration: Duration(milliseconds: 500),
                                textStyle: TextStyle(
                                    fontSize: 150, color: Colors.green)),
                          ],
                          totalRepeatCount: 1,
                          pause: Duration(seconds: 0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
